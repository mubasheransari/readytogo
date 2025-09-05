import 'dart:convert';



ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
    ProfessionalProfileModel.fromJson(json.decode(str) as Map<String, dynamic>);

String professionalProfileModelToJson(ProfessionalProfileModel data) =>
    json.encode(data.toJson());

class ProfessionalProfileModel {
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? userName;
  final String? profileImageUrl;
  final String? organizationName;
  final String? description;
  final DateTime? organizationJoiningDate;
  final List<GroupAssociation>? groupAssociations;

  /// Existing unified list for UI/logic. Items may carry `id`, `name`, or both.
  final List<SpecializationId>? specializationIds;

  /// NEW: direct names from GET, e.g. ["Periodontics", "Endodontics"].
  /// This does NOT change old behavior; it's just available if present.
  final List<String>? specializations;

  final List<Location>? locations;
  final dynamic organizationProfessionals;

  const ProfessionalProfileModel({
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.role,
    this.userName,
    this.profileImageUrl,
    this.organizationName,
    this.description,
    this.organizationJoiningDate,
    this.groupAssociations,
    this.specializationIds,
    this.specializations,
    this.locations,
    this.organizationProfessionals,
  });

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalProfileModel(
      firstname: json["firstname"] as String?,
      lastname: json["lastname"] as String?,
      email: json["email"] as String?,
      phoneNumber: json["phoneNumber"] as String?,
      role: json["role"] as String?,
      userName: json["userName"] as String?,
      profileImageUrl: json["profileImageUrl"] as String?,
      organizationName: json["organizationName"] as String?,
      description: json["description"] as String?,
      organizationJoiningDate: json["organizationJoiningDate"] != null
          ? DateTime.tryParse(json["organizationJoiningDate"] as String)
          : null,
      groupAssociations: (json["groupAssociations"] as List?)
              ?.map((x) => GroupAssociation.fromJson(x as Map<String, dynamic>))
              .toList() ??
          <GroupAssociation>[],
      // Keep your original normalization (ids/objects + names)
      specializationIds: _parseSpecializations(json),
      // NEW: store raw names array if backend sends it
      specializations: (json['specializations'] as List?)
              ?.map((e) => e?.toString())
              .whereType<String>()
              .toList() ??
          <String>[],
      locations: (json["locations"] as List?)
              ?.map((x) => Location.fromJson(x as Map<String, dynamic>))
              .toList() ??
          <Location>[],
      organizationProfessionals: json["organizationProfessionals"],
    );
  }

  /// NOTE: Kept unchanged on purpose (no "specializations" key added here).
  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phoneNumber": phoneNumber,
        "role": role,
        "userName": userName,
        "profileImageUrl": profileImageUrl,
        "organizationName": organizationName,
        "description": description,
        "organizationJoiningDate": organizationJoiningDate?.toIso8601String(),
        "groupAssociations": groupAssociations?.map((x) => x.toJson()).toList(),
        "specializationIds": specializationIds?.map((x) => x.toJson()).toList(),
        "locations": locations?.map((x) => x.toJson()).toList(),
        "organizationProfessionals": organizationProfessionals,
      };

  /// Optional helper if you ever want to serialize names as well (UI/caching).
  Map<String, dynamic> toJsonWithSpecializations() {
    final map = toJson();
    map["specializations"] = specializationNames;
    return map;
  }

  /// Build payload for EDIT API (PascalCase keys). Keeps old behavior.
  Map<String, dynamic> toUpdatePayload({
    required String userId,
    List<SpecializationId> catalog = const [],
  }) {
    final ids = resolveSpecializationIds(catalog: catalog);
    return {
      "UserId": userId,
      "FirstName": firstname,
      "LastName": lastname,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "Description": description,
      "ProfileImageUrl": profileImageUrl,
      "LocationsJson": jsonEncode(
        (locations ?? const <Location>[]).map((e) => e.toJson()).toList(),
      ),
      "SpecializationIds": ids, // array of IDs your API expects
      // "ProfessionalIds": ...
    };
  }

  /// Resolve to pure ID list using catalog to map names->ids when needed.
  List<String> resolveSpecializationIds({required List<SpecializationId> catalog}) {
    final out = <String>[];

    // name -> id
    final byName = <String, String>{
      for (final c in catalog)
        (c.name ?? '').toLowerCase(): (c.id ?? ''),
    };

    // 1) Take ids from specializationIds if present
    for (final s in specializationIds ?? const <SpecializationId>[]) {
      if ((s.id ?? '').isNotEmpty) {
        out.add(s.id!);
        continue;
      }
      if ((s.name ?? '').isNotEmpty) {
        final id = byName[s.name!.toLowerCase()];
        if (id!.isNotEmpty) out.add(id);
      }
    }

    // 2) Fallback to raw names array if no ids resolved
    if (out.isEmpty) {
      for (final n in specializations ?? const <String>[]) {
        final id = byName[n.toLowerCase()];
        if (id!.isNotEmpty) out.add(id);
      }
    }

    return out;
  }

  /// Original normalization: supports
  ///  - "specializationIds": ["uuid", ...] or [{"id":"uuid","name":"..."}, ...]
  ///  - "specializations": ["name", ...]
  static List<SpecializationId> _parseSpecializations(Map<String, dynamic> json) {
    final result = <SpecializationId>[];

    final rawIds = json['specializationIds'];
    if (rawIds is List) {
      for (final item in rawIds) {
        if (item is Map<String, dynamic>) {
          result.add(SpecializationId.fromJson(item));
        } else if (item is String) {
          result.add(SpecializationId(id: item));
        }
      }
    }

    final rawNames = json['specializations'];
    if (rawNames is List) {
      for (final item in rawNames) {
        if (item != null) {
          result.add(SpecializationId(name: item.toString()));
        }
      }
    }

    // De-duplicate: prefer entries with id; otherwise keep by name
    final dedup = <String, SpecializationId>{};
    for (final s in result) {
      final key = (s.id?.isNotEmpty ?? false)
          ? 'id:${s.id}'
          : 'name:${(s.name ?? '').toLowerCase()}';
      dedup[key] = s;
    }
    return dedup.values.toList();
  }

  ProfessionalProfileModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? profileImageUrlJson, // if server returns JSON string
    String? organizationName,
    String? description,
    DateTime? organizationJoiningDate,
    List<GroupAssociation>? groupAssociations,
    List<SpecializationId>? specializationIds,
    String? specializationIdsJson, // accepts JSON list of ids/objects/names
    List<String>? specializations,  // NEW: direct names list
    String? specializationsJson,    // NEW: JSON string (["Periodontics",...])
    String? locationJson,           // accepts JSON list of locations
    dynamic organizationProfessionals,
  }) {
    final updatedLocations = locationJson != null
        ? (jsonDecode(locationJson) as List<dynamic>)
            .map((e) => Location.fromJson(e as Map<String, dynamic>))
            .toList()
        : locations;

    final updatedSpecializationIds = () {
      if (specializationIds != null) return specializationIds;
      if (specializationIdsJson != null) {
        final raw = jsonDecode(specializationIdsJson) as List<dynamic>;
        return raw.map((e) => SpecializationId.fromFlexible(e)).toList();
      }
      return this.specializationIds;
    }();

    final updatedProfileImageUrl = profileImageUrlJson != null
        ? jsonDecode(profileImageUrlJson) as String
        : profileImageUrl;

    final updatedSpecializations = () {
      if (specializations != null) return specializations;
      if (specializationsJson != null) {
        final raw = jsonDecode(specializationsJson) as List<dynamic>;
        return raw.map((e) => e?.toString()).whereType<String>().toList();
      }
      return this.specializations;
    }();

    return ProfessionalProfileModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: updatedProfileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      organizationJoiningDate:
          organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializationIds: updatedSpecializationIds,
      specializations: updatedSpecializations, // NEW
      locations: updatedLocations,
      organizationProfessionals:
          organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}

