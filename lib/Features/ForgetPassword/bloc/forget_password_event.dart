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
