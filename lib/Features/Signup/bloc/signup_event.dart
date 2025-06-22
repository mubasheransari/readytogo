import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends SignUpEvent {
  SignupEvent(
      {this.firstName,
      this.lastName,
      this.email,
      this.userName,
      this.password,
      this.confirmPassword,
      this.phoneNumber,
      this.zipCode,
      this.referralCode});
     

  String? firstName,
      lastName,
      email,
      userName,
      password,
      confirmPassword,
      phoneNumber,
      zipCode,
      referralCode;

  @override
  List<Object> get props => [
        firstName!,
        lastName!,
        email!,
        userName!,
        password!,
        confirmPassword!,
        phoneNumber!,
        zipCode!,
        referralCode!
      ];
}
