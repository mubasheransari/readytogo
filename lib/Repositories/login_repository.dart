import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Model/get_all_associated_groups_model.dart';
import 'package:readytogo/Model/get_all_individual_profile_model.dart';
import 'package:readytogo/Model/professional_profile_model.dart';
import 'package:http_parser/http_parser.dart';

import '../Constants/api_constants.dart';
import '../Model/individual_profile_model.dart';
import '../Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<http.Response> loginWithEmailPassword(
      String email, String password) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.loginApi,
      body: {
        "email": email,
        "password": password,
      },
    );
  }

  Future<http.Response> verifyOTP(
      String email, String password, String otp) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.verifyOTPApi,
      body: {
        "email": email,
        "password": password,
        "otp": otp,
      },
    );
  }

  Future<IndividualProfileModel> individualProfile(String userId) async {
    final jsonResponse = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
      path:
          "${ApiConstants.apiPrefix}${ApiConstants.getIndividualProfileData}$userId",
      queryParam: {},
    );

    return IndividualProfileModel.fromJson(jsonResponse);
  }

  Future<ProfessionalProfileModel> professionalProfile(String userId) async {
    final jsonResponse = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
      path:
          "${ApiConstants.apiPrefix}${ApiConstants.getProfessionalProfileData}$userId",
      queryParam: {},
    );

    return ProfessionalProfileModel.fromJson(jsonResponse);
  }

  Future<http.Response> updateIndividualProfile({
    required String id,
    required IndividualProfileModel profile,
    File? profileImage,
  }) async {
    var uri = Uri.parse(
        'http://173.249.27.4:343/api/Profile/individual/edit-profile');

    var request = http.MultipartRequest('PUT', uri);

    // Basic fields
    request.fields.addAll({
      "UserId": id,
      "FirstName": profile.firstname,
      "LastName": profile.lastname,
      "Email": profile.email,
      "PhoneNumber": profile.phoneNumber,
      "StreetAddress": profile.locations.isNotEmpty
          ? profile.locations[0]["streetAddress"] ?? ""
          : "",
      "Area": profile.locations.isNotEmpty
          ? profile.locations[0]["area"] ?? ""
          : "",
      "City": profile.locations.isNotEmpty
          ? profile.locations[0]["city"] ?? ""
          : "",
      "State": profile.locations.isNotEmpty
          ? profile.locations[0]["state"] ?? ""
          : "",
      "ZipCode": profile.locations.isNotEmpty
          ? profile.locations[0]["zipCode"] ?? ""
          : "",
      "Description": "Updated via app",
      "ProfileImageUrl": profile.profileImageUrl,
      "Locations": jsonEncode(profile.locations),
    });

    // 🔐 Only add if valid
    final orgId = _extractOrganizationId(profile.organizationProfessionals);
    if (orgId != null && orgId.isNotEmpty) {
      request.fields["OrganizationId"] = orgId;
    }

    if (profile.specializations is List &&
        (profile.specializations as List).isNotEmpty) {
      request.fields["SpecializationIds"] = jsonEncode(profile.specializations);
    }

    if (profile.organizationProfessionals is List &&
        (profile.organizationProfessionals as List).isNotEmpty) {
      request.fields["ProfessionalIds"] =
          jsonEncode(profile.organizationProfessionals);
    }

    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "ProfileImage",
        profileImage.path,
        contentType: MediaType("image", "jpeg"),
      ));
    }

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  /// Helper to extract organizationId safely
  String? _extractOrganizationId(dynamic organizationProfessionals) {
    if (organizationProfessionals is List &&
        organizationProfessionals.isNotEmpty) {
      final first = organizationProfessionals[0];
      if (first is Map && first.containsKey('organizationId')) {
        return first['organizationId']?.toString();
      }
    }
    return null;
  }

  Future<List<GetAllAssociatedGroupModel>> getAllAssociatedGroup() async {
    final jsonResponse = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
      path: ApiConstants.getAllAssociatedGroups,
    );

    print(jsonResponse); // Should print a List of maps

    return List<GetAllAssociatedGroupModel>.from(
      jsonResponse.map((x) => GetAllAssociatedGroupModel.fromJson(x)),
    );
  }

  Future<http.Response> removeAffiliationsGroups(
      String userId, String groupId) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.removeAffiliationsGroups,
      body: {
        "userId": userId,
        "groupId": groupId,
      },
    );
  }

  Future<http.Response> addAffiliationsGroups(
      String userId, String groupId) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.addAffiliationsGroups,
      body: {
        "userId": userId,
        "groupId": groupId,
      },
    );
  }

  Future<List<GetAllProfessionalProfileModel>>
      getAllProfessionalProfile() async {
    final jsonResponse = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
      path: ApiConstants.getAllProfessionalProfile,
    );

    print(
        "GET ALL PROFESSIONAL PROFILE $jsonResponse"); // Should print a List of maps

    return List<GetAllProfessionalProfileModel>.from(
      jsonResponse.map((x) => GetAllProfessionalProfileModel.fromJson(x)),
    );
  }

  /*Future<http.Response> updateIndividualProfile({
    required String id,
    required IndividualProfileModel profile,
    File? profileImage,
  }) async {
    var uri = Uri.parse(
        'http://173.249.27.4:343/api/Profile/individual/edit-profile');

    var request = http.MultipartRequest('PUT', uri);

    request.fields.addAll({
      "UserId": id,
      "FirstName": profile.firstname,
      "LastName": profile.lastname,
      "Email": profile.email,
      "PhoneNumber": profile.phoneNumber,
      "StreetAddress": profile.locations[0]["streetAddress"] ?? "",
      "Area": profile.locations[0]["area"] ?? "",
      "City": profile.locations[0]["city"] ?? "",
      "State": profile.locations[0]["state"] ?? "",
      "ZipCode": profile.locations[0]["zipCode"] ?? "",
      "Description": "Updated via app",
      "OrganizationId": "00000000-0000-0000-0000-000000000000",
      "ProfileImageUrl": profile.profileImageUrl,
      "Locations": jsonEncode(profile.locations),
    });

    // ✅ Conditionally add SpecializationIds and ProfessionalIds if non-empty
    if (profile.specializations is List &&
        (profile.specializations as List).isNotEmpty) {
      request.fields["SpecializationIds"] = jsonEncode(profile.specializations);
    }

    if (profile.organizationProfessionals is List &&
        (profile.organizationProfessionals as List).isNotEmpty) {
      request.fields["ProfessionalIds"] =
          jsonEncode(profile.organizationProfessionals);
    }

    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "ProfileImage",
        profileImage.path,
        contentType: MediaType("image", "jpeg"),
      ));
    }

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }*/

  /*Future<http.Response> updateIndividualProfile({
  required String id,
  required IndividualProfileModel profile,
  File? profileImage,
}) async {
  var uri = Uri.parse('http://173.249.27.4:343/api/Profile/individual/edit-profile');

  var request = http.MultipartRequest('PUT', uri);

  request.fields.addAll({
    "UserId": id,
    "FirstName": profile.firstname,
    "LastName": profile.lastname,
    "Email": profile.email,
    "PhoneNumber": profile.phoneNumber,
    "StreetAddress": profile.locations.isNotEmpty ? profile.locations[0]["streetAddress"] ?? "" : "",
    "Area": profile.locations.isNotEmpty ? profile.locations[0]["area"] ?? "" : "",
    "City": profile.locations.isNotEmpty ? profile.locations[0]["city"] ?? "" : "",
    "State": profile.locations.isNotEmpty ? profile.locations[0]["state"] ?? "" : "",
    "ZipCode": profile.locations.isNotEmpty ? profile.locations[0]["zipCode"] ?? "" : "",
    "Description": "Updated via app",
    "OrganizationId": "00000000-0000-0000-0000-000000000000", // Replace if dynamic
    "ProfileImageUrl": profile.profileImageUrl,
    "Locations": jsonEncode(profile.locations),
    "SpecializationIds": jsonEncode([]), // Replace if needed
    "ProfessionalIds": jsonEncode([]), // Replace if needed
  });

  if (profileImage != null) {
    request.files.add(await http.MultipartFile.fromPath(
      "ProfileImage",
      profileImage.path,
      contentType: MediaType("image", "jpeg"),
    ));
  }

  final streamedResponse = await request.send();
  return await http.Response.fromStream(streamedResponse);
}*/

  /* Future<IndividualProfileModel> updateIndividualProfile({
    required String id,
    required IndividualProfileModel profile,
    File? profileImage,
  }) async {
    final uri = Uri.parse('http://173.249.27.4:343/api/account/edit-profile');
    var request = http.MultipartRequest('PUT', uri);

    request.fields.addAll({
      "UserId": id,
      "FirstName": profile.firstname,
      "LastName": profile.lastname,
      "Email": profile.email,
      "PhoneNumber": profile.phoneNumber,
      "StreetAddress": profile.locations[0]["streetAddress"] ?? "",
      "Area": profile.locations[0]["area"] ?? "",
      "City": profile.locations[0]["city"] ?? "",
      "State": profile.locations[0]["state"] ?? "",
      "ZipCode": profile.locations[0]["zipCode"] ?? "",
      "Description": "Updated via app",
      "OrganizationId": "00000000-0000-0000-0000-000000000000",
      "ProfileImageUrl": profile.profileImageUrl,
      "Locations": jsonEncode(profile.locations),
      "SpecializationIds": jsonEncode([]),
      "ProfessionalIds": jsonEncode([]),
    });

    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "ProfileImage",
        profileImage.path,
        contentType: MediaType("image", "jpeg"), // or png if needed
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return IndividualProfileModel.fromJson(data);
    } else {
      throw Exception("Failed to update profile: ${response.body}");
    }
  }*/

