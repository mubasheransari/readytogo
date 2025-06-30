 import '../../../Model/individual_profile_model.dart';

class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

class LoginOtpLoading extends LoginState {}

class LoginOtpSuccess extends LoginState {
  final String token;

  LoginOtpSuccess(this.token);
}


// class LoginOtpSuccess extends LoginState {}

class LoginOtpFailure extends LoginState {
  final String error;

  LoginOtpFailure(this.error);
}

//profile states

class ProfileInitial extends LoginState {}

class ProfileLoading extends LoginState {}

class ProfileLoaded extends LoginState {
  final IndividualProfileModel profile;

   ProfileLoaded(this.profile);
}

class ProfileError extends LoginState {
  final String message;

   ProfileError(this.message);
}

class LoginOtpAndProfileSuccess extends LoginState {
  final String token;
  final IndividualProfileModel profile;

   LoginOtpAndProfileSuccess({
    required this.token,
    required this.profile,
  });

  @override
  List<Object> get props => [token, profile];
}
