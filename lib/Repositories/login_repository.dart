import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Model/get_all_associated_groups_model.dart';
import 'package:readytogo/Model/get_all_individual_profile_model.dart';
import 'package:readytogo/Model/organization_profile_model.dart';
import 'package:readytogo/Model/professional_profile_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:readytogo/Model/search_model.dart';
import '../Constants/api_constants.dart';
import '../Model/individual_profile_model.dart';
import '../Service/api_basehelper.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  //10@Testing
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
    var storage = GetStorage();
    var token = storage.read("id");
    final jsonResponse = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
      path: "${ApiConstants.apiPrefix}${ApiConstants.getIndividualProfileData}",
      token: token,
    );
    return IndividualProfileModel.fromJson(jsonResponse);
  }

  // Future<IndividualProfileModel> individualProfile(String userId) async {
  //   final jsonResponse = await _apiBaseHelper.get(
  //     url: ApiConstants.baseDomain,
  //     path:
  //         "${ApiConstants.apiPrefix}${ApiConstants.getIndividualProfileData}",//$userId

  //     // queryParam: {
  //     //   "token":userId
  //     // },
  //   );//10@Testing

  //   return IndividualProfileModel.fromJson(jsonResponse);//rational scan image/ fundus image
  // }

  Future<ProfessionalProfileModel> professionalProfile(String userId) async {
    var storage = GetStorage();
    var token = storage.read("id");
    final jsonResponse = await _apiBaseHelper.get(
        url: ApiConstants.baseDomain,
        path:
            "${ApiConstants.apiPrefix}${ApiConstants.getProfessionalProfileData}",
        token: token);
    return ProfessionalProfileModel.fromJson(jsonResponse);
  }

  Future<OrganizationProfileModel> organizationProfile(String userId) async {
    var storage = GetStorage();
    var token = storage.read("id");
    final jsonResponse = await _apiBaseHelper.get(
        url: ApiConstants.baseDomain,
        path:
            "${ApiConstants.apiPrefix}${ApiConstants.getOrganizationalProfileData}",
        token: token);

    return OrganizationProfileModel.fromJson(jsonResponse);
  }

  Future<http.Response> updateProfessionalProfile({
    required String id,
    required ProfessionalProfileModel profile,
    File? profileImage,
  }) async {
    final uri = Uri.parse(
        'http://173.249.27.4:343/api/Profile/professional/edit-profile');
    final request = http.MultipartRequest(
      'PUT',
      uri,
    );
    var storage = GetStorage();
    var token = storage.read("id");

    // ✅ Set Authorization header (do NOT set Content-Type manually for MultipartRequest)
    if (token != null && token.toString().isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    final Location? loc =
        profile.locations?.isNotEmpty == true ? profile.locations!.first : null;

    final List<String> specializationIds = profile.specializationIds
            ?.map((e) => e.id)
            .whereType<String>()
            .toList() ??
        [];

    request.fields.addAll({
      //"UserId": id,
      "FirstName": profile.firstname ?? "",
      "LastName": profile.lastname ?? "",
      "Email": profile.email ?? "",
      "Description": profile.description ?? "",
      "PhoneNumber": profile.phoneNumber ?? "",
      "StreetAddress": loc?.streetAddress ?? "",
      "Area": loc?.area ?? "",
      "City": loc?.city ?? "",
      "State": loc?.state ?? "",
      "ZipCode": loc?.zipCode ?? "",
      "ProfileImageUrl": profile.profileImageUrl ?? "",
      "LocationsJson": jsonEncode(
        profile.locations?.map((e) => e.toJson()).toList() ?? [],
      ),
    });

    final orgId = _extractOrganizationId(profile.organizationProfessionals);
    if (orgId != null && orgId.isNotEmpty) {
      request.fields["OrganizationId"] = orgId;
    }

    if (specializationIds.isNotEmpty) {
      request.fields["SpecializationIds"] = jsonEncode(specializationIds);
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

  String? _extractOrganizationId(dynamic organizationProfessionals) {
    if (organizationProfessionals is List &&
        organizationProfessionals.isNotEmpty) {
      final first = organizationProfessionals.first;
      if (first is Map && first.containsKey('organizationId')) {
        return first['organizationId']?.toString();
      } else if (first is String) {
        return first;
      }
    } else if (organizationProfessionals is String) {
      return organizationProfessionals;
    }
    return null;
  }

// Helper method (if not already defined)
// String? _extractOrganizationId(dynamic organizationProfessionals) {
//   if (organizationProfessionals is List && organizationProfessionals.isNotEmpty) {
//     final first = organizationProfessionals.first;
//     if (first is Map && first.containsKey('organizationId')) {
//       return first['organizationId']?.toString();
//     } else if (first is String) {
//       return first;
//     }
//   } else if (organizationProfessionals is String) {
//     return organizationProfessionals;
//   }
//   return null;
// }

  Future<http.Response> updateIndividualProfile({
    required String id,
    required IndividualProfileModel profile,
    File? profileImage,
  }) async {
    final uri = Uri.parse(
      'http://173.249.27.4:343/api/Profile/individual/edit-profile',
    );

    final request = http.MultipartRequest('PUT', uri);

    var storage = GetStorage();
    var token = storage.read(
        "id"); //yeh token hai id nahi hai id pe condition thi jabhi key name id rkh lia tha

    if (token != null && token.toString().isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    final loc = profile.locations.isNotEmpty ? profile.locations[0] : {};

    request.fields.addAll({
      //  "UserId": id,
      "FirstName": profile.firstname,
      "LastName": profile.lastname,
      "Email": profile.email,
      "PhoneNumber": profile.phoneNumber,
      "StreetAddress": loc["streetAddress"] ?? "",
      "Area": loc["area"] ?? "",
      "City": loc["city"] ?? "",
      "State": loc["state"] ?? "",
      "ZipCode": loc["zipCode"] ?? "",
      "Description": "Updated via app",
      "ProfileImageUrl": profile.profileImageUrl,
      "LocationsJson": jsonEncode(profile.locations),
    });

    // ✅ Optional: OrganizationId
    final orgId = _extractOrganizationId(profile.organizationProfessionals);
    if (orgId != null && orgId.isNotEmpty) {
      request.fields["OrganizationId"] = orgId;
    }

    // ✅ SpecializationIds
    if (profile.specializations is List &&
        (profile.specializations as List).isNotEmpty) {
      request.fields["SpecializationIds"] = jsonEncode(profile.specializations);
    }

    // ✅ ProfessionalIds
    if (profile.organizationProfessionals is List &&
        (profile.organizationProfessionals as List).isNotEmpty) {
      request.fields["ProfessionalIds"] =
          jsonEncode(profile.organizationProfessionals);
    }

    // ✅ Optional profile image
    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "ProfileImage",
        profileImage.path,
        contentType: MediaType("image", "jpeg"),
      ));
    }

    // ✅ Send request and convert streamed response to http.Response
    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  /*Future<http.Response> updateIndividualProfile({
    required String id,
    required IndividualProfileModel profile,
    File? profileImage,
  }) async {
    final uri = Uri.parse(
        'http://173.249.27.4:343/api/Profile/individual/edit-profile');

    final request = http.MultipartRequest('PUT', uri);

    var storage = GetStorage();
    var token = storage.read("id");

    request.headers.addAll({
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    // 📦 Basic fields
    final loc = profile.locations.isNotEmpty ? profile.locations[0] : {};

    request.fields.addAll({
      "UserId": id,
      "FirstName": profile.firstname,
      "LastName": profile.lastname,
      "Email": profile.email,
      "PhoneNumber": profile.phoneNumber,
      "StreetAddress": loc["streetAddress"] ?? "",
      "Area": loc["area"] ?? "",
      "City": loc["city"] ?? "",
      "State": loc["state"] ?? "",
      "ZipCode": loc["zipCode"] ?? "",
      "Description": "Updated via app",
      "ProfileImageUrl": profile.profileImageUrl,
      "LocationsJson": jsonEncode(profile.locations),
    });

    // 🏢 OrganizationId
    final orgId = _extractOrganizationId(profile.organizationProfessionals);
    if (orgId != null && orgId.isNotEmpty) {
      request.fields["OrganizationId"] = orgId;
    }

    // 🎯 SpecializationIds
    if (profile.specializations is List &&
        (profile.specializations as List).isNotEmpty) {
      request.fields["SpecializationIds"] = jsonEncode(profile.specializations);
    }

    // 👨‍💼 ProfessionalIds
    if (profile.organizationProfessionals is List &&
        (profile.organizationProfessionals as List).isNotEmpty) {
      request.fields["ProfessionalIds"] =
          jsonEncode(profile.organizationProfessionals);
    }

    // 🖼️ Optional Profile Image
    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "ProfileImage",
        profileImage.path,
        contentType: MediaType("image", "jpeg"),
      ));
    }

    // ⏩ Send request and return response
    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }*/

  // Future<http.Response> updateIndividualProfile({
  //   required String id,
  //   required IndividualProfileModel profile,
  //   File? profileImage,
  // }) async {
  //   var uri = Uri.parse(
  //       'http://173.249.27.4:343/api/Profile/individual/edit-profile');

  //   var request = http.MultipartRequest('PUT', uri);

  //   // Basic fields
  //   request.fields.addAll({
  //     "UserId": id,
  //     "FirstName": profile.firstname,
  //     "LastName": profile.lastname,
  //     "Email": profile.email,
  //     "PhoneNumber": profile.phoneNumber,
  //     "StreetAddress": profile.locations.isNotEmpty
  //         ? profile.locations[0]["streetAddress"] ?? ""
  //         : "",
  //     "Area": profile.locations.isNotEmpty
  //         ? profile.locations[0]["area"] ?? ""
  //         : "",
  //     "City": profile.locations.isNotEmpty
  //         ? profile.locations[0]["city"] ?? ""
  //         : "",
  //     "State": profile.locations.isNotEmpty
  //         ? profile.locations[0]["state"] ?? ""
  //         : "",
  //     "ZipCode": profile.locations.isNotEmpty
  //         ? profile.locations[0]["zipCode"] ?? ""
  //         : "",
  //     "Description": "Updated via app",
  //     "ProfileImageUrl": profile.profileImageUrl,
  //     "LocationsJson": jsonEncode(profile.locations),
  //   });

  //   // 🔐 Only add if valid 10@Testing
  //   final orgId = _extractOrganizationId(profile.organizationProfessionals);
  //   if (orgId != null && orgId.isNotEmpty) {
  //     request.fields["OrganizationId"] = orgId;
  //   }

  //   if (profile.specializations is List &&
  //       (profile.specializations as List).isNotEmpty) {
  //     request.fields["SpecializationIds"] = jsonEncode(profile.specializations);
  //   }

  //   if (profile.organizationProfessionals is List &&
  //       (profile.organizationProfessionals as List).isNotEmpty) {
  //     request.fields["ProfessionalIds"] =
  //         jsonEncode(profile.organizationProfessionals);
  //   }

  //   if (profileImage != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       "ProfileImage",
  //       profileImage.path,
  //       contentType: MediaType("image", "jpeg"),
  //     ));
  //   }

  //   final streamedResponse = await request.send();
  //   return await http.Response.fromStream(streamedResponse);
  // }

  /// Helper to extract organizationId safely
  String? extractOrganizationId(dynamic organizationProfessionals) {
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

    print(jsonResponse);

    return List<GetAllAssociatedGroupModel>.from(
      jsonResponse.map((x) => GetAllAssociatedGroupModel.fromJson(x)),
    );
  }

  Future<http.Response> removeAffiliationsGroups(
      String userId, String groupId) async {
    var storage = GetStorage();
    var token = storage.read("id");

    return await _apiBaseHelper.delete(
        path: ApiConstants.removeAffiliationsGroups,
        body: {
          "userId": userId,
          "groupId": groupId,
        },
        token: token);
  }

  Future<http.Response> removeAffiliationsGroupsProfessional(
      String userId, String groupId) async {
    var storage = GetStorage();
    var token = storage.read("id");

    return await _apiBaseHelper.delete(
        path: ApiConstants.removeAffiliationsGroupsProfessional,
        body: {
          "userId": userId,
          "groupId": groupId,
        },
        token: token);
  }

  Future<http.Response> addAffiliationsGroupsProfessional(
      String userId, String groupId) async {
    var storage = GetStorage();
    var token = storage.read("id");
    return await _apiBaseHelper.post(
        path: ApiConstants.addAffiliationsGroupsProfessional,
        body: {
          "userId": userId,
          "groupId": groupId,
        },
        token: token);
  }

  Future<http.Response> addAffiliationsGroups(
      String userId, String groupId) async {
    var storage = GetStorage();
    var token = storage.read("id");
    return await _apiBaseHelper.post(
        path: ApiConstants.addAffiliationsGroups,
        body: {
          "userId": userId,
          "groupId": groupId,
        },
        token: token);
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
  } //10@Testing

  Future<List<SearchModel>> searchFunctionality(String search) async {
    var storage = GetStorage();
    var token = storage.read("id");

    final response = await _apiBaseHelper.post(
      path: ApiConstants.search,
      body: {
        "services": search,
      },
      token: token,
    );

    final decoded = json.decode(response.body);
    print("DECODED SEARCH $decoded");
    print("DECODED SEARCH $decoded");
    print("DECODED SEARCH $decoded");

    if (decoded is List) {
      return decoded.map((item) => SearchModel.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected response format: ${response.body}');
    }
  }

  // Future<SearchModel> searchFunctionality(String search) async {
  //   var storage = GetStorage();
  //   var token = storage.read("id");
  // var response= await _apiBaseHelper.post(
  //     path: ApiConstants.loginApi,
  //     body: {
  //       "search": search,
  //     },
  //   token: token
  //   );

  // }
}