// Future<http.Response> updateIndividualProfile({
//     required String id,
//     required IndividualProfileModel profile,
//     File? profileImage,
//   }) async {
//     var uri = Uri.parse('http://173.249.27.4:343/api/account/update-profile');

//     var request = http.MultipartRequest('PUT', uri);

//     request.fields.addAll({
//       "UserId": id,
//       "FirstName": profile.firstname,
//       "LastName": profile.lastname,
//       "Email": profile.email,
//       "PhoneNumber": profile.phoneNumber,
//       "StreetAddress": profile.locations[0]["streetAddress"] ?? "",
//       "Area": profile.locations[0]["area"] ?? "",
//       "City": profile.locations[0]["city"] ?? "",
//       "State": profile.locations[0]["state"] ?? "",
//       "ZipCode": profile.locations[0]["zipCode"] ?? "",
//       "Description": "Updated via app",
//       "OrganizationId": "00000000-0000-0000-0000-000000000000",
//       "ProfileImageUrl": profile.profileImageUrl,
//       "Locations": jsonEncode(profile.locations),
//       "SpecializationIds": jsonEncode([]),
//       "ProfessionalIds": jsonEncode([]),
//     });

//     if (profileImage != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//         "ProfileImage",
//         profileImage.path,
//         contentType: MediaType("image", "jpeg"),
//       ));
//     }

