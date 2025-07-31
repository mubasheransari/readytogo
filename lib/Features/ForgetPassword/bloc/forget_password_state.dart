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



class ResetForgetPasswordLoading extends ForgetPasswordState {}


class ResetForgetPasswordSuccess extends ForgetPasswordState {
  // final String message;
  // const ResetForgetPasswordSuccess(this.message);
  // @override
  // List<Object> get props => [message];
}

class ResetForgetPasswordFailure extends ForgetPasswordState {
  final String error;
  const ResetForgetPasswordFailure(this.error);
  @override
  List<Object> get props => [error];
}


class ForgetPasswordSMSInitial extends ForgetPasswordState {}

class ForgetPasswordSMSLoading extends ForgetPasswordState {}

class ForgetPasswordSMSSuccess extends ForgetPasswordState {
  final String message;

  const ForgetPasswordSMSSuccess(this.message);

  @override
  List<Object> get props => [message];
}
class ForgetPasswordSMSFailure extends ForgetPasswordState {
  final String error;

  const ForgetPasswordSMSFailure(this.error);

  @override
  List<Object> get props => [error];
}




class ForgetPasswordOtpVerifiedSuccessSMS extends ForgetPasswordState {
  //final String token;
  ForgetPasswordOtpVerifiedSuccessSMS();
}

class ForgetPasswordOtpVerifiedFailureSMS extends ForgetPasswordState {
  final String error;
  ForgetPasswordOtpVerifiedFailureSMS(this.error);
}









class ForgetPasswordVerificationLoadingNumber extends ForgetPasswordState {}

class ForgetPasswordVerificationSuccessNumber extends ForgetPasswordState {
 
}
class ForgetPasswordVerificationFailureNumber extends ForgetPasswordState {
  final String error;

  const ForgetPasswordVerificationFailureNumber(this.error);

  @override
  List<Object> get props => [error];
}