import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

 class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;

  const ForgetPasswordSuccess(this.message);

  @override
  List<Object> get props => [message];
}
class ForgetPasswordFailure extends ForgetPasswordState {
  final String error;

  const ForgetPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}


class ForgetPasswordOtpVerifiedSuccess extends ForgetPasswordState {
  //final String token;
  ForgetPasswordOtpVerifiedSuccess();
}

class ForgetPasswordOtpVerifiedFailure extends ForgetPasswordState {
  final String error;
  ForgetPasswordOtpVerifiedFailure(this.error);
}

class ForgetPasswordTokenLoading extends ForgetPasswordState {}


class ForgetPasswordTokenSuccess extends ForgetPasswordState {
  final String message;
  const ForgetPasswordTokenSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class ForgetPasswordTokenFailure extends ForgetPasswordState {
  final String error;
  const ForgetPasswordTokenFailure(this.error);
  @override
  List<Object> get props => [error];
}