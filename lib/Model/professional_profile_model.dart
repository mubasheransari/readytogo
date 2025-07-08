import 'dart:convert';

import 'dart:convert';

// JSON parse helpers
ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
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

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalProfileModel(
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
        specializationIds: (json["specializationIds"] as List?)
                ?.map((x) => SpecializationId.fromJson(x))
                .toList() ??
            [],
        locations: (json["locations"] as List?)
                ?.map((x) => Location.fromJson(x))
                .toList() ??
            [],
        organizationProfessionals: json["organizationProfessionals"],
      );

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

  ProfessionalProfileModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    String? description,
    DateTime? organizationJoiningDate,
    List<GroupAssociation>? groupAssociations,
    List<SpecializationId>? specializationIds, // ✅ object list
    String? specializationIdsJson, // ✅ json string input
    String? locationJson, // ✅ location json string
    dynamic organizationProfessionals,
  }) {
    final updatedLocations = locationJson != null
        ? (jsonDecode(locationJson) as List<dynamic>)
            .map((e) => Location.fromJson(e))
            .toList()
        : locations;

    final updatedSpecializationIds = specializationIdsJson != null
        ? (jsonDecode(specializationIdsJson) as List<dynamic>)
            .map((e) => SpecializationId.fromJson(e))
            .toList()
        : specializationIds ?? this.specializationIds;

    return ProfessionalProfileModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      organizationJoiningDate:
          organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializationIds: updatedSpecializationIds,
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
        latitude: json["latitude"],
        longitude: json["longitude"],
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
}

class SpecializationId {
  final String? id;
  final String? name;

  SpecializationId({
    this.id,
    this.name,
  });