//     final streamedResponse = await request.send();
//     return await http.Response.fromStream(streamedResponse);
//   }

// Future<IndividualProfileModel> updateIndividualProfile({
//     required String id,
//     required IndividualProfileModel profile,
//     File? profileImage,
//   }) async {
//     final uri = Uri.parse("http://173.249.27.4:343/api/profile/individual/edit-profile"); // 👈 Adjust endpoint

//     final request = http.MultipartRequest('PUT', uri);

//     // Auth token (optional)
//     final token = GetStorage().read("token");
//     if (token != null) {
//       request.headers['Authorization'] = 'Bearer $token';
//     }

//     // Add form fields
//     request.fields.addAll({
//       "FirstName": profile.firstname,
//       "LastName": profile.lastname,
//       "Email": profile.email,
//       "PhoneNumber": profile.phoneNumber,
//       "UserName": profile.userName,
//       "ZipCode": "00000", // or from UI if needed
//       "Locations": jsonEncode(profile.locations), // optional
//     });

//     // Add image file if present
//     if (profileImage != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           "ProfileImage", // 👈 MUST match backend key
//           profileImage.path,
//           contentType: MediaType("image", "jpeg"), // or "png"
//         ),
//       );
//     }

//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final jsonBody = jsonDecode(response.body);
//       return IndividualProfileModel.fromJson(jsonBody['data']);
//     } else {
//       throw Exception("Failed to update profile: ${response.body}");
//     }
//   }
  // loginWithEmailPassword(String email, String password) async {
  //   await _apiBaseHelper.post(
  //     path: ApiConstants.loginApi,
  //     body: {
  //       "email": email,
  //       "password": password,
  //     },
  //   );
  // }
}
