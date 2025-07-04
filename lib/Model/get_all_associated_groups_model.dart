import 'dart:convert';

List<GetAllAssociatedGroupModel> getAllAssociatedGroupModelFromJson(String str) => List<GetAllAssociatedGroupModel>.from(json.decode(str).map((x) => GetAllAssociatedGroupModel.fromJson(x)));

String getAllAssociatedGroupModelToJson(List<GetAllAssociatedGroupModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllAssociatedGroupModel {
    String id;
    String name;
    String iconUrl;
    int memberCount;

    GetAllAssociatedGroupModel({
        required this.id,
        required this.name,
        required this.iconUrl,
        required this.memberCount,
    });

    factory GetAllAssociatedGroupModel.fromJson(Map<String, dynamic> json) => GetAllAssociatedGroupModel(
        id: json["id"],
        name: json["name"],
        iconUrl: json["iconUrl"],
        memberCount: json["memberCount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iconUrl": iconUrl,
        "memberCount": memberCount,
    };
}
