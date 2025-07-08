import 'dart:convert';



IndividualProfileModel individualProfileModelFromJson(String str) =>
    IndividualProfileModel.fromJson(json.decode(str));

String individualProfileModelToJson(IndividualProfileModel data) =>
    json.encode(data.toJson());

class IndividualProfileModel {
  final String userId;
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
    required this.userId,
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
      userId: json["userId"] ?? '',
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations: List<dynamic>.from(json["groupAssociations"] ?? const []),
      specializations: json["specializations"],
      locations: List<dynamic>.from(json["locations"] ?? const []),
      organizationProfessionals: json["organizationProfessionals"],
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
      "organizationJoiningDate": organizationJoiningDate,
      "groupAssociations": groupAssociations,
      "specializations": specializations,
      "locations": locations,
      "organizationProfessionals": organizationProfessionals,
    };
  }

  IndividualProfileModel copyWith({
    String? userId,
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    dynamic organizationJoiningDate,
    List<dynamic>? groupAssociations,
    dynamic specializations,
    String? locationJson, // 👈 replace `locations` with this
    dynamic organizationProfessionals,
  }) {
    final updatedLocations = locationJson != null
        ? jsonDecode(locationJson) as List<dynamic>
        : this.locations;

    return IndividualProfileModel(
      userId: userId ?? this.userId,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      organizationJoiningDate: organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
      locations: updatedLocations,
      organizationProfessionals: organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}


/*import 'dart:convert';

IndividualProfileModel individualProfileModelFromJson(String str) =>
    IndividualProfileModel.fromJson(json.decode(str));

String individualProfileModelToJson(IndividualProfileModel data) =>
    json.encode(data.toJson());

class IndividualProfileModel {
  final String userId;
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
    required this.userId,
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
      userId: json["userId"] ?? '',
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations: List<dynamic>.from(json["groupAssociations"] ?? const []),
      specializations: json["specializations"],
      locations: List<dynamic>.from(json["locations"] ?? const []),
      organizationProfessionals: json["organizationProfessionals"],
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
      "organizationJoiningDate": organizationJoiningDate,
      "groupAssociations": groupAssociations,
      "specializations": specializations,
      "locations": locations,
      "organizationProfessionals": organizationProfessionals,
    };
  }

  IndividualProfileModel copyWith({
    String? userId,
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    dynamic organizationJoiningDate,
    List<dynamic>? groupAssociations,
    dynamic specializations,
    List<dynamic>? locations,
    dynamic organizationProfessionals,
    bool printLocationsJson = false, // optional flag
  }) {
    final updatedLocations = locations ?? this.locations;

    // 👇 Only here: convert and optionally print locationsJson
    if (printLocationsJson) {
      final locationsJson = jsonEncode(updatedLocations);
      print('locationsJson: $locationsJson');
    }

    return IndividualProfileModel(
      userId: userId ?? this.userId,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      organizationJoiningDate: organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
      locations: updatedLocations,
      organizationProfessionals: organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}*/


/*import 'dart:convert';

IndividualProfileModel individualProfileModelFromJson(String str) =>
    IndividualProfileModel.fromJson(json.decode(str));

String individualProfileModelToJson(IndividualProfileModel data) =>
    json.encode(data.toJson());

class IndividualProfileModel {
  final String userId;
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
    required this.userId,
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
      userId: json["userId"] ?? '',
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations: List<dynamic>.from(json["groupAssociations"] ?? const []),
      specializations: json["specializations"],
      locations: List<dynamic>.from(json["locations"] ?? const []),
      organizationProfessionals: json["organizationProfessionals"],
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
      "organizationJoiningDate": organizationJoiningDate,
      "groupAssociations": groupAssociations,
      "specializations": specializations,
      "locations": locations,
      "organizationProfessionals": organizationProfessionals,
    };
  }

  IndividualProfileModel copyWith({
    String? userId,
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    dynamic organizationJoiningDate,
    List<dynamic>? groupAssociations,
    dynamic specializations,
    List<dynamic>? locations,
    dynamic organizationProfessionals,
    bool convertLocationsToJson = false, // Optional flag
  }) {
    final updatedLocations = locations ?? this.locations;
    final locationsJson = convertLocationsToJson ? jsonEncode(updatedLocations) : null;

    if (convertLocationsToJson) {
      print('Converted locations to JSON: $locationsJson');
    }

    return IndividualProfileModel(
      userId: userId ?? this.userId,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      organizationJoiningDate: organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
      locations: updatedLocations,
      organizationProfessionals: organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}
*/

/*IndividualProfileModel individualProfileModelFromJson(String str) =>
    IndividualProfileModel.fromJson(json.decode(str));

String individualProfileModelToJson(IndividualProfileModel data) =>
    json.encode(data.toJson());

class IndividualProfileModel {
  final String userId; // ✅ Newly added
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
    required this.userId,
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
      userId: json["userId"] ?? '', // ✅ Newly added
      firstname: json["firstname"] ?? '',
      lastname: json["lastname"] ?? '',
      email: json["email"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      role: json["role"] ?? '',
      userName: json["userName"] ?? '',
      profileImageUrl: json["profileImageUrl"] ?? '',
      organizationName: json["organizationName"] ?? '',
      organizationJoiningDate: json["organizationJoiningDate"],
      groupAssociations: List<dynamic>.from(json["groupAssociations"] ?? const []),
      specializations: json["specializations"],
      locations: List<dynamic>.from(json["locations"] ?? const []),
      organizationProfessionals: json["organizationProfessionals"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId, // ✅ Newly added
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

  IndividualProfileModel copyWith({
    String? userId,
    String? firstname,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? role,
    String? userName,
    String? profileImageUrl,
    String? organizationName,
    dynamic organizationJoiningDate,
    List<dynamic>? groupAssociations,
    dynamic specializations,
    List<dynamic>? locations,
    dynamic organizationProfessionals,
  }) {
    return IndividualProfileModel(
      userId: userId ?? this.userId, // ✅ Newly added
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      organizationName: organizationName ?? this.organizationName,
      organizationJoiningDate:
          organizationJoiningDate ?? this.organizationJoiningDate,
      groupAssociations: groupAssociations ?? this.groupAssociations,
      specializations: specializations ?? this.specializations,
      locations: locations ?? this.locations,
      organizationProfessionals:
          organizationProfessionals ?? this.organizationProfessionals,
    );
  }
}
*/

// IndividualProfileModel individualProfileModelFromJson(String str) =>
//     IndividualProfileModel.fromJson(json.decode(str));

// String individualProfileModelToJson(IndividualProfileModel data) =>
//     json.encode(data.toJson());

// class IndividualProfileModel {
//   final String firstname;
//   final String lastname;
//   final String email;
//   final String phoneNumber;
//   final String role;
//   final String userName;
//   final String profileImageUrl;
//   final String organizationName;
//   final dynamic organizationJoiningDate;
//   final List<dynamic> groupAssociations;
//   final dynamic specializations;
//   final List<dynamic> locations;
//   final dynamic organizationProfessionals;

//   IndividualProfileModel({
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.phoneNumber,
//     required this.role,
//     required this.userName,
//     required this.profileImageUrl,
//     required this.organizationName,
//     required this.organizationJoiningDate,
//     required this.groupAssociations,
//     required this.specializations,
//     required this.locations,
//     required this.organizationProfessionals,
//   });

//   factory IndividualProfileModel.fromJson(Map<String, dynamic> json) {
//     return IndividualProfileModel(
//       firstname: json["firstname"] ?? '',
//       lastname: json["lastname"] ?? '',
//       email: json["email"] ?? '',
//       phoneNumber: json["phoneNumber"] ?? '',
//       role: json["role"] ?? '',
//       userName: json["userName"] ?? '',
//       profileImageUrl: json["profileImageUrl"] ?? '',
//       organizationName: json["organizationName"] ?? '',
//       organizationJoiningDate: json["organizationJoiningDate"],
//       groupAssociations:
//           List<dynamic>.from(json["groupAssociations"] ?? const []),
//       specializations: json["specializations"],
//       locations: List<dynamic>.from(json["locations"] ?? const []),
//       organizationProfessionals: json["organizationProfessionals"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "firstname": firstname,
//       "lastname": lastname,
//       "email": email,
//       "phoneNumber": phoneNumber,
//       "role": role,
//       "userName": userName,
//       "profileImageUrl": profileImageUrl,
//       "organizationName": organizationName,
//       "organizationJoiningDate": organizationJoiningDate,
//       "groupAssociations": groupAssociations,
//       "specializations": specializations,
//       "locations": locations,
//       "organizationProfessionals": organizationProfessionals,
//     };
//   }

//   IndividualProfileModel copyWith({
//     String? firstname,
//     String? lastname,
//     String? email,
//     String? phoneNumber,
//     String? role,
//     String? userName,
//     String? profileImageUrl,
//     String? organizationName,
//     dynamic organizationJoiningDate,
//     List<dynamic>? groupAssociations,
//     dynamic specializations,
//     List<dynamic>? locations,
//     dynamic organizationProfessionals,
//   }) {
//     return IndividualProfileModel(
//       firstname: firstname ?? this.firstname,
//       lastname: lastname ?? this.lastname,
//       email: email ?? this.email,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       role: role ?? this.role,
//       userName: userName ?? this.userName,
//       profileImageUrl: profileImageUrl ?? this.profileImageUrl,
//       organizationName: organizationName ?? this.organizationName,
//       organizationJoiningDate:
//           organizationJoiningDate ?? this.organizationJoiningDate,
//       groupAssociations: groupAssociations ?? this.groupAssociations,
//       specializations: specializations ?? this.specializations,
//       locations: locations ?? this.locations,
//       organizationProfessionals:
//           organizationProfessionals ?? this.organizationProfessionals,
//     );
//   }
// }


// IndividualProfileModel individualProfileModelFromJson(String str) =>
//     IndividualProfileModel.fromJson(json.decode(str));

// String individualProfileModelToJson(IndividualProfileModel data) =>
//     json.encode(data.toJson());

// class IndividualProfileModel {
//   final String firstname;
//   final String lastname;
//   final String email;
//   final String phoneNumber;
//   final String role;
//   final String userName;
//   final String profileImageUrl;
//   final String organizationName;
//   final dynamic organizationJoiningDate;
//   final List<dynamic> groupAssociations;
//   final dynamic specializations;
//   final List<dynamic> locations;
//   final dynamic organizationProfessionals;

//   IndividualProfileModel({
//     required this.firstname,
//     required this.lastname,
//     required this.email,
//     required this.phoneNumber,
//     required this.role,
//     required this.userName,
//     required this.profileImageUrl,
//     required this.organizationName,
//     required this.organizationJoiningDate,
//     required this.groupAssociations,
//     required this.specializations,
//     required this.locations,
//     required this.organizationProfessionals,
//   });

//   factory IndividualProfileModel.fromJson(Map<String, dynamic> json) {
//     return IndividualProfileModel(
//       firstname: json["firstname"] ?? '',
//       lastname: json["lastname"] ?? '',
//       email: json["email"] ?? '',
//       phoneNumber: json["phoneNumber"] ?? '',
//       role: json["role"] ?? '',
//       userName: json["userName"] ?? '',
//       profileImageUrl: json["profileImageUrl"] ?? '',
//       organizationName: json["organizationName"] ?? '',
//       organizationJoiningDate: json["organizationJoiningDate"],
//       groupAssociations:
//           List<dynamic>.from(json["groupAssociations"] ?? const []),
//       specializations: json["specializations"],
//       locations: List<dynamic>.from(json["locations"] ?? const []),
//       organizationProfessionals: json["organizationProfessionals"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "firstname": firstname,
//       "lastname": lastname,
//       "email": email,
//       "phoneNumber": phoneNumber,
//       "role": role,
//       "userName": userName,
//       "profileImageUrl": profileImageUrl,
//       "organizationName": organizationName,
//       "organizationJoiningDate": organizationJoiningDate,
//       "groupAssociations": groupAssociations,
//       "specializations": specializations,
//       "locations": locations,
//       "organizationProfessionals": organizationProfessionals,
//     };
//   }
// }
