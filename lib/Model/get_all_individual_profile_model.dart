import 'dart:convert';

List<GetAllProfessionalProfileModel> getAllProfessionalProfileModelFromJson(String str) => List<GetAllProfessionalProfileModel>.from(json.decode(str).map((x) => GetAllProfessionalProfileModel.fromJson(x)));

String getAllProfessionalProfileModelToJson(List<GetAllProfessionalProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllProfessionalProfileModel {
    String id;
    String name;
    String email;
    String phoneNumber;
    String? profileImageUrl;

    GetAllProfessionalProfileModel({
        required this.id,
        required this.name,
        required this.email,
        required this.phoneNumber,
        required this.profileImageUrl,
    });

    factory GetAllProfessionalProfileModel.fromJson(Map<String, dynamic> json) => GetAllProfessionalProfileModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profileImageUrl: json["profileImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profileImageUrl": profileImageUrl,
    };
}
