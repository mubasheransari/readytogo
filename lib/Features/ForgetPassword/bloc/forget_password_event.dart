import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestForgetPasswordOtp extends ForgetPasswordEvent {
  final String email;

  RequestForgetPasswordOtp({required this.email});

  @override
  List<Object?> get props => [email];
}

class ForgetPasswordOTP extends ForgetPasswordEvent {
  final String email;

  ForgetPasswordOTP({required this.email});

  @override
  List<Object?> get props => [email];
}

class SubmitForgetPasswordOtp extends ForgetPasswordEvent {
  final String email;
  final String otp;

  SubmitForgetPasswordOtp({
    required this.email,
    required this.otp,
  });
}

class ForgetPasswordToken extends ForgetPasswordEvent {
  final String email;

  ForgetPasswordToken({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResetForgetPassword extends ForgetPasswordEvent {
  final String email, password, confirmPassword;

  ResetForgetPassword(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object?> get props => [email, password, confirmPassword];
}

class RequestForgetPasswordOtpSMS extends ForgetPasswordEvent {
  final String phone;

  RequestForgetPasswordOtpSMS({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class ForgotPasswordVerificationSMS extends ForgetPasswordEvent {
  final String otp, phone;

  ForgotPasswordVerificationSMS({required this.otp, required this.phone});

  @override
  List<Object?> get props => [otp,phone];
}
