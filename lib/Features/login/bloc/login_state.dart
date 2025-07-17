import 'package:readytogo/Model/get_all_associated_groups_model.dart';
import 'package:readytogo/Model/get_all_individual_profile_model.dart';
import 'package:readytogo/Model/professional_profile_model.dart';
import 'package:readytogo/Model/search_model.dart';
import '../../../Model/individual_profile_model.dart';
import 'package:equatable/equatable.dart';

import '../../../Model/organization_profile_model.dart';

/// Enum to represent different states in the login process
enum LoginStatus {
  initial,
  loading,
  success,
  failure,
  otpLoading,
  otpSuccess,
  otpFailure,
  profileLoading,
  profileLoaded,
  profileError,
  otpAndProfileSuccess,
  professionalProfileLoading,
  professionalProfileLoaded,
  professionalProfileError,
  updateProfileLoading,
  updateProfileSuccess,
  updateProfileError,
  getAllGroupsLoading,
  getAllGroupsSuccess,
  getAllGroupsError,
  removeAffilicationGroupsLoading,
  removeAffilicationGroupsSuccess,
  removeAffilicationGroupsError,
  addAffilicationGroupsLoading,
  addAffilicationGroupsSuccess,
  addAffilicationGroupsError,
  getAllProfessionalProfileLoading,
  getAllProfessionalProfileSuccess,
  getAllProfessionalProfileError,
  updateProfessionalProfileLoading,
  updateProfessionalProfileSuccess,
  updateProfessionalProfileError,
}

enum ProfessionalStatus {
  initial,
  loading,
  success,
  failure,
}

enum UpdateProfessionalProfileStatus {
  initial,
  loading,
  success,
  failure,
}

enum RemoveAffiliationGroupStatusProfessional {
  initial,
  loading,
  success,
  failure,
}

enum AddAffiliationGroupStatusProfessional {
  initial,
  loading,
  success,
  failure,
}

enum AddAffiliationGroupStatus {
  initial,
  loading,
  success,
  failure,
}

enum OrganizationalStatus {
  initial,
  loading,
  success,
  failure,
}

enum SearchStatus {
  searchInitial,
  searchLoading,
  searchSuccess,
  searchError,
}

/// A unified state class for Login & Profile operations
class LoginState extends Equatable {
  final List<SearchModel>? searchResults;
  final SearchStatus searchStatus;
  final LoginStatus status;
  final ProfessionalStatus professionalStatus;
  final UpdateProfessionalProfileStatus updateProfessionalProfileStatus;
  final RemoveAffiliationGroupStatusProfessional removeAffiliationGroupStatus;
  AddAffiliationGroupStatusProfessional addAffiliationGroupStatusProfessional;
  final OrganizationalStatus organizationalStatus;
  final OrganizationProfileModel? organizationProfileModel;
  final SearchModel? searchModel;
  final String? errorMessage;
  final String? token;
  final IndividualProfileModel? profile;
  final ProfessionalProfileModel? professionalProfileModel;
  final List<GetAllAssociatedGroupModel>? getAllAssociatedGroupModel;
  final List<GetAllProfessionalProfileModel>? getAllProfessionalProfileModel;

  LoginState(
      {this.searchResults,
      this.searchStatus = SearchStatus.searchInitial,
      this.status = LoginStatus.initial,
      this.professionalStatus = ProfessionalStatus.initial,
      this.updateProfessionalProfileStatus =
          UpdateProfessionalProfileStatus.initial,
      this.removeAffiliationGroupStatus =
          RemoveAffiliationGroupStatusProfessional.initial,
      this.addAffiliationGroupStatusProfessional =
          AddAffiliationGroupStatusProfessional.initial,
      this.organizationalStatus = OrganizationalStatus.initial,
      this.organizationProfileModel,
      this.errorMessage,
      this.token,
      this.profile,
      this.professionalProfileModel,
      this.getAllAssociatedGroupModel,
      this.searchModel,
      this.getAllProfessionalProfileModel});

