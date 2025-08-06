import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Repositories/login_repository.dart';

import '../../../Model/saved_search_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginWithEmailPassword>(_loginWithEmailPassword);
    on<VerifyOtpSubmitted>(_onVerifyOtpSubmitted);
    on<GetIndividualProfile>(_getIndividualProfile);
    on<GetProfessionalProfile>(_getProfessionalProfile);
    on<GetOrganizationProfile>(_getOrganizationProfile);
    on<UpdateIndividualProfile>(updateIndividualProfile);
    on<UpdateProfessionalProfile>(updateProfessionalProfile);
    on<GetAllAssociatedGroups>(getAllAssociatedGroups);
    on<GetAllProfessionalProfiles>(getAllProfessionalProfiles);
    on<RemoveAffiliations>(removeAffiliations);
    on<AddAffiliations>(addAffiliations);
    on<RemoveAffiliationsProfrofessional>(removeAffiliationsProfessional);
    on<AddAffiliationsProfrofessional>(addAffiliationsProfrofessional);
    on<SearchFunctionality>(_searchFunctionality);
    on<FiltersSearchFunctionality>(_filterSearchFunctionality);
    on<LogoutRequested>(logoutRequested);
    on<GetSavedSearches>(getSavedSearches);
    on<RemoveSavedSearch>(removeSavedSearch);
    on<AddSavedSearch>(addSavedSearch);
    on<LoginThroughSMSOtpLoginRequest>(loginThroughSMSOtpLoginRequest);
    on<VerificationLoginThroughSMSOtpLoginRequest>(
        verificationLoginThroughSMSOtpLoginRequest);
    on<LoginThroughSMSOtpRequestNew>(loginThroughSMSOtpRequestNew);
  }

  final LoginRepository loginRepository = LoginRepository();
  String? _tempToken;
  addSavedSearch(AddSavedSearch event, exmit) {
    final currentList =
        List<SavedSearchModel>.from(state.savedSearchModel ?? []);
    currentList.add(event.savedSearch);
    //loginRepository.addSavedSearch(event.savedSearch.userId.toString());
    emit(state.copyWith(savedSearchModel: currentList));
  }

  removeSavedSearch(RemoveSavedSearch event, Emitter<LoginState> emit) {
    final currentList =
        List<SavedSearchModel>.from(state.savedSearchModel ?? []);

    currentList.removeWhere((element) => element.userId == event.userId);

    emit(state.copyWith(savedSearchModel: currentList));
  }

  // removeSavedSearch(RemoveSavedSearch event, emit) {
  //   final updatedList =
  //       List<SavedSearchModel>.from(state.savedSearchModel ?? []);
  //   if (event.index.toString() >= 0 && event.index < updatedList.length) {
  //     updatedList.removeAt(event.index);
  //     emit(state.copyWith(savedSearchModel: updatedList));
  //   }
  // }

  void _searchFunctionality(
    SearchFunctionality event,
    Emitter<LoginState> emit,
  ) async {
    //state.filterSearchResults == null;
    emit(state.copyWith(
        searchStatus: SearchStatus.searchLoading, filterSearchResults: null));

    try {
      final result = await loginRepository.searchFunctionality(event.services);

      emit(state.copyWith(
        searchResults: result, // searchModel: result,10@Testing
        searchStatus: SearchStatus.searchSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        searchStatus: SearchStatus.searchError,
        errorMessage: e.toString(),
      ));
    }
  }

  _filterSearchFunctionality(
    FiltersSearchFunctionality event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        filterSearchStatus: FilterSearchStatus.filtersearchLoading));
    try {
      final result = await loginRepository.filterSearchFunctionality(
          event.search,
          event.zipcode,
          event.service,
          event.distance,
          event.lat,
          event.lng);
      print("FILTERS SEARCH STATUS ${state.filterSearchStatus}");
      print("FILTERS SEARCH STATUS ${state.filterSearchStatus}");
      print("FILTERS SEARCH STATUS ${state.filterSearchStatus}");
      emit(state.copyWith(
          filterSearchResults: result, // searchModel: result,10@Testing
          filterSearchStatus: FilterSearchStatus.filtersearchSuccess));
    } catch (e) {
      emit(state.copyWith(
        filterSearchStatus: FilterSearchStatus.filtersearchError,
        errorMessage: e.toString(),
      ));
    }
  }

  /*_searchFunctionality(
    SearchFunctionality event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      searchStatus: SearchStatus.searchLoading,
      searchResults: [],
      errorMessage: null,
    ));

    try {
      final results = await loginRepository.searchFunctionality(event.services);

      emit(state.copyWith(
        searchStatus: SearchStatus.searchSuccess,
        searchResults: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        searchStatus: SearchStatus.searchError,
        errorMessage: e.toString(),
      ));
    }
  }*/

  _loginWithEmailPassword(
    LoginWithEmailPassword event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final response = await loginRepository.loginWithEmailPassword(
        event.email ?? "",
        event.password ?? "",
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
            status: LoginStatus.failure,
            errorMessage:
                "Incorrect Email or Password" //"Login failed with status ${response.statusCode}",
            ));
      }
    } catch (e) {
      print("Error in login: $e");
      emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage:
              "Incorrect Email or Password" //"An error occurred: ${e.toString()}",
          ));
    }
  }

  _onVerifyOtpSubmitted(
    VerifyOtpSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    print(" REQUEST LOGIN");
    print(" REQUEST LOGIN");
    print(" REQUEST LOGIN");
    print(" REQUEST LOGIN");
    print(" REQUEST LOGIN");
    print(" REQUEST LOGIN");

    try {
      final response = await loginRepository.verifyOTP(
        event.email,
        event.password,
        event.otp,
      ); //10@Testing

      print("VERIFY OTP: $response");
      final responseBody = json.decode(response.body);
      print("RESPONSE BODY $responseBody");
      print("RESPONSE BODY $responseBody");
      print("RESPONSE BODY $responseBody");

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final token = responseBody['token'];
        final userId = responseBody['token'];

        List<dynamic> roles = responseBody['role'];
        String userRole = roles.isNotEmpty ? roles[0] : '';

        print('User Role: $userRole'); //10@Testing

        var storage = GetStorage();
        storage.write("id", userId);
        storage.write("role", userRole);
        storage.write('userid', responseBody['id']);

        if (token != null && userId != null) {
          _tempToken = token;

          emit(state.copyWith(
            status: LoginStatus.otpSuccess,
            token: token,
          ));

          // if (userRole == "Individual") {
          //   add(GetIndividualProfile(userId: userId));
          // } else if (userRole == "Professional") {
          //   add(GetProfessionalProfile(userId: userId));
          // }
          if (userRole == "Individual") {
            emit(state.copyWith(status: LoginStatus.profileLoading));

            final profile = await loginRepository.individualProfile(userId);
            final getSavedSerches = await loginRepository.getAllSavedSearches();

            emit(state.copyWith(
                status: LoginStatus.profileLoaded,
                profile: profile, //10@Testing
                savedSearchModel: getSavedSerches,
                getSavedSearchesStatus:
                    GetSavedSearchesStatus.getSavedSearchesSuccess));
          } else if (userRole == "Professional") {
            emit(
                state.copyWith(professionalStatus: ProfessionalStatus.loading));

            final profile = await loginRepository.professionalProfile(userId);
            final getSavedSerches = await loginRepository.getAllSavedSearches();
            emit(state.copyWith(
                professionalStatus: ProfessionalStatus.success,
                professionalProfileModel: profile,
                savedSearchModel: getSavedSerches,
                getSavedSearchesStatus:
                    GetSavedSearchesStatus.getSavedSearchesSuccess));
          } //10@Testing
          else if (userRole == "Organization") {
            emit(state.copyWith(
                organizationalStatus: OrganizationalStatus.loading));

            final profile = await loginRepository.organizationProfile(userId);
            final getSavedSerches = await loginRepository.getAllSavedSearches();

            emit(state.copyWith(
                organizationalStatus: OrganizationalStatus.success,
                organizationProfileModel: profile,
                savedSearchModel: getSavedSerches,
                getSavedSearchesStatus:
                    GetSavedSearchesStatus.getSavedSearchesSuccess));
          }

          // Fetch profile next
          //   add(GetIndividualProfile(userId: userId));
        } else {
          emit(state.copyWith(
            status: LoginStatus.otpFailure,
            errorMessage: "Token or User ID missing",
          ));
        }
      } else {
        emit(state.copyWith(
          status: LoginStatus.otpFailure,
          errorMessage: "OTP verification failed: ${response.statusCode}",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.otpFailure,
        errorMessage: "OTP error: ${e.toString()}",
      ));
    }
  }

  getAllAssociatedGroups(
    GetAllAssociatedGroups event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.getAllGroupsLoading));

    final getallgroups = await loginRepository.getAllAssociatedGroup();

    if (getallgroups != null) {
      emit(state.copyWith(
          getAllAssociatedGroupModel: getallgroups,
          status: LoginStatus.getAllGroupsSuccess));
    } else {
      emit(state.copyWith(
        status: LoginStatus.getAllGroupsError,
        //errorMessage: "Failed to fetch profile: ${e.toString()}",
      ));
    }
  }

  getAllProfessionalProfiles(
    GetAllProfessionalProfiles event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.getAllProfessionalProfileLoading));

    final getallgroups = await loginRepository.getAllProfessionalProfile();

    if (getallgroups != null) {
      emit(state.copyWith(
          getAllProfessionalProfileModel: getallgroups,
          status: LoginStatus.getAllProfessionalProfileSuccess));
    } else {
      emit(state.copyWith(
        status: LoginStatus.getAllProfessionalProfileError,
        //errorMessage: "Failed to fetch profile: ${e.toString()}",
      ));
    }
  } //10@Testing

  _getIndividualProfile(
    GetIndividualProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.profileLoading));

    final profile = await loginRepository.individualProfile(event.userId);

    if (profile != null) {
      emit(state.copyWith(profile: profile, status: LoginStatus.profileLoaded));
    } else {
      emit(state.copyWith(
        status: LoginStatus.profileError,
        //errorMessage: "Failed to fetch profile: ${e.toString()}",
      ));
    }
  }

  _getProfessionalProfile(
    GetProfessionalProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(professionalStatus: ProfessionalStatus.loading));

    final profile = await loginRepository.professionalProfile(event.userId);

    if (profile != null) {
      emit(state.copyWith(
          professionalProfileModel: profile,
          professionalStatus: ProfessionalStatus.success));
    } else {
      emit(state.copyWith(professionalStatus: ProfessionalStatus.failure
          //errorMessage: "Failed to fetch profile: ${e.toString()}", //10@Testing
          ));
    }
  }

  _getOrganizationProfile(
    GetOrganizationProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(organizationalStatus: OrganizationalStatus.loading));

    final profile = await loginRepository.organizationProfile(event.userId);

    if (profile != null) {
      emit(state.copyWith(
          organizationProfileModel: profile,
          organizationalStatus: OrganizationalStatus.success));
    } else {
      emit(state.copyWith(organizationalStatus: OrganizationalStatus.failure
          //errorMessage: "Failed to fetch profile: ${e.toString()}",
          ));
    }
  }

  updateIndividualProfile(
    UpdateIndividualProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.updateProfileLoading));
    try {
      final response = await loginRepository.updateIndividualProfile(
        id: event.userId,
        profile: event.profile,
        profileImage: event.profileImage,
      );

      if (response.statusCode == 200) {
        //10@Testing
        // ✅ Refetch profile from server after update
        final refreshedProfile =
            await loginRepository.individualProfile(event.userId);

        emit(state.copyWith(
          status: LoginStatus.profileLoaded,
          profile: refreshedProfile,
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.updateProfileError,
          errorMessage: response.body,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.updateProfileError,
        errorMessage: e.toString(),
      ));
    }
  }

  updateProfessionalProfile(
    UpdateProfessionalProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        updateProfessionalProfileStatus:
            UpdateProfessionalProfileStatus.loading));
    try {
      final response = await loginRepository.updateProfessionalProfile(
        id: event.userId,
        profile: event.profile,
      ); //10@Testing

      if (response.statusCode == 200) {
        final refreshedProfile =
            await loginRepository.professionalProfile(event.userId);

        emit(state.copyWith(
          updateProfessionalProfileStatus:
              UpdateProfessionalProfileStatus.success,
          professionalProfileModel: refreshedProfile,
        ));
      } else {
        emit(state.copyWith(
          updateProfessionalProfileStatus:
              UpdateProfessionalProfileStatus.failure,
          errorMessage: response.body,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        updateProfessionalProfileStatus:
            UpdateProfessionalProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  removeAffiliations(
    RemoveAffiliations event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.removeAffilicationGroupsLoading));

    try {
      final response = await loginRepository.removeAffiliationsGroups(
        event.userId,
        event.groupId,
      );

      print("RemoveAffiliations Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // ✅ Dispatch the GetIndividualProfile event to refresh profile
        add(GetIndividualProfile(userId: event.userId));

        emit(state.copyWith(
            status: LoginStatus.removeAffilicationGroupsSuccess));
      } else {
        emit(state.copyWith(
          status: LoginStatus.removeAffilicationGroupsError,
          errorMessage:
              "Failed to remove group (Status: ${response.statusCode})",
        ));
      }
    } catch (e) {
      print("Error in RemoveAffiliations: $e");
      emit(state.copyWith(
        status: LoginStatus.removeAffilicationGroupsError,
        errorMessage: "An error occurred: ${e.toString()}",
      ));
    }
  }

  removeAffiliationsProfessional(
    RemoveAffiliationsProfrofessional event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        removeAffiliationGroupStatus:
            RemoveAffiliationGroupStatusProfessional.loading));

    try {
      final response =
          await loginRepository.removeAffiliationsGroupsProfessional(
        event.userId,
        event.groupId,
      );

      print("RemoveAffiliations Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // ✅ Dispatch the GetIndividualProfile event to refresh profile
        add(GetProfessionalProfile(userId: event.userId));
        //10@Testing
        emit(state.copyWith(
            removeAffiliationGroupStatus:
                RemoveAffiliationGroupStatusProfessional.success));
      } else {
        emit(state.copyWith(
          removeAffiliationGroupStatus:
              RemoveAffiliationGroupStatusProfessional.failure,
          errorMessage:
              "Failed to remove group (Status: ${response.statusCode})",
        ));
      }
    } catch (e) {
      print("Error in RemoveAffiliations: $e");
      emit(state.copyWith(
        removeAffiliationGroupStatus:
            RemoveAffiliationGroupStatusProfessional.failure,
        errorMessage: "An error occurred: ${e.toString()}",
      ));
    }
  }

  /* removeAffiliations(
    RemoveAffiliations event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.removeAffilicationGroupsLoading));

    try {
      final response = await loginRepository.removeAffiliationsGroups(
        event.userId,
        event.groupId,
      );
       emit(state.copyWith(
    profile: response,
    status: LoginStatus.removeAffilicationGroupsSuccess,
  ));

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(state.copyWith(status: LoginStatus.removeAffilicationGroupsSuccess));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "Login failed with status ${response.statusCode}",
        ));
      }
    } catch (e) {
      print("Error in login: $e");
      emit(state.copyWith(
        status: LoginStatus.removeAffilicationGroupsError,
        errorMessage: "An error occurred: ${e.toString()}",
      ));
    }
  }*/

  addAffiliations(
    AddAffiliations event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.addAffilicationGroupsLoading));

    try {
      final response = await loginRepository.addAffiliationsGroups(
        event.userId,
        event.groupId,
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(state.copyWith(status: LoginStatus.addAffilicationGroupsSuccess));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "Login failed with status ${response.statusCode}",
        ));
      }
    } catch (e) {
      print("Error in login: $e");
      emit(state.copyWith(
        status: LoginStatus.addAffilicationGroupsError,
        errorMessage: "An error occurred: ${e.toString()}",
      ));
    }
  }

  addAffiliationsProfrofessional(
    AddAffiliationsProfrofessional event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        addAffiliationGroupStatusProfessional:
            AddAffiliationGroupStatusProfessional.loading));

    try {
      final response = await loginRepository.addAffiliationsGroupsProfessional(
        event.userId,
        event.groupId,
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(state.copyWith(
            addAffiliationGroupStatusProfessional:
                AddAffiliationGroupStatusProfessional.success));
      } else {
        emit(state.copyWith(
          addAffiliationGroupStatusProfessional:
              AddAffiliationGroupStatusProfessional.failure,
          errorMessage: "Login failed with status ${response.statusCode}",
        ));
      }
    } catch (e) {
      print("Error in login: $e");
      emit(state.copyWith(
        addAffiliationGroupStatusProfessional:
            AddAffiliationGroupStatusProfessional.failure,
        errorMessage: "An error occurred: ${e.toString()}",
      ));
    }
  }

  /*updateIndividualProfile(
    UpdateIndividualProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.updateProfileLoading));

    try {
      final response = await loginRepository.updateIndividualProfile(
        id: event.userId,
        profile: event.profile,
        profileImage: event.profileImage,
      );

      if (response.statusCode == 200) {
        // ✅ API call succeeded
        emit(state.copyWith(status: LoginStatus.updateProfileSuccess));
      } else {
        // ❌ Server responded with error
        emit(state.copyWith(
          status: LoginStatus.updateProfileError,
          errorMessage: response.body.isNotEmpty
              ? response.body
              : 'Failed to update profile.',
        ));
      }
    } catch (e) {
      // ❌ Request threw an exception
      emit(state.copyWith(
        status: LoginStatus.updateProfileError,
        errorMessage: 'Exception: ${e.toString()}',
      ));
    }
  }*/

