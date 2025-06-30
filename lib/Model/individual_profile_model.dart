import 'dart:convert';

IndividualProfileModel individualProfileModelFromJson(String str) =>
    IndividualProfileModel.fromJson(json.decode(str));

String individualProfileModelToJson(IndividualProfileModel data) =>
    json.encode(data.toJson());

class IndividualProfileModel {
  final String firstname;
  final String lastname;
  final String email;
  final String phoneNumber;
  final String role;
  final String userName;
  final String profileImageUrl;
  final String organizationName;
  final dynamic organizationJoiningDate;
  final List<dynamic> groupAssociations;
  final dynamic specializations;
  final List<dynamic> locations;
  final dynamic organizationProfessionals;

  IndividualProfileModel({
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

  factory IndividualProfileModel.fromJson(Map<String, dynamic> json) {
    return IndividualProfileModel(
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations:
          List<dynamic>.from(json["groupAssociations"] ?? const []),
      specializations: json["specializations"],
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
      "groupAssociations": groupAssociations,
      "specializations": specializations,
      "locations": locations,
      "organizationProfessionals": organizationProfessionals,
    };
  }
}
