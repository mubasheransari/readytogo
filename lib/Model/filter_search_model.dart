import 'dart:convert';

List<FilterSearchModel> filterSearchModelFromJson(String str) =>
    List<FilterSearchModel>.from(json.decode(str).map((x) => FilterSearchModel.fromJson(x)));

String filterSearchModelToJson(List<FilterSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterSearchModel {
  final String userId;
  final String firstName;
  final String lastName;
  final dynamic memberType;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final dynamic memberSince;
  final bool isSaved;
  final dynamic distanceKm;
  final List<Location> locations;
  final dynamic services;

  FilterSearchModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.memberType,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.memberSince,
    required this.isSaved,
    required this.distanceKm,
    required this.locations,
    required this.services,
  });

  factory FilterSearchModel.fromJson(Map<String, dynamic> json) => FilterSearchModel(
        userId: json["userId"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        memberType: json["memberType"],
        email: json["email"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        profileImageUrl: json["profileImageUrl"],
        memberSince: json["memberSince"],
        isSaved: json["isSaved"] ?? false,
        distanceKm: json["distanceKm"],
        locations: (json["locations"] as List<dynamic>?)
                ?.map((x) => Location.fromJson(x))
                .toList() ??
            [],
        services: json["services"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "memberType": memberType,
        "email": email,
        "phoneNumber": phoneNumber,
        "profileImageUrl": profileImageUrl,
        "memberSince": memberSince,
        "isSaved": isSaved,
        "distanceKm": distanceKm,
        "locations": locations.map((x) => x.toJson()).toList(),
        "services": services,
      };
}

class Location {
  final String id;
  final String? streetAddress;
  final String? area;
  final String? city;
  final String? state;
  final String zipCode;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    this.streetAddress,
    this.area,
    this.city,
    this.state,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"] ?? '',
        streetAddress: json["streetAddress"],
        area: json["area"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"] ?? '',
        latitude: (json["latitude"] ?? 0).toDouble(),
        longitude: (json["longitude"] ?? 0).toDouble(),
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
