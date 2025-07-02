import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../Model/individual_profile_model.dart';

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

class VerifyOtpSubmitted extends LoginEvent {
  final String email;
  final String password;
  final String otp;

  const VerifyOtpSubmitted({
    required this.email,
    required this.password,
    required this.otp,
  });
}

class GetIndividualProfile extends LoginEvent {
  final String userId;
  const GetIndividualProfile({
    required this.userId,
  });
}

class GetProfessionalProfile extends LoginEvent {
  final String userId;
  const GetProfessionalProfile({
    required this.userId,
  });
}
class UpdateIndividualProfile extends LoginEvent {
  final String userId;
  final IndividualProfileModel profile;
  final File? profileImage;

  UpdateIndividualProfile({
    required this.userId,
    required this.profile,
    this.profileImage,
  });
}