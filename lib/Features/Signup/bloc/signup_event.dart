import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupSubmitted extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String userName;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String zipCode;
  final String referralCode;
  final File profileImage;

  SignupSubmitted({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.zipCode,
    required this.referralCode,
    required this.profileImage,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        userName,
        password,
        confirmPassword,
        phoneNumber,
        zipCode,
        referralCode,
        profileImage,
      ];
}


// abstract class SignUpEvent extends Equatable {
//   const SignUpEvent();

//   @override
//   List<Object> get props => [];
// }

// class SignupEvent extends SignUpEvent {
//   SignupEvent(
//       {this.firstName,
//       this.lastName,
//       this.email,
//       this.userName,
//       this.password,
//       this.confirmPassword,
//       this.phoneNumber,
//       this.zipCode,
//       this.referralCode});
     

//   String? firstName,
//       lastName,
//       email,
//       userName,
//       password,
//       confirmPassword,
//       phoneNumber,
//       zipCode,
//       referralCode;

//   @override
//   List<Object> get props => [
//         firstName!,
//         lastName!,
//         email!,
//         userName!,
//         password!,
//         confirmPassword!,
//         phoneNumber!,
//         zipCode!,
//         referralCode!
//       ];
// }
