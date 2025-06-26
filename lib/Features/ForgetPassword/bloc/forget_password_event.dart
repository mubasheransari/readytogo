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