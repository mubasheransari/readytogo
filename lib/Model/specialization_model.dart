import 'dart:convert';

List<SpecializationModel> specializationModelFromJson(String str) => List<SpecializationModel>.from(json.decode(str).map((x) => SpecializationModel.fromJson(x)));

String specializationModelToJson(List<SpecializationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecializationModel {
    String id;
    String name;

    SpecializationModel({
        required this.id,
        required this.name,
    });

    factory SpecializationModel.fromJson(Map<String, dynamic> json) => SpecializationModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
