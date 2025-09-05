import 'dart:convert';

import 'professional_profile_model.dart';

OrganizationProfileModel organizationProfileModelFromJson(String str) =>
    OrganizationProfileModel.fromJson(json.decode(str));

String organizationProfileModelToJson(OrganizationProfileModel data) =>
    json.encode(data.toJson());

class OrganizationProfileModel {
  final String userId;
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String role;
  final String userName;
  final String profileImageUrl;
  final String organizationName;
  final String description;
  final String website;
  final dynamic organizationJoiningDate;
  final List<GroupAssociation> groupAssociations;
  final dynamic specializations;
  late final List<Location> locations;
  final List<dynamic> organizationProfessionals;

  OrganizationProfileModel({
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
    required this.website,
    required this.organizationJoiningDate,
    required this.groupAssociations,
    required this.specializations,
    required this.locations,
    required this.organizationProfessionals,
  });

  factory OrganizationProfileModel.fromJson(Map<String, dynamic> json) {
    return OrganizationProfileModel(
      userId: json["userId"] ?? '',
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      description: json["description"] ?? '',
      website: json["website"] ?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations: List<GroupAssociation>.from(
        (json["groupAssociations"] ?? [])
            .map((x) => GroupAssociation.fromJson(x)),
      ),
      specializations: json["specializations"],
      locations: List<Location>.from(
        (json["locations"] ?? []).map((x) => Location.fromJson(x)),
      ),
      organizationProfessionals:
          List<dynamic>.from(json["organizationProfessionals"] ?? const []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "phoneNumber": phoneNumber,
      "role": role,
      "userName": userName,
      "profileImageUrl": profileImageUrl,
      "organizationName": organizationName,
      "description": description,
      "website": website,
      "organizationJoiningDate": organizationJoiningDate,
      "groupAssociations":
          List<dynamic>.from(groupAssociations.map((x) => x.toJson())),
      "specializations": specializations,
      "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      "organizationProfessionals": organizationProfessionals,
    };
  }

  OrganizationProfileModel copyWith({
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
    String? website,
    dynamic organizationJoiningDate,
    List<GroupAssociation>? groupAssociations,
    dynamic specializations,
    String? locationJson, // JSON string for updating locations
    List<Location>? locations,
    List<dynamic>? organizationProfessionals,
  }) {
    final updatedLocations = locationJson != null
        ? List<Location>.from(
            (jsonDecode(locationJson) as List).map((x) => Location.fromJson(x)),
          )
        : locations ?? this.locations;

    return OrganizationProfileModel(
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
      website: website ?? this.website,
      organizationJoiningDate:
          organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
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
