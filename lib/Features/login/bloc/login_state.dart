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