/// Convenience getters (non-breaking).
extension ProfessionalProfileSpecializationsX on ProfessionalProfileModel {
  /// Prefer names on specializationIds; if empty, fall back to `specializations`.
  List<String> get specializationNames {
    final namesFromIds = (specializationIds ?? const <SpecializationId>[])
        .map((e) => e.name)
        .whereType<String>()
        .toList();
    if (namesFromIds.isNotEmpty) return namesFromIds;
    return (specializations ?? const <String>[]);
  }

  /// Ids useful for update requests.
  List<String> get specializationIdList =>
      (specializationIds ?? const <SpecializationId>[])
          .map((e) => e.id)
          .whereType<String>()
          .where((id) => id.isNotEmpty)
          .toList();
}

class GroupAssociation {
  final String? groupId;
  final String? groupName;
  final String? iconUrl;
  final int? memberCount;

  const GroupAssociation({
    this.groupId,
    this.groupName,
    this.iconUrl,
    this.memberCount,
  });

  factory GroupAssociation.fromJson(Map<String, dynamic> json) => GroupAssociation(
        groupId: json["groupId"] as String?,
        groupName: json["groupName"] as String?,
        iconUrl: json["iconUrl"] as String?,
        memberCount: json["memberCount"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "iconUrl": iconUrl,
        "memberCount": memberCount,
      };
}

class Location {
  final String? id;
  final String? streetAddress;
  final String? area;
  final String? city;
  final String? state;
  final String? zipCode;
  final double? latitude;
  final double? longitude;

