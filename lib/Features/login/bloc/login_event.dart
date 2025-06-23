import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class LoginWithEmailPassword extends LoginEvent {
  LoginWithEmailPassword({
    this.email,
    this.password,
  });

  String? email, password;

  @override
  List<Object> get props => [
        email!,
        password!,
      ];
}