  factory SpecializationId.fromJson(Map<String, dynamic> json) =>
      SpecializationId(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}


/*import 'dart:convert';

ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
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
  final List<String>? specializations;
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
    this.specializations,
    this.locations,
    this.organizationProfessionals,
  });

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalProfileModel(
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
        specializations: (json["specializations"] as List?)
                ?.map((x) => x.toString())
                .toList() ??
            [],
        locations: (json["locations"] as List?)
                ?.map((x) => Location.fromJson(x))
                .toList() ??
            [],
        organizationProfessionals: json["organizationProfessionals"],
      );

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
        "specializations": specializations,
        "locations": locations?.map((x) => x.toJson()).toList(),
        "organizationProfessionals": organizationProfessionals,
      };

  ProfessionalProfileModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    String? description,
    DateTime? organizationJoiningDate,
    List<GroupAssociation>? groupAssociations,
    List<String>? specializations,
    String? locationJson, // 👈 JSON string for locations
    dynamic organizationProfessionals,
  }) {
    final parsedLocations = locationJson != null
        ? (jsonDecode(locationJson) as List<dynamic>)
            .map((e) => Location.fromJson(e))
            .toList()
        : this.locations;

    return ProfessionalProfileModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      organizationJoiningDate:
          organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
      locations: parsedLocations,
      organizationProfessionals:
          organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}

class GroupAssociation {
  String groupId;
  String groupName;
  String iconUrl;
  int memberCount;

  GroupAssociation({
    required this.groupId,
    required this.groupName,
    required this.iconUrl,
    required this.memberCount,
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
  String id;
  String streetAddress;
  String area;
  String city;
  String state;
  String zipCode;
  double latitude;
  double longitude;

  Location({
    required this.id,
    required this.streetAddress,
    required this.area,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        streetAddress: json["streetAddress"],
        area: json["area"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
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
}
*/

/*ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
    ProfessionalProfileModel.fromJson(json.decode(str));

String professionalProfileModelToJson(ProfessionalProfileModel data) =>
    json.encode(data.toJson());

class ProfessionalProfileModel {
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? role;
  String? userName;
  String? profileImageUrl;
  String? organizationName;
  String? description;
  DateTime? organizationJoiningDate;
  List<GroupAssociation>? groupAssociations;
  List<String>? specializations;
  List<Location>? locations;
  dynamic organizationProfessionals;

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
    this.specializations,
    this.locations,
    this.organizationProfessionals,
  });

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalProfileModel(
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
        groupAssociations: json["groupAssociations"] != null
            ? List<GroupAssociation>.from(json["groupAssociations"]
                .map((x) => GroupAssociation.fromJson(x)))
            : null,
        specializations: json["specializations"] != null
            ? List<String>.from(json["specializations"])
            : null,
        locations: json["locations"] != null
            ? List<Location>.from(
                json["locations"].map((x) => Location.fromJson(x)))
            : null,
        organizationProfessionals: json["organizationProfessionals"],
      );

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
        "organizationJoiningDate":
            organizationJoiningDate?.toIso8601String(),
        "groupAssociations":
            groupAssociations?.map((x) => x.toJson()).toList(),
        "specializations": specializations,
        "locations": locations?.map((x) => x.toJson()).toList(),
        "organizationProfessionals": organizationProfessionals,
      };

  // ✅ copyWith method with locationJson
  ProfessionalProfileModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    String? description,
    DateTime? organizationJoiningDate,
    List<GroupAssociation>? groupAssociations,
    List<String>? specializations,
    String? locationJson, // 👈 used to update locations
    dynamic organizationProfessionals,
  }) {
    final decodedLocations = locationJson != null
        ? List<Location>.from(
            jsonDecode(locationJson).map((x) => Location.fromJson(x)))
        : locations;

    return ProfessionalProfileModel(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      organizationJoiningDate: organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
      locations: decodedLocations,
      organizationProfessionals: organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}

// GroupAssociation model
class GroupAssociation {
  String? groupId;
  String? groupName;
  String? iconUrl;
  int? memberCount;

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

// Location model
class Location {
  String? id;
  String? streetAddress;
  String? area;
  String? city;
  String? state;
  String? zipCode;
  num? latitude;
  num? longitude;

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
        latitude: json["latitude"],
        longitude: json["longitude"],
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
}
*/



/*ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
    ProfessionalProfileModel.fromJson(json.decode(str));

String professionalProfileModelToJson(ProfessionalProfileModel data) =>
    json.encode(data.toJson());

class ProfessionalProfileModel {
  String? firstname;
  String? lastname;
  String? email;
  String? phoneNumber;
  String? role;
  String? userName;
  String? profileImageUrl;
  String? organizationName;
  String? description;
  DateTime? organizationJoiningDate;
  List<GroupAssociation>? groupAssociations;
  List<String>? specializations;
  List<Location>? locations;
  dynamic organizationProfessionals;

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
    this.specializations,
    this.locations,
    this.organizationProfessionals,
  });

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfessionalProfileModel(
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
        groupAssociations: json["groupAssociations"] != null
            ? List<GroupAssociation>.from(json["groupAssociations"]
                .map((x) => GroupAssociation.fromJson(x)))
            : null,
        specializations: json["specializations"] != null
            ? List<String>.from(json["specializations"])
            : null,
        locations: json["locations"] != null
            ? List<Location>.from(
                json["locations"].map((x) => Location.fromJson(x)))
            : null,
        organizationProfessionals: json["organizationProfessionals"],
      );

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
        "organizationJoiningDate":
            organizationJoiningDate?.toIso8601String(),
        "groupAssociations":
            groupAssociations?.map((x) => x.toJson()).toList(),
        "specializations": specializations,
        "locations": locations?.map((x) => x.toJson()).toList(),
        "organizationProfessionals": organizationProfessionals,
      };
}

class GroupAssociation {
  String? groupId;
  String? groupName;
  String? iconUrl;
  int? memberCount;

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
  String? id;
  String? streetAddress;
  String? area;
  String? city;
  String? state;
  String? zipCode;
  num? latitude;
  num? longitude;

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
        latitude: json["latitude"],
        longitude: json["longitude"],
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
      
}
*/

/*import 'dart:convert';

ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
    ProfessionalProfileModel.fromJson(json.decode(str));

String professionalProfileModelToJson(ProfessionalProfileModel data) =>
    json.encode(data.toJson());

class ProfessionalProfileModel {
  final String userId; // ✅ Newly added
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String role;
  final String userName;
  final String profileImageUrl;
  final String organizationName;
  final String description;
  final dynamic organizationJoiningDate;
  final List<dynamic> groupAssociations;
  final dynamic specializations;
  final List<dynamic> locations;
  final dynamic organizationProfessionals;

  ProfessionalProfileModel({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.userName,
    required this.profileImageUrl,
    required this.organizationName,
    required this.description,
    required this.organizationJoiningDate,
    required this.groupAssociations,
    required this.specializations,
    required this.locations,
    required this.organizationProfessionals,
  });

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalProfileModel(
      userId: json["userId"] ?? '', // ✅ Newly added
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      description: json["description"] ?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations: List<dynamic>.from(json["groupAssociations"] ?? const []),
      specializations: json["specializations"],
      locations: List<dynamic>.from(json["locations"] ?? const []),
      organizationProfessionals: json["organizationProfessionals"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId, // ✅ Newly added
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "phoneNumber": phoneNumber,
      "role": role,
      "userName": userName,
      "profileImageUrl": profileImageUrl,
      "organizationName": organizationName,
      "description": description,
      "organizationJoiningDate": organizationJoiningDate,
      "groupAssociations": groupAssociations,
      "specializations": specializations,
      "locations": locations,
      "organizationProfessionals": organizationProfessionals,
    };
  }

  ProfessionalProfileModel copyWith({
    String? userId,
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    String? description,
    dynamic organizationJoiningDate,
    List<dynamic>? groupAssociations,
    dynamic specializations,
    List<dynamic>? locations,
    dynamic organizationProfessionals,
  }) {
    return ProfessionalProfileModel(
      userId: userId ?? this.userId,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      description: description ?? this.description,
      organizationJoiningDate:
          organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
      locations: locations ?? this.locations,
      organizationProfessionals:
          organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}*/


// ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
//     ProfessionalProfileModel.fromJson(json.decode(str));

// String professionalProfileModelToJson(ProfessionalProfileModel data) =>
//     json.encode(data.toJson());

// class ProfessionalProfileModel {
//   final String userId; // ✅ Newly added
//   final String firstname;
//   final String lastname;
//   final String email;
//   final String phoneNumber;
//   final String role;
//   final String userName;
//   final String profileImageUrl;
//   final String organizationName;
//   final String description;
//   final dynamic organizationJoiningDate;
//   final List<dynamic> groupAssociations;
//   final List<dynamic> specializations;
//   final List<dynamic> locations;
//   final dynamic organizationProfessionals;

//   ProfessionalProfileModel({
//     required this.userId,
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.phoneNumber,
//     required this.role,
//     required this.userName,
//     required this.profileImageUrl,
//     required this.organizationName,
//     required this.description,
//     required this.organizationJoiningDate,
//     required this.groupAssociations,
//     required this.specializations,
//     required this.locations,
//     required this.organizationProfessionals,
//   });

//   factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfessionalProfileModel(
//       userId: json["userId"] ?? '', // ✅ Newly added
//       firstname: json["firstname"] ?? '',
//       lastname: json["lastname"] ?? '',
//       email: json["email"] ?? '',
//       phoneNumber: json["phoneNumber"] ?? '',
//       role: json["role"] ?? '',
//       userName: json["userName"] ?? '',
//       profileImageUrl: json["profileImageUrl"] ?? '',
//       organizationName: json["organizationName"] ?? '',
//       description: json["description"] ?? '',
//       organizationJoiningDate: json["organizationJoiningDate"],
//       groupAssociations: List<dynamic>.from(json["groupAssociations"] ?? const []),
//       specializations: List<dynamic>.from(json["specializations"] ?? const []),
//       locations: List<dynamic>.from(json["locations"] ?? const []),
//       organizationProfessionals: json["organizationProfessionals"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "userId": userId, // ✅ Newly added
//       "firstname": firstname,
//       "lastname": lastname,
//       "email": email,
//       "phoneNumber": phoneNumber,
//       "role": role,
//       "userName": userName,
//       "profileImageUrl": profileImageUrl,
//       "organizationName": organizationName,
//       "description": description,
//       "organizationJoiningDate": organizationJoiningDate,
//       "groupAssociations": groupAssociations,
//       "specializations": specializations,
//       "locations": locations,
//       "organizationProfessionals": organizationProfessionals,
//     };
//   }

//   ProfessionalProfileModel copyWith({
//     String? userId,
//     String? firstname,
//     String? lastname,
//     String? email,
//     String? phoneNumber,
//     String? role,
//     String? userName,
//     String? profileImageUrl,
//     String? organizationName,
//     String? description,
//     dynamic organizationJoiningDate,
//     List<dynamic>? groupAssociations,
//     List<dynamic>? specializations,
//     List<dynamic>? locations,
//     dynamic organizationProfessionals,
//   }) {
//     return ProfessionalProfileModel(
//       userId: userId ?? this.userId,
//       firstname: firstname ?? this.firstname,
//       lastname: lastname ?? this.lastname,
//       email: email ?? this.email,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       role: role ?? this.role,
//       userName: userName ?? this.userName,
//       profileImageUrl: profileImageUrl ?? this.profileImageUrl,
//       organizationName: organizationName ?? this.organizationName,
//       description: description ?? this.description,
//       organizationJoiningDate: organizationJoiningDate ?? this.organizationJoiningDate,
//       groupAssociations: groupAssociations ?? this.groupAssociations,
//       specializations: specializations ?? this.specializations,
//       locations: locations ?? this.locations,
//       organizationProfessionals: organizationProfessionals ?? this.organizationProfessionals,
//     );
//   }
// }


/*ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
    ProfessionalProfileModel.fromJson(json.decode(str));

String professionalProfileModelToJson(ProfessionalProfileModel data) =>
    json.encode(data.toJson());

class ProfessionalProfileModel {
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String role;
  final String userName;
  final String profileImageUrl;
  final String organizationName;
  final String description;
  final dynamic organizationJoiningDate;
  final List<GroupAssociation> groupAssociations;
  final List<String> specializations;
  final List<dynamic> locations;
  final dynamic organizationProfessionals;

  ProfessionalProfileModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.userName,
    required this.profileImageUrl,
    required this.organizationName,
    required this.description,
    required this.organizationJoiningDate,
    required this.groupAssociations,
    required this.specializations,
    required this.locations,
    required this.organizationProfessionals,
  });

  factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalProfileModel(
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      description : json["description"]?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations: (json["groupAssociations"] ?? [])
          .map<GroupAssociation>((x) => GroupAssociation.fromJson(x))
          .toList(),
      specializations: List<String>.from(json["specializations"] ?? const []),
      locations: List<dynamic>.from(json["locations"] ?? const []),
      organizationProfessionals: json["organizationProfessionals"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "phoneNumber": phoneNumber,
      "role": role,
      "userName": userName,
      "profileImageUrl": profileImageUrl,
      "organizationName": organizationName,
      "description":description,
      "organizationJoiningDate": organizationJoiningDate,
      "groupAssociations": groupAssociations.map((x) => x.toJson()).toList(),
      "specializations": specializations,
      "locations": locations,
      "organizationProfessionals": organizationProfessionals,
    };
  }
}

class GroupAssociation {
  final String groupName;
  final String iconUrl;
  final int memberCount;

  GroupAssociation({
    required this.groupName,
    required this.iconUrl,
    required this.memberCount,
  });

  factory GroupAssociation.fromJson(Map<String, dynamic> json) {
    return GroupAssociation(
      groupName: json["groupName"] ?? '',
      iconUrl: json["iconUrl"] ?? '',
      memberCount: json["memberCount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "groupName": groupName,
      "iconUrl": iconUrl,
      "memberCount": memberCount,
    };
  }
}*/



// import 'dart:convert';

// ProfessionalProfileModel professionalProfileModelFromJson(String str) => ProfessionalProfileModel.fromJson(json.decode(str));

// String professionalProfileModelToJson(ProfessionalProfileModel data) => json.encode(data.toJson());

// class ProfessionalProfileModel {
//     String firstname;
//     String lastname;
//     String email;
//     String phoneNumber;
//     String role;
//     String userName;
//     String profileImageUrl;
//     String organizationName;
//     DateTime organizationJoiningDate;
//     List<GroupAssociation> groupAssociations;
//     List<String> specializations;
//     List<dynamic> locations;
//     dynamic organizationProfessionals;

//     ProfessionalProfileModel({
//         required this.firstname,
//         required this.lastname,
//         required this.email,
//         required this.phoneNumber,
//         required this.role,
//         required this.userName,
//         required this.profileImageUrl,
//         required this.organizationName,
//         required this.organizationJoiningDate,
//         required this.groupAssociations,
//         required this.specializations,
//         required this.locations,
//         required this.organizationProfessionals,
//     });

//     factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) => ProfessionalProfileModel(
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         email: json["email"],
//         phoneNumber: json["phoneNumber"],
//         role: json["role"],
//         userName: json["userName"],
//         profileImageUrl: json["profileImageUrl"],
//         organizationName: json["organizationName"],
//         organizationJoiningDate: DateTime.parse(json["organizationJoiningDate"]),
//         groupAssociations: List<GroupAssociation>.from(json["groupAssociations"].map((x) => GroupAssociation.fromJson(x))),
//         specializations: List<String>.from(json["specializations"].map((x) => x)),
//         locations: List<dynamic>.from(json["locations"].map((x) => x)),
//         organizationProfessionals: json["organizationProfessionals"],
//     );

//     Map<String, dynamic> toJson() => {
//         "firstname": firstname,
//         "lastname": lastname,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "role": role,
//         "userName": userName,
//         "profileImageUrl": profileImageUrl,
//         "organizationName": organizationName,
//         "organizationJoiningDate": organizationJoiningDate.toIso8601String(),
//         "groupAssociations": List<dynamic>.from(groupAssociations.map((x) => x.toJson())),
//         "specializations": List<dynamic>.from(specializations.map((x) => x)),
//         "locations": List<dynamic>.from(locations.map((x) => x)),
//         "organizationProfessionals": organizationProfessionals,
//     };
// }

// class GroupAssociation {
//     String groupName;
//     String iconUrl;
//     int memberCount;

//     GroupAssociation({
//         required this.groupName,
//         required this.iconUrl,
//         required this.memberCount,
//     });

//     factory GroupAssociation.fromJson(Map<String, dynamic> json) => GroupAssociation(
//         groupName: json["groupName"],
//         iconUrl: json["iconUrl"],
//         memberCount: json["memberCount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "groupName": groupName,
//         "iconUrl": iconUrl,
//         "memberCount": memberCount,
//     };
// }
