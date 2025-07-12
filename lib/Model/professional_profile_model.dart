import 'dart:convert';


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
    String? profileImageUrlJson, // ✅ new JSON input for profileImageUrl
    String? organizationName,
    String? description,
    DateTime? organizationJoiningDate,
    List<GroupAssociation>? groupAssociations,
    List<SpecializationId>? specializationIds,
    String? specializationIdsJson, // ✅ json input
    String? locationJson,          // ✅ json input
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
    List<SpecializationId>? specializationIds,
    String? specializationIdsJson, // ✅ Accepts JSON string input
    String? locationJson,          // ✅ Accepts JSON string input
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
}*/


// import 'dart:convert';

// ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
//     ProfessionalProfileModel.fromJson(json.decode(str));

// String professionalProfileModelToJson(ProfessionalProfileModel data) =>
//     json.encode(data.toJson());

// class ProfessionalProfileModel {
//   final String? firstname;
//   final String? lastname;
//   final String? email;
//   final String? phoneNumber;
//   final String? role;
//   final String? userName;
//   final String? profileImageUrl;
//   final String? organizationName;
//   final String? description;
//   final DateTime? organizationJoiningDate;
//   final List<GroupAssociation>? groupAssociations;
//   final List<SpecializationId>? specializationIds;
//   final List<Location>? locations;
//   final dynamic organizationProfessionals;

//   ProfessionalProfileModel({
//     this.firstname,
//     this.lastname,
//     this.email,
//     this.phoneNumber,
//     this.role,
//     this.userName,
//     this.profileImageUrl,
//     this.organizationName,
//     this.description,
//     this.organizationJoiningDate,
//     this.groupAssociations,
//     this.specializationIds,
//     this.locations,
//     this.organizationProfessionals,
//   });

//   factory ProfessionalProfileModel.fromJson(Map<String, dynamic> json) =>
//       ProfessionalProfileModel(
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         email: json["email"],
//         phoneNumber: json["phoneNumber"],
//         role: json["role"],
//         userName: json["userName"],
//         profileImageUrl: json["profileImageUrl"],
//         organizationName: json["organizationName"],
//         description: json["description"],
//         organizationJoiningDate: json["organizationJoiningDate"] != null
//             ? DateTime.tryParse(json["organizationJoiningDate"])
//             : null,
//         groupAssociations: (json["groupAssociations"] as List?)
//                 ?.map((x) => GroupAssociation.fromJson(x))
//                 .toList() ??
//             [],
//         specializationIds: (json["specializationIds"] as List?)
//                 ?.map((x) => SpecializationId.fromJson(x))
//                 .toList() ??
//             [],
//         locations: (json["locations"] as List?)
//                 ?.map((x) => Location.fromJson(x))
//                 .toList() ??
//             [],
//         organizationProfessionals: json["organizationProfessionals"],
//       );

//   Map<String, dynamic> toJson() => {
//         "firstname": firstname,
//         "lastname": lastname,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "role": role,
//         "userName": userName,
//         "profileImageUrl": profileImageUrl,
//         "organizationName": organizationName,
//         "description": description,
//         "organizationJoiningDate": organizationJoiningDate?.toIso8601String(),
//         "groupAssociations": groupAssociations?.map((x) => x.toJson()).toList(),
//         "specializationIds": specializationIds?.map((x) => x.toJson()).toList(),
//         "locations": locations?.map((x) => x.toJson()).toList(),
//         "organizationProfessionals": organizationProfessionals,
//       };

//   ProfessionalProfileModel copyWith({
//     String? firstname,
//     String? lastname,
//     String? email,
//     String? phoneNumber,
//     String? role,
//     String? userName,
//     String? profileImageUrl,
//     String? organizationName,
//     String? description,
//     DateTime? organizationJoiningDate,
//     List<GroupAssociation>? groupAssociations,
//     List<SpecializationId>? specializationIds, // ✅ object list
//     String? specializationIdsJson, // ✅ json string input
//     String? locationJson, // ✅ location json string
//     dynamic organizationProfessionals,
//   }) {
//     final updatedLocations = locationJson != null
//         ? (jsonDecode(locationJson) as List<dynamic>)
//             .map((e) => Location.fromJson(e))
//             .toList()
//         : locations;

//     final updatedSpecializationIds = specializationIdsJson != null
//         ? (jsonDecode(specializationIdsJson) as List<dynamic>)
//             .map((e) => SpecializationId.fromJson(e))
//             .toList()
//         : specializationIds ?? this.specializationIds;

//     return ProfessionalProfileModel(
//       firstname: firstname ?? this.firstname,
//       lastname: lastname ?? this.lastname,
//       email: email ?? this.email,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       role: role ?? this.role,
//       userName: userName ?? this.userName,
//       profileImageUrl: profileImageUrl ?? this.profileImageUrl,
//       organizationName: organizationName ?? this.organizationName,
//       description: description ?? this.description,
//       organizationJoiningDate:
//           organizationJoiningDate ?? this.organizationJoiningDate,
//       groupAssociations: groupAssociations ?? this.groupAssociations,
//       specializationIds: updatedSpecializationIds,
//       locations: updatedLocations,
//       organizationProfessionals:
//           organizationProfessionals ?? this.organizationProfessionals,
//     );
//   }
// }

// class GroupAssociation {
//   final String? groupId;
//   final String? groupName;
//   final String? iconUrl;
//   final int? memberCount;

//   GroupAssociation({
//     this.groupId,
//     this.groupName,
//     this.iconUrl,
//     this.memberCount,
//   });

//   factory GroupAssociation.fromJson(Map<String, dynamic> json) =>
//       GroupAssociation(
//         groupId: json["groupId"],
//         groupName: json["groupName"],
//         iconUrl: json["iconUrl"],
//         memberCount: json["memberCount"],
//       );

//   Map<String, dynamic> toJson() => {
//         "groupId": groupId,
//         "groupName": groupName,
//         "iconUrl": iconUrl,
//         "memberCount": memberCount,
//       };
// }

// class Location {
//   final String? id;
//   final String? streetAddress;
//   final String? area;
//   final String? city;
//   final String? state;
//   final String? zipCode;
//   final double? latitude;
//   final double? longitude;

//   Location({
//     this.id,
//     this.streetAddress,
//     this.area,
//     this.city,
//     this.state,
//     this.zipCode,
//     this.latitude,
//     this.longitude,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//         id: json["id"],
//         streetAddress: json["streetAddress"],
//         area: json["area"],
//         city: json["city"],
//         state: json["state"],
//         zipCode: json["zipCode"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "streetAddress": streetAddress,
//         "area": area,
//         "city": city,
//         "state": state,
//         "zipCode": zipCode,
//         "latitude": latitude,
//         "longitude": longitude,
//       };
// }

// class SpecializationId {
//   final String? id;
//   final String? name;

//   SpecializationId({
//     this.id,
//     this.name,
//   });

//   factory SpecializationId.fromJson(Map<String, dynamic> json) =>
//       SpecializationId(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
