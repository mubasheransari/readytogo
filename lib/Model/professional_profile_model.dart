import 'dart:convert';

ProfessionalProfileModel professionalProfileModelFromJson(String str) =>
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
}



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
