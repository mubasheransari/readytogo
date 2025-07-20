import 'dart:convert';
import 'package:readytogo/Model/professional_profile_model.dart';

List<SavedSearchModel> savedSearchModelFromJson(String str) =>
    List<SavedSearchModel>.from(json.decode(str).map((x) => SavedSearchModel.fromJson(x)));

String savedSearchModelToJson(List<SavedSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SavedSearchModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? memberType;
  String? email;
  String? phoneNumber;
  String? profileImageUrl;
  DateTime? memberSince;
  bool? isSaved;
  dynamic distanceKm;
  List<Location>? locations;
  List<String>? services;

  SavedSearchModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.memberType,
    this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.memberSince,
    this.isSaved,
    this.distanceKm,
    this.locations,
    this.services,
  });

  factory SavedSearchModel.fromJson(Map<String, dynamic> json) => SavedSearchModel(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        memberType: json["memberType"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profileImageUrl: json["profileImageUrl"],
        memberSince: json["memberSince"] != null ? DateTime.tryParse(json["memberSince"]) : null,
        isSaved: json["isSaved"],
        distanceKm: json["distanceKm"],
        locations: json["locations"] != null
            ? List<Location>.from(json["locations"].map((x) => Location.fromJson(x)))
            : null,
        services: json["services"] != null
            ? List<String>.from(json["services"].map((x) => x.toString()))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "memberType": memberType,
        "email": email,
        "phoneNumber": phoneNumber,
        "profileImageUrl": profileImageUrl,
        "memberSince": memberSince?.toIso8601String(),
        "isSaved": isSaved,
        "distanceKm": distanceKm,
        "locations": locations != null
            ? List<dynamic>.from(locations!.map((x) => x.toJson()))
            : null,
        "services": services != null
            ? List<dynamic>.from(services!.map((x) => x))
            : null,
      };
}

/*class Location {
  String? id;
  String? streetAddress;
  String? area;
  String? city;
  String? state;
  String? zipCode;
  double? latitude;
  double? longitude;

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
        latitude: json["latitude"] != null ? json["latitude"].toDouble() : null,
        longitude: json["longitude"] != null ? json["longitude"].toDouble() : null,
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
// List<SavedSearchModel> savedSearchModelFromJson(String str) =>
//     List<SavedSearchModel>.from(json.decode(str).map((x) => SavedSearchModel.fromJson(x)));

// String savedSearchModelToJson(List<SavedSearchModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class SavedSearchModel {
//   final String userId;
//   final String firstName;
//   final String lastName;
//   final String memberType;
//   final String email;
//   final String phoneNumber;
//   final String? profileImageUrl;
//   final DateTime memberSince;
//   final bool isSaved;
//   final dynamic distanceKm;
//   final List<Location> locations;
//   final List<String> services;

//   SavedSearchModel({
//     required this.userId,
//     required this.firstName,
//     required this.lastName,
//     required this.memberType,
//     required this.email,
//     required this.phoneNumber,
//     this.profileImageUrl,
//     required this.memberSince,
//     required this.isSaved,
//     this.distanceKm,
//     required this.locations,
//     required this.services,
//   });

//   factory SavedSearchModel.fromJson(Map<String, dynamic> json) => SavedSearchModel(
//         userId: json["userId"] ?? '',
//         firstName: json["firstName"] ?? '',
//         lastName: json["lastName"] ?? '',
//         memberType: json["memberType"] ?? '',
//         email: json["email"] ?? '',
//         phoneNumber: json["phoneNumber"] ?? '',
//         profileImageUrl: json["profileImageUrl"],
//         memberSince: DateTime.tryParse(json["memberSince"] ?? '') ?? DateTime.now(),
//         isSaved: json["isSaved"] ?? false,
//         distanceKm: json["distanceKm"],
//         locations: json["locations"] != null
//             ? List<Location>.from(json["locations"].map((x) => Location.fromJson(x)))
//             : [],
//         services: json["services"] != null
//             ? List<String>.from(json["services"].map((x) => x.toString()))
//             : [],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "firstName": firstName,
//         "lastName": lastName,
//         "memberType": memberType,
//         "email": email,
//         "phoneNumber": phoneNumber,
//         "profileImageUrl": profileImageUrl,
//         "memberSince": memberSince.toIso8601String(),
//         "isSaved": isSaved,
//         "distanceKm": distanceKm,
//         "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
//         "services": List<dynamic>.from(services.map((x) => x)),
//       };
// }

// class Location {
//   final String id;
//   final String streetAddress;
//   final String area;
//   final String city;
//   final String state;
//   final String zipCode;
//   final double latitude;
//   final double longitude;

//   Location({
//     required this.id,
//     required this.streetAddress,
//     required this.area,
//     required this.city,
//     required this.state,
//     required this.zipCode,
//     required this.latitude,
//     required this.longitude,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//         id: json["id"] ?? '',
//         streetAddress: json["streetAddress"] ?? '',
//         area: json["area"] ?? '',
//         city: json["city"] ?? '',
//         state: json["state"] ?? '',
//         zipCode: json["zipCode"] ?? '',
//         latitude: (json["latitude"] != null) ? json["latitude"].toDouble() : 0.0,
//         longitude: (json["longitude"] != null) ? json["longitude"].toDouble() : 0.0,
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
