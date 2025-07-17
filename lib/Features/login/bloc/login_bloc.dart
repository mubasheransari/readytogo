import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
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
  }

  final LoginRepository loginRepository = LoginRepository();
  String? _tempToken;

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
    emit(state.copyWith(status: LoginStatus.otpLoading));

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

        print('User Role: $userRole');

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
            emit(state.copyWith(
              status: LoginStatus.profileLoaded,
              profile: profile,
            ));
          } else if (userRole == "Professional") {
            emit(state.copyWith(status: LoginStatus.profileLoading));

            final profile = await loginRepository.professionalProfile(userId);
            emit(state.copyWith(
              status: LoginStatus.professionalProfileLoaded,
              professionalProfileModel: profile,
            ));
          } //10@Testing
          else if (userRole == "Organization") {
            emit(state.copyWith(
                organizationalStatus: OrganizationalStatus.loading));

            final profile = await loginRepository.organizationProfile(userId);
            emit(state.copyWith(
              organizationalStatus: OrganizationalStatus.success,
              organizationProfileModel: profile,
            ));
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
          //errorMessage: "Failed to fetch profile: ${e.toString()}",
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
    emit(state.copyWith(status: LoginStatus.updateProfessionalProfileLoading));
    try {
      final response = await loginRepository.updateProfessionalProfile(
        id: event.userId,
        profile: event.profile,
      ); //10@Testing

      if (response.statusCode == 200) {
        final refreshedProfile =
            await loginRepository.individualProfile(event.userId);

        emit(state.copyWith(
          status: LoginStatus.professionalProfileLoaded,
          profile: refreshedProfile,
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.updateProfessionalProfileError,
          errorMessage: response.body,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.updateProfessionalProfileError,
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
}
