import 'package:readytogo/Model/get_all_associated_groups_model.dart';
import 'package:readytogo/Model/professional_profile_model.dart';

import '../../../Model/individual_profile_model.dart';

import 'package:equatable/equatable.dart';

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
}

/// A unified state class for Login & Profile operations
class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;
  final String? token;
  final IndividualProfileModel? profile;
  final ProfessionalProfileModel? professionalProfileModel;
  final GetAllAssociatedGroupModel? getAllAssociatedGroupModel;

  const LoginState(
      {this.status = LoginStatus.initial,
      this.errorMessage,
      this.token,
      this.profile,
      this.professionalProfileModel,
      this.getAllAssociatedGroupModel
      });

  /// Copy the state with updated fields
  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
    String? token,
    IndividualProfileModel? profile,
    ProfessionalProfileModel? professionalProfileModel,
    GetAllAssociatedGroupModel? getAllAssociatedGroupModel
  }) {
    return LoginState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        token: token ?? this.token,
        profile: profile ?? this.profile,
        professionalProfileModel:
            professionalProfileModel ?? this.professionalProfileModel,
            getAllAssociatedGroupModel: getAllAssociatedGroupModel ?? this.getAllAssociatedGroupModel
            );
  }

  @override
  List<Object?> get props =>
      [status, errorMessage, token, profile, professionalProfileModel,getAllAssociatedGroupModel];

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