  const Location({
    this.id,
    this.streetAddress,
    this.area,
    this.city,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"] as String?,
        streetAddress: json["streetAddress"] as String?,
        area: json["area"] as String?,
        city: json["city"] as String?,
        state: json["state"] as String?,
        zipCode: json["zipCode"] as String?,
        latitude: (json["latitude"] as num?)?.toDouble(),
        longitude: (json["longitude"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "streetAddress": streetAddress,
        "area": area,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "latitude": latitude,
        "longitude": longitude,
      };

  Location copyWith({
    String? id,
    String? streetAddress,
    String? area,
    String? city,
    String? state,
    String? zipCode,
    double? latitude,
    double? longitude,
  }) {
    return Location(
      id: id ?? this.id,
      streetAddress: streetAddress ?? this.streetAddress,
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class SpecializationId {
  final String? id;   // used for update
  final String? name; // nice for UI

  const SpecializationId({this.id, this.name});

  factory SpecializationId.fromJson(Map<String, dynamic> json) => SpecializationId(
        id: json["id"] as String?,
        name: json["name"] as String?,
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  /// Accepts: Map{id,name}, String uuid (id), or String name
  factory SpecializationId.fromFlexible(dynamic value) {
    if (value is Map<String, dynamic>) return SpecializationId.fromJson(value);
    if (value is String) {
      final looksUuid =
          value.length >= 32 && RegExp(r'^[0-9a-fA-F-]+$').hasMatch(value);
      return looksUuid ? SpecializationId(id: value) : SpecializationId(name: value);
    }
    throw ArgumentError('Unsupported specialization value: $value');
  }
}


/*ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
    ProfessionalProfileModel.fromJson(json.decode(str));

String professionalProfileModelToJson(ProfessionalProfileModel data) =>
    json.encode(data.toJson());

class ProfessionalProfileModel {
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? userName;
  final String? profileImageUrl;
  final String? organizationName;
  final String? description;
  final DateTime? organizationJoiningDate;
  final List<GroupAssociation>? groupAssociations;

  /// Unified list used by your UI. Each item may have `name`, `id`, or both.
  final List<SpecializationId>? specializationIds;

  final List<Location>? locations;
  final dynamic organizationProfessionals;

  ProfessionalProfileModel({
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.role,
    this.userName,
    this.profileImageUrl,
    this.organizationName,
    this.description,
    this.organizationJoiningDate,
    this.groupAssociations,
    this.specializationIds,
    this.locations,
    this.organizationProfessionals,
  });

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalProfileModel(
      firstname: json["firstname"],
      lastname: json["lastname"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      role: json["role"],
      userName: json["userName"],
      profileImageUrl: json["profileImageUrl"],
      organizationName: json["organizationName"],
      description: json["description"],
      organizationJoiningDate: json["organizationJoiningDate"] != null
          ? DateTime.tryParse(json["organizationJoiningDate"])
          : null,
      groupAssociations: (json["groupAssociations"] as List?)
              ?.map((x) => GroupAssociation.fromJson(x))
              .toList() ??
          [],
      // 👇 normalize both shapes into List<SpecializationId>
      specializationIds: _parseSpecializations(json),
      locations: (json["locations"] as List?)
              ?.map((x) => Location.fromJson(x))
              .toList() ??
          [],
      organizationProfessionals: json["organizationProfessionals"],
    );
  }

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "phoneNumber": phoneNumber,
        "role": role,
        "userName": userName,
        "profileImageUrl": profileImageUrl,
        "organizationName": organizationName,
        "description": description,
        "organizationJoiningDate": organizationJoiningDate?.toIso8601String(),
        "groupAssociations": groupAssociations?.map((x) => x.toJson()).toList(),
        // Keep a friendly JSON (not used for UPDATE API)
        "specializationIds":
            specializationIds?.map((x) => x.toJson()).toList(),
        "locations": locations?.map((x) => x.toJson()).toList(),
        "organizationProfessionals": organizationProfessionals,
      };

  /// Build the exact payload your EDIT API expects (PascalCase keys).
  /// Pass the full catalog (id+name) you already fetched for the dropdown.
  Map<String, dynamic> toUpdatePayload({
    required String userId,
    List<SpecializationId> catalog = const [],
    // add other fields your API wants here
  }) {
    final ids = resolveSpecializationIds(catalog: catalog);
    return {
      "UserId": userId,
      "FirstName": firstname,
      "LastName": lastname,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "Description": description,
      // "OrganizationId": ...,
      // "ProfileImage": ... (multipart handled elsewhere),
      "ProfileImageUrl": profileImageUrl,
      "LocationsJson": jsonEncode(locations?.map((e) => e.toJson()).toList() ?? []),
      "SpecializationIds": ids, // 👈 array of IDs for your edit API
      // "ProfessionalIds": ...
    };
  }

  /// Convert current specializations (names and/or ids) to a pure list of IDs,
  /// by matching names against the provided catalog when id is missing.
  List<String> resolveSpecializationIds({required List<SpecializationId> catalog}) {
    final out = <String>[];
    final byName = {
      for (final c in catalog)
        (c.name ?? '').toLowerCase(): c.id, // name->id
    };

    for (final s in specializationIds ?? const <SpecializationId>[]) {
      if (s.id != null && s.id!.isNotEmpty) {
        out.add(s.id!);
      } else if (s.name != null) {
        final id = byName[s.name!.toLowerCase()];
        if (id != null && id.isNotEmpty) out.add(id);
      }
    }
    return out;
  }

  static List<SpecializationId> _parseSpecializations(Map<String, dynamic> json) {
    final result = <SpecializationId>[];

    // Case A: some backends send objects/ids under "specializationIds"
    final rawIds = json['specializationIds'];
    if (rawIds is List) {
      for (final item in rawIds) {
        if (item is Map<String, dynamic>) {
          result.add(SpecializationId.fromJson(item));
        } else if (item is String) {
          result.add(SpecializationId(id: item)); // treat as raw id
        }
      }
    }

    // Case B: your GET returns names under "specializations"
    final rawNames = json['specializations'];
    if (rawNames is List) {
      for (final item in rawNames) {
        if (item != null) {
          result.add(SpecializationId(name: item.toString()));
        }
      }
    }

    // De-duplicate (prefer entries with id)
    final dedup = <String, SpecializationId>{};
    for (final s in result) {
      final key = (s.id?.isNotEmpty ?? false)
          ? 'id:${s.id}'
          : 'name:${(s.name ?? '').toLowerCase()}';
      dedup[key] = s;
    }
    return dedup.values.toList();
  }

  ProfessionalProfileModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? profileImageUrlJson, // if server returns JSON string
    String? organizationName,
    String? description,
    DateTime? organizationJoiningDate,
    List<GroupAssociation>? groupAssociations,
    List<SpecializationId>? specializationIds,
    String? specializationIdsJson, // accepts JSON list of ids/objects/names
    String? locationJson,          // accepts JSON list of locations
    dynamic organizationProfessionals,
  }) {
    final updatedLocations = locationJson != null
        ? (jsonDecode(locationJson) as List<dynamic>)
            .map((e) => Location.fromJson(e))
            .toList()
        : locations;

    final updatedSpecializations = () {
      if (specializationIds != null) return specializationIds;
      if (specializationIdsJson != null) {
        final raw = jsonDecode(specializationIdsJson) as List<dynamic>;
        return raw.map((e) => SpecializationId.fromFlexible(e)).toList();
      }
      return this.specializationIds;
    }();

    final updatedProfileImageUrl = profileImageUrlJson != null
        ? jsonDecode(profileImageUrlJson) as String
        : profileImageUrl;

    return ProfessionalProfileModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: updatedProfileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      organizationJoiningDate:
          organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializationIds: updatedSpecializations,
      locations: updatedLocations,
      organizationProfessionals:
          organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}

class GroupAssociation {
  final String? groupId;
  final String? groupName;
  final String? iconUrl;
  final int? memberCount;

  GroupAssociation({
    this.groupId,
    this.groupName,
    this.iconUrl,
    this.memberCount,
  });

  factory GroupAssociation.fromJson(Map<String, dynamic> json) =>
      GroupAssociation(
        groupId: json["groupId"],
        groupName: json["groupName"],
        iconUrl: json["iconUrl"],
        memberCount: json["memberCount"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "iconUrl": iconUrl,
        "memberCount": memberCount,
      };
}

class Location {
  final String? id;
  final String? streetAddress;
  final String? area;
  final String? city;
  final String? state;
  final String? zipCode;
  final double? latitude;
  final double? longitude;

  Location({
    this.id,
    this.streetAddress,
    this.area,
    this.city,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        streetAddress: json["streetAddress"],
        area: json["area"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "streetAddress": streetAddress,
        "area": area,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "latitude": latitude,
        "longitude": longitude,
      };

  Location copyWith({
    String? id,
    String? streetAddress,
    String? area,
    String? city,
    String? state,
    String? zipCode,
    double? latitude,
    double? longitude,
  }) {
    return Location(
      id: id ?? this.id,
      streetAddress: streetAddress ?? this.streetAddress,
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class SpecializationId {
  final String? id;   // used for update
  final String? name; // shown in GET as strings

  const SpecializationId({this.id, this.name});

  factory SpecializationId.fromJson(Map<String, dynamic> json) =>
      SpecializationId(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  /// Accepts: Map{id,name}, String uuid (id), or String name
  factory SpecializationId.fromFlexible(dynamic value) {
    if (value is Map<String, dynamic>) return SpecializationId.fromJson(value);
    if (value is String) {
      // naive UUID heuristic (just in case you ever get raw ids)
      final looksUuid =
          value.length >= 32 && RegExp(r'^[0-9a-fA-F-]+$').hasMatch(value);
      return looksUuid ? SpecializationId(id: value) : SpecializationId(name: value);
    }
    throw ArgumentError('Unsupported specialization value: $value');
  }
}
*/