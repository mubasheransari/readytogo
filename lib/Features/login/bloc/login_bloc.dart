import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginWithEmailPassword>(loginWithEmailPassword);
    on<VerifyOtpSubmitted>(_onVerifyOtpSubmitted);
  }
  LoginRepository loginRepository = LoginRepository();

  // loginWithEmailPassword(
  //     LoginWithEmailPassword event, Emitter<LoginState> emit) async {
  //   await loginRepository.loginWithEmailPassword(
  //     event.email ?? "",
  //     event.password ?? "",
  //   );
  // }

  /*loginWithEmailPassword(
    LoginWithEmailPassword event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final response = await loginRepository.loginWithEmailPassword(
        event.email ?? "",
        event.password ?? "",
      );

      print("Status Code: ${response.statusCode}");
      print("Status Code: ${response.statusCode}");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        // parse response.body if needed
        emit(state.copyWith(loginStateStates: LoginStateStates.success));
      } else {
        emit(state.copyWith(loginStateStates: LoginStateStates.failure));
        //  emit(LoginFailure("Login failed with status ${response.statusCode}"));
      }
    } catch (e) {
      print("Error in login: $e");
      emit(state.copyWith(loginStateStates: LoginStateStates.failure));
      // emit(LoginFailure("An error occurred: ${e.toString()}"));
    }
  }*/

  loginWithEmailPassword(
    LoginWithEmailPassword event,
    Emitter<LoginState> emit,
  ) async {
        emit(LoginLoading());
    try {
      final response = await loginRepository.loginWithEmailPassword(
        event.email ?? "",
        event.password ?? "",
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Login failed with status ${response.statusCode}"));
      }
    } catch (e) {
      print("Error in login: $e");
      emit(LoginFailure("An error occurred: ${e.toString()}"));
    }
  }

  _onVerifyOtpSubmitted(
  VerifyOtpSubmitted event,
  Emitter<LoginState> emit,
) async {
  emit(LoginOtpLoading());

  try {
    final response = await loginRepository.verifyOTP(
      event.email,
      event.password,
      event.otp,
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      final token = responseBody['token'];
      if (token != null) {
        emit(LoginOtpSuccess(token));
      } else {
        emit(LoginOtpFailure("Token not found in response"));
      }
    } else {
      emit(LoginOtpFailure(
          "OTP verification failed with status ${response.statusCode}"));
    }
  } catch (e) {
    emit(LoginOtpFailure("OTP verification error: ${e.toString()}"));
  }
}


  // _onVerifyOtpSubmitted(
  //   VerifyOtpSubmitted event,
  //   Emitter<LoginState> emit,
  // ) async {
  //   emit(LoginOtpLoading());
  //   try {
  //     final response = await loginRepository.verifyOTP(
  //       event.email,
  //       event.password,
  //       event.otp,
  //     );

  //     if (response.statusCode == 200) {
  //       // print("RESPONSE ${response["token"]}");
  //       // print("RESPONSE ${response["token"]}");
  //       emit(LoginOtpSuccess());
  //     } else {
  //       emit(LoginOtpFailure(
  //           "OTP verification failed with status ${response.statusCode}"));
  //     }
  //   } catch (e) {
  //     emit(LoginOtpFailure("OTP verification error: ${e.toString()}"));
  //   }
  // }
}
