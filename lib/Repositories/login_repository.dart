import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Model/filter_search_model.dart';
import 'package:readytogo/Model/get_all_associated_groups_model.dart';
import 'package:readytogo/Model/get_all_individual_profile_model.dart';
import 'package:readytogo/Model/organization_profile_model.dart';
import 'package:readytogo/Model/professional_profile_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:readytogo/Model/saved_search_model.dart';
import 'package:readytogo/Model/search_model.dart';
import 'package:readytogo/Model/specialization_model.dart';
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
      "ProfileImageUrl": profile.profileImageUrl ?? '', //10@Testing
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

  Future<http.Response> updateOrganizationalProfile({
    required String id,
    required OrganizationProfileModel profile,
    File? profileImage,
  }) async {
    final uri = Uri.parse(
      'http://173.249.27.4:343/api/Profile/organization/edit-profile',
    );

    final request = http.MultipartRequest('PUT', uri);

    var storage = GetStorage();
    var token = storage.read("id");

    if (token != null && token.toString().isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // ✅ Clean locations: remove "id" if it's null
    final cleanedLocations = profile.locations?.map((loc) {
          final map = loc.toJson();
          if (map["id"] == null) {
            map.remove("id");
          }
          return map;
        }).toList() ??
        [];

    request.fields.addAll({
      "FirstName": profile.firstname ?? "",
      "LastName": profile.lastname ?? "",
      "Email": profile.email ?? "",
      "PhoneNumber": profile.phoneNumber ?? "",
      "StreetAddress": cleanedLocations.isNotEmpty
          ? cleanedLocations[0]["streetAddress"] ?? ""
          : "",
      "Area":
          cleanedLocations.isNotEmpty ? cleanedLocations[0]["area"] ?? "" : "",
      "City":
          cleanedLocations.isNotEmpty ? cleanedLocations[0]["city"] ?? "" : "",
      "State":
          cleanedLocations.isNotEmpty ? cleanedLocations[0]["state"] ?? "" : "",
      "ZipCode": cleanedLocations.isNotEmpty
          ? cleanedLocations[0]["zipCode"] ?? ""
          : "",
      "Description": profile.description?? "",
      "Website": profile.website?? "",
      "ProfileImageUrl": profile.profileImageUrl ?? "",
      "LocationsJson": jsonEncode(cleanedLocations),
    });

    // ✅ Optional: OrganizationId 10@Testing
    final orgId = _extractOrganizationId(profile.organizationProfessionals);
    if (orgId != null && orgId.isNotEmpty) {
      request.fields["OrganizationId"] = orgId;
    }

    // ✅ SpecializationIds
    if (profile.specializations is List &&
        profile.specializations!.isNotEmpty) {
      request.fields["SpecializationIds"] = jsonEncode(profile.specializations);
    }

    // ✅ ProfessionalIds
    if (profile.organizationProfessionals is List &&
        profile.organizationProfessionals!.isNotEmpty) {
      request.fields["ProfessionalIds"] =
          jsonEncode(profile.organizationProfessionals);
    }

    // ✅ Profile image
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

  /*Future<http.Response> updateOrganizationalProfile({
    required String id,
    required OrganizationProfileModel profile,
    File? profileImage,
  }) async {
    final uri = Uri.parse(
      'http://173.249.27.4:343/api/Profile/organization/edit-profile',
    );

    final request = http.MultipartRequest('PUT', uri);

    var storage = GetStorage();
    var token = storage.read("id"); // stored token

    if (token != null && token.toString().isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // ✅ First location (if available)
    final loc = profile.locations.isNotEmpty ? profile.locations[0] : null;

    request.fields.addAll({
      "FirstName": profile.firstname,
      "LastName": profile.lastname,
      "Email": profile.email,
      "PhoneNumber": profile.phoneNumber,
      "StreetAddress": loc?.streetAddress ?? "",
      "Area": loc?.area ?? "",
      "City": loc?.city ?? "",
      "State": loc?.state ?? "",
      "ZipCode": loc?.zipCode ?? "",
      "Description": "Updated via app",
      "ProfileImageUrl": profile.profileImageUrl,
      "LocationsJson": jsonEncode(
        profile.locations.map((l) => l.toJson()).toList(),
      ),
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
    if (profile.organizationProfessionals.isNotEmpty) {
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

    // ✅ Send request
    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }*/

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

   Future<List<SpecializationModel>> getAllSpecializations() async {
    final jsonResponse = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
      path: ApiConstants.getAllSpecialization,
    );

    print(jsonResponse);

    return List<SpecializationModel>.from(
      jsonResponse.map((x) => SpecializationModel.fromJson(x)),
    );
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

  Future<http.Response> addAffiliationsGroupsOrganization(
      String userId, String groupId) async {
    var storage = GetStorage();
    var token = storage.read("id");
    return await _apiBaseHelper.post(
        path: ApiConstants.addAffiliationsGroupsOrganization,
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
  }

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

  Future<List<FilterSearchModel>> filterSearchFunctionality(
      String search,
      String zipcode,
      String service,
      double distance,
      double lat,
      double lng) async {
    var storage = GetStorage();
    var token = storage.read("id");
    var role = storage.read("role");

    final response = await _apiBaseHelper.post(
      path: ApiConstants.search,
      body: {
        "request": {
          "search": search,
          "zipCode": zipcode,
          "memberType": role,
          "service": service,
          "distance": distance,
          "latitude": lat,
          "longitude": lng
        }
      },
      token: token,
    );

    final decoded = json.decode(response.body);
    print("DECODED SEARCH FILTERS $decoded");
    print("DECODED SEARCH FILTERS $decoded");
    print("DECODED SEARCH FILTERS $decoded");

    if (decoded is List) {
      return decoded.map((item) => FilterSearchModel.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected response format: ${response.body}');
    }
  }

  Future<List<SavedSearchModel>?> getAllSavedSearches() async {
    var storage = GetStorage();
    var token = storage.read("id");
    final response = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
      path: "${ApiConstants.apiPrefix}${ApiConstants.getSaveSearch}",
      token: token,
    );

    return savedSearchModelFromJson(json.encode(response));
  }

  Future<http.Response> removeSavedSearch(String searchedUserId) async {
    var storage = GetStorage();
    var token = storage.read("id");

    return await _apiBaseHelper.delete(
        //  path: "${ApiConstants.apiPrefix}${ApiConstants.removeSearch}",
        path: ApiConstants.removeSearch,
        queryParam: {"searchedUserId": searchedUserId},
        token: token);
  }

  Future<http.Response> addSavedSearch(String searchedUserId) async {
    var storage = GetStorage();
    var token = storage.read("id");

    return await _apiBaseHelper.post(
      path: ApiConstants.addSearch,
      token: token,
      queryParam: {"searchedUserId": searchedUserId},
    );
  }

  // Future<http.Response> addSavedSearch(String searchedUserId) async {
  //   var storage = GetStorage();
  //   var token = storage.read("id");
  //   return await _apiBaseHelper.post(
  //       //   path: "${ApiConstants.apiPrefix}${ApiConstants.addSearch}",

  //       path: ApiConstants.addSearch + "$searchedUserId",
  //       // queryParam: {"searchedUserId": searchedUserId},
  //       // body: {
  //       //   "searchedUserId": searchedUserId
  //       // },
  //       token: token);
  // }

  Future<http.Response> removeAffiliationsGroupsOrganizational(
      String userId, String groupId) async {
    var storage = GetStorage();
    var token = storage.read("id");

    return await _apiBaseHelper.delete(
        path: ApiConstants.removeAffiliationsGroupsOrganizational,
        body: {
          "userId": userId,
          "groupId": groupId,
        },
        token: token);
  }

  /*Future<List<SavedSearchModel>> getAllSavedSearches() async {
    var storage = GetStorage();
    var token = storage.read("id");

    final response = await _apiBaseHelper.get(
      url: ApiConstants.baseDomain,
        path:
      "${ApiConstants.apiPrefix}${ApiConstants.saveSearch}",
     // path: ApiConstants.saveSearch,
      token: token,
    );

    final decoded = json.decode(response.body);
    print("SAVED SEARCHES $decoded");
    print("SAVED SEARCHES $decoded");
    print("SAVED SEARCHES $decoded");
    print("SAVED SEARCHES $decoded");

    if (decoded is List) {
      return decoded.map((item) => SavedSearchModel.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected response format: ${response.body}');
    }
  }*/

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

  Future<http.Response> requestLoginPasswordThroughSMS(
      String phone, password) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.loginRequestSMS,
      body: {"phoneNumber": phone, "password": password},
    );
  }

  Future<http.Response> verifySMSOtp(String phone, otp) async {
    return await _apiBaseHelper.post(
      path: ApiConstants.verifySMSotpLogin,
      body: {"phoneNumber": phone, "otp": otp},
    );
  }
}