//   updateIndividualProfile(
//     UpdateIndividualProfile event, Emitter<LoginState> emit) async {
//   emit(state.copyWith(status: LoginStatus.updateProfileLoading));
//   try {
//     final response = await loginRepository.updateIndividualProfile(
//       id: event.userId,
//       profile: event.profile,
//       profileImage: event.profileImage,
//     );

//     if (response.statusCode == 200) {
//       emit(state.copyWith(status: LoginStatus.updateProfileSuccess));
//     } else {
//       emit(state.copyWith(
//         status: LoginStatus.updateProfileError,
//         errorMessage: response.body,
//       ));
//     }
//   } catch (e) {
//     emit(state.copyWith(
//       status: LoginStatus.updateProfileError,
//       errorMessage: e.toString(),
//     ));
//   }
// }

  /* updateIndividualProfile(
    UpdateIndividualProfile event, Emitter<LoginState> emit) async {
  emit(state.copyWith(status: LoginStatus.updateProfileLoading));
  try {
    final updatedProfile = await loginRepository.updateIndividualProfile(
      id: event.userId,
      profile: event.profile,
      profileImage: event.profileImage,
    );

    emit(state.copyWith(
      status: LoginStatus.updateProfileSuccess,
      profile: updatedProfile,
    ));
  } catch (e) {
    emit(state.copyWith(
      status: LoginStatus.updateProfileError,
      errorMessage: e.toString(),
    ));
  }
}*/

  /* updateIndividualProfile(
      UpdateIndividualProfile event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.updateProfileLoading));
    try {
      final response = await loginRepository.updateIndividualProfile(
        id: event.userId,
        profile: event.profile,
        profileImage: event.profileImage,
      );

      print("RESPONSE ${response}");
      print("RESPONSE $response");
      print("RESPONSE $response");

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(LoginState(status: LoginStatus.updateProfileSuccess));
      } else {
        emit(LoginState(
          status: LoginStatus.updateProfileError,
          errorMessage: response.body,
        ));
      }
    } catch (e) {
      emit(LoginState(
        status: LoginStatus.updateProfileError,
        errorMessage: e.toString(),
      ));
    }
  }*/

  logoutRequested(LogoutRequested event, emit) {
    emit(state.copyWith(
        status: LoginStatus.initial,
        professionalStatus: ProfessionalStatus.initial,
        organizationalStatus: OrganizationalStatus.initial));
  }

  getSavedSearches(
    GetSavedSearches event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        getSavedSearchesStatus:
            GetSavedSearchesStatus.getSavedSearchesLoading));

    final savedSearches = await loginRepository.getAllSavedSearches();

    print("SAVED SEARCHES $savedSearches");
    print("SAVED SEARCHES $savedSearches");
    print("SAVED SEARCHES $savedSearches");

    if (savedSearches != null) {
      emit(state.copyWith(
          savedSearchModel: savedSearches,
          getSavedSearchesStatus:
              GetSavedSearchesStatus.getSavedSearchesSuccess));
    } else {
      emit(state.copyWith(
          getSavedSearchesStatus: GetSavedSearchesStatus.getSavedSearchesError
          //errorMessage: "Failed to fetch profile: ${e.toString()}", //10@Testing
          ));
    }
  }

  loginThroughSMSOtpLoginRequest(
    LoginThroughSMSOtpLoginRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        loginThroughSMSOtpLoginRequestEnum:
            LoginThroughSMSOtpLoginRequestEnum.loading));
    try {
      final response = await loginRepository.requestLoginPasswordThroughSMS(
        event.phone,
        event.password,
      );

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        // final token = data['token'];

        emit(state.copyWith(
            loginThroughSMSOtpLoginRequestEnum:
                LoginThroughSMSOtpLoginRequestEnum.success));
      } else {
        emit(state.copyWith(
            loginThroughSMSOtpLoginRequestEnum:
                LoginThroughSMSOtpLoginRequestEnum.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          loginThroughSMSOtpLoginRequestEnum:
              LoginThroughSMSOtpLoginRequestEnum.failure));
    }
  }

  verificationLoginThroughSMSOtpLoginRequest(
    VerificationLoginThroughSMSOtpLoginRequest event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        verificationLoginThroughSMSOtpLoginRequestEnum:
            VerificationLoginThroughSMSOtpLoginRequestEnum.loading));
    try {
      final response = await loginRepository.verifySMSOtp(
        event.phone,
        event.otp,
      );

      if (response.statusCode == 200) {
        //  final data = jsonDecode(response.body);
        // final token = data['token'];

        emit(state.copyWith(
            verificationLoginThroughSMSOtpLoginRequestEnum:
                VerificationLoginThroughSMSOtpLoginRequestEnum.success));
      } else {
        emit(state.copyWith(
            verificationLoginThroughSMSOtpLoginRequestEnum:
                VerificationLoginThroughSMSOtpLoginRequestEnum.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          verificationLoginThroughSMSOtpLoginRequestEnum:
              VerificationLoginThroughSMSOtpLoginRequestEnum.failure));
    }
  }

  loginThroughSMSOtpRequestNew(
    LoginThroughSMSOtpRequestNew event,
    emit,
  ) async {
    print("OTP REQUEST LOGIN");
    print("OTP REQUEST LOGIN");
    print("OTP REQUEST LOGIN");
    print("OTP REQUEST LOGIN");
    print("OTP REQUEST LOGIN");
    print("OTP REQUEST LOGIN");
    print("OTP REQUEST LOGIN");
    emit(state.copyWith(
        loginThroughSMSOtpRequestNewEnum:
            LoginThroughSMSOtpRequestNewEnum.loading));
    try {
      final response = await loginRepository.requestLoginPasswordThroughSMS(
        event.phone,
        event.password,
      );
      print("RESPONSE $response");
      print("RESPONSE $response");
      print("RESPONSE $response");
      print("RESPONSE $response");
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        // final token = data['token'];

        emit(state.copyWith(
            loginThroughSMSOtpRequestNewEnum:
                LoginThroughSMSOtpRequestNewEnum.success));
      } else {
        emit(state.copyWith(
            loginThroughSMSOtpRequestNewEnum:
                LoginThroughSMSOtpRequestNewEnum.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          loginThroughSMSOtpRequestNewEnum:
              LoginThroughSMSOtpRequestNewEnum.failure));
    }
  }
}