  /// Copy the state with updated fields
  LoginState copyWith({
    List<SearchModel>? searchResults,
    SearchStatus ? searchStatus,
    LoginStatus? status,
    ProfessionalStatus? professionalStatus,
    UpdateProfessionalProfileStatus? updateProfessionalProfileStatus,
    RemoveAffiliationGroupStatusProfessional? removeAffiliationGroupStatus,
    AddAffiliationGroupStatusProfessional?
        addAffiliationGroupStatusProfessional,
    OrganizationalStatus? organizationalStatus,
    OrganizationProfileModel? organizationProfileModel,
    SearchModel? searchModel,
    String? errorMessage,
    String? token,
    IndividualProfileModel? profile,
    ProfessionalProfileModel? professionalProfileModel,
    List<GetAllAssociatedGroupModel>? getAllAssociatedGroupModel,
    List<GetAllProfessionalProfileModel>? getAllProfessionalProfileModel,
  }) {
    return LoginState(
        searchResults: searchResults ?? this.searchResults,
        searchStatus: searchStatus ?? this.searchStatus,
        status: status ?? this.status,
        professionalStatus: professionalStatus ?? this.professionalStatus,
        updateProfessionalProfileStatus: updateProfessionalProfileStatus ??
            this.updateProfessionalProfileStatus,
        removeAffiliationGroupStatus:
            removeAffiliationGroupStatus ?? this.removeAffiliationGroupStatus,
        addAffiliationGroupStatusProfessional:
            addAffiliationGroupStatusProfessional ??
                this.addAffiliationGroupStatusProfessional,
        organizationProfileModel:
            organizationProfileModel ?? this.organizationProfileModel,
        organizationalStatus: organizationalStatus ?? this.organizationalStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        token: token ?? this.token,
        profile: profile ?? this.profile,
        professionalProfileModel:
            professionalProfileModel ?? this.professionalProfileModel,
        searchModel: searchModel ?? this.searchModel,
        getAllAssociatedGroupModel:
            getAllAssociatedGroupModel ?? this.getAllAssociatedGroupModel,
        getAllProfessionalProfileModel: getAllProfessionalProfileModel ??
            this.getAllProfessionalProfileModel);
  }

  @override
  List<Object?> get props => [
        searchStatus,
        status,
        professionalStatus,
        updateProfessionalProfileStatus,
        removeAffiliationGroupStatus,
        addAffiliationGroupStatusProfessional,
        organizationalStatus,
        organizationProfileModel,
        searchModel,
        searchResults,
        errorMessage,
        token,
        profile,
        professionalProfileModel,
        getAllAssociatedGroupModel,
        getAllProfessionalProfileModel
      ];

  @override
  String toString() {
    return 'LoginState(status: $status, errorMessage: $errorMessage, token: $token, profile: $profile)';
  }
}



// class LoginState {}

// class LoginInitial extends LoginState {}

// class LoginLoading extends LoginState {}

// class LoginSuccess extends LoginState {}

// class LoginFailure extends LoginState {
//   final String error;

//   LoginFailure(this.error);
// }

// class LoginOtpLoading extends LoginState {}

// class LoginOtpSuccess extends LoginState {
//   final String token;

//   LoginOtpSuccess(this.token);
// }


// // class LoginOtpSuccess extends LoginState {}

// class LoginOtpFailure extends LoginState {
//   final String error;

//   LoginOtpFailure(this.error);
// }

// //profile states

// class ProfileInitial extends LoginState {}

// class ProfileLoading extends LoginState {}

// class ProfileLoaded extends LoginState {
//   final IndividualProfileModel profile;

//    ProfileLoaded(this.profile);
// }

// class ProfileError extends LoginState {
//   final String message;

//    ProfileError(this.message);
// }

// class LoginOtpAndProfileSuccess extends LoginState {
//   final String token;
//   final IndividualProfileModel profile;

//    LoginOtpAndProfileSuccess({
//     required this.token,
//     required this.profile,
//   });

//   @override
//   List<Object> get props => [token, profile];
// }
