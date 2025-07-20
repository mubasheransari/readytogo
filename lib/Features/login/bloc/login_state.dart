import 'package:readytogo/Model/filter_search_model.dart';
import 'package:readytogo/Model/get_all_associated_groups_model.dart';
import 'package:readytogo/Model/get_all_individual_profile_model.dart';
import 'package:readytogo/Model/professional_profile_model.dart';
import 'package:readytogo/Model/search_model.dart';
import '../../../Model/individual_profile_model.dart';
import 'package:equatable/equatable.dart';

import '../../../Model/organization_profile_model.dart';
import '../../../Model/saved_search_model.dart';

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

enum FilterSearchStatus {
  filtersearchInitial,
  filtersearchLoading,
  filtersearchSuccess,
  filtersearchError,
}

enum GetSavedSearchesStatus {
  getSavedSearchesInitial,
  getSavedSearchesLoading,
  getSavedSearchesSuccess,
  getSavedSearchesError,
}

/// A unified state class for Login & Profile operations
// ignore: must_be_immutable
class LoginState extends Equatable {
  final List<SearchModel>? searchResults;
  final List<FilterSearchModel>? filterSearchResults;
  final SearchStatus searchStatus;
  final GetSavedSearchesStatus getSavedSearchesStatus;
  final FilterSearchStatus filterSearchStatus;
  final LoginStatus status;
  final ProfessionalStatus professionalStatus;
  final UpdateProfessionalProfileStatus updateProfessionalProfileStatus;
  final RemoveAffiliationGroupStatusProfessional removeAffiliationGroupStatus;
  AddAffiliationGroupStatusProfessional addAffiliationGroupStatusProfessional;
  final OrganizationalStatus organizationalStatus;
  final OrganizationProfileModel? organizationProfileModel;
  final List<SavedSearchModel>? savedSearchModel;
  final SearchModel? searchModel;
  final String? errorMessage;
  final String? token;
  final IndividualProfileModel? profile;
  final ProfessionalProfileModel? professionalProfileModel;
  final List<GetAllAssociatedGroupModel>? getAllAssociatedGroupModel;
  final List<GetAllProfessionalProfileModel>? getAllProfessionalProfileModel;

  LoginState(
      {this.searchResults,
      this.filterSearchResults,
      this.getSavedSearchesStatus =
          GetSavedSearchesStatus.getSavedSearchesInitial,
      this.searchStatus = SearchStatus.searchInitial,
      this.filterSearchStatus = FilterSearchStatus.filtersearchInitial,
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
      this.savedSearchModel,
      this.professionalProfileModel,
      this.getAllAssociatedGroupModel,
      this.searchModel,
      this.getAllProfessionalProfileModel});

  /// Copy the state with updated fields
  LoginState copyWith({
    List<SearchModel>? searchResults,
    List<FilterSearchModel>? filterSearchResults,
    SearchStatus? searchStatus,
    GetSavedSearchesStatus? getSavedSearchesStatus,
    FilterSearchStatus? filterSearchStatus,
    LoginStatus? status,
    ProfessionalStatus? professionalStatus,
    UpdateProfessionalProfileStatus? updateProfessionalProfileStatus,
    RemoveAffiliationGroupStatusProfessional? removeAffiliationGroupStatus,
    AddAffiliationGroupStatusProfessional?
        addAffiliationGroupStatusProfessional,
    OrganizationalStatus? organizationalStatus,
    OrganizationProfileModel? organizationProfileModel,
    List<SavedSearchModel>? savedSearchModel,
    SearchModel? searchModel,
    String? errorMessage,
    String? token,
    IndividualProfileModel? profile,
    ProfessionalProfileModel? professionalProfileModel,
    List<GetAllAssociatedGroupModel>? getAllAssociatedGroupModel,
    List<GetAllProfessionalProfileModel>? getAllProfessionalProfileModel,
  }) {
    return LoginState(
      savedSearchModel: savedSearchModel ?? this.savedSearchModel,
        filterSearchResults: filterSearchResults ?? this.filterSearchResults,
        searchResults: searchResults ?? this.searchResults,
        searchStatus: searchStatus ?? this.searchStatus,
        getSavedSearchesStatus:
            getSavedSearchesStatus ?? this.getSavedSearchesStatus,
        filterSearchStatus: filterSearchStatus ?? this.filterSearchStatus,
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
        savedSearchModel,
      
        searchResults,
        filterSearchResults,
        searchStatus,
        getSavedSearchesStatus,
        filterSearchStatus,
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
