import 'dart:convert';
import 'package:readytogo/Model/professional_profile_model.dart';

OrganizationProfileModel organizationProfileModelFromJson(String str) =>
    OrganizationProfileModel.fromJson(json.decode(str));

String organizationProfileModelToJson(OrganizationProfileModel data) =>
    json.encode(data.toJson());

class OrganizationProfileModel {
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? userName;
  final dynamic profileImageUrl;
  final String? organizationName;
  final String? description;
  final dynamic organizationJoiningDate;
  final List<GroupAssociation>? groupAssociations;
  final dynamic specializations;
  final List<Location>? locations;
  final List<dynamic>? organizationProfessionals;

  OrganizationProfileModel({
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

  factory OrganizationProfileModel.fromJson(Map<String, dynamic> json) =>
      OrganizationProfileModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        role: json["role"],
        userName: json["userName"],
        profileImageUrl: json["profileImageUrl"],
        organizationName: json["organizationName"],
        description: json["description"],
        organizationJoiningDate: json["organizationJoiningDate"],
        groupAssociations: json["groupAssociations"] == null
            ? []
            : List<GroupAssociation>.from(json["groupAssociations"]
                .map((x) => GroupAssociation.fromJson(x))),
        specializations: json["specializations"],
        locations: json["locations"] == null
            ? []
            : List<Location>.from(
                json["locations"].map((x) => Location.fromJson(x))),
        organizationProfessionals: json["organizationProfessionals"] == null
            ? []
            : List<dynamic>.from(json["organizationProfessionals"]),
      );//10@Testing

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
        "organizationJoiningDate": organizationJoiningDate,
        "groupAssociations": groupAssociations == null
            ? []
            : List<dynamic>.from(groupAssociations!.map((x) => x.toJson())),
        "specializations": specializations,
        "locations": locations == null
            ? []
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
        "organizationProfessionals":
            organizationProfessionals == null ? [] : organizationProfessionals,
      };
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

// class Location {
//   final String? id;
//   final String? streetAddress;
//   final String? area;
//   final String? city;
//   final String? state;
//   final String? zipCode;
//   final int? latitude;
//   final int? longitude;

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
