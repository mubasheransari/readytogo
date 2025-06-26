import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readytogo/Features/Signup/bloc/signup_event.dart';
import 'package:readytogo/Features/Signup/bloc/signup_state.dart';
import 'package:readytogo/Repositories/signup_repositoy.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<SignupSubmitted>((event, emit) async {
      emit(SignUpLoading());
      try {
        final response = await SignUpRepository().registerUser(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          userName: event.userName,
          password: event.password,
          confirmPassword: event.confirmPassword,
          phoneNumber: event.phoneNumber,
          zipCode: event.zipCode,
          referralCode: event.referralCode,
          profileImage: event.profileImage,
        );
        final jsonnew = jsonDecode(response.body);

        print("SIGNUP $jsonnew");
        print("SIGNUP $jsonnew");
        print("SIGNUP $jsonnew");

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          emit(SignUpSuccess(json["message"] ?? "Registration successful."));
        } else {
          final json = jsonDecode(response.body);
          emit(SignUpFailure(json["message"] ?? "Something went wrong."));
        }
      } catch (e) {
        emit(SignUpFailure("An error occurred: ${e.toString()}"));
      }
    });
  }
}

SignUpRepository signUpRepository = SignUpRepository();



  // signUpEvent(SignUpEvent event, Emitter<SignUpState> emit) async {
  //   if (event is SignupEvent) {
  //     var response = await signUpRepository.signUpRepository(
  //       event.firstName ?? "",
  //       event.lastName ?? "",
  //       event.email ?? "",
  //       event.userName ?? "",
  //       event.password ?? "",
  //       event.confirmPassword ?? "",
  //       event.phoneNumber ?? "",
  //       event.zipCode ?? "",
  //       event.referralCode ?? "",
  //     );
  //     print("RESPONSE OF SIGNUP $response");
  //     print("RESPONSE OF SIGNUP $response");
  //     print("RESPONSE OF SIGNUP $response");
  //     print("RESPONSE OF SIGNUP $response");
  //   }
  // }

  

