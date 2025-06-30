import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginWithEmailPassword>(_loginWithEmailPassword);
    on<VerifyOtpSubmitted>(_onVerifyOtpSubmitted);
    on<GetIndividualProfile>(_getIndividualProfile);
  }

  final LoginRepository loginRepository = LoginRepository();
  String? _tempToken;

  _loginWithEmailPassword(
    LoginWithEmailPassword event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final response = await loginRepository.loginWithEmailPassword(
        event.email ?? "",
        event.password ?? "",
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "Login failed with status ${response.statusCode}",
        ));
      }
    } catch (e) {
      print("Error in login: $e");
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: "An error occurred: ${e.toString()}",
      ));
    }
  }

  _onVerifyOtpSubmitted(
    VerifyOtpSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.otpLoading));

    try {
      final response = await loginRepository.verifyOTP(
        event.email,
        event.password,
        event.otp,
      );

      print("VERIFY OTP: $response");

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final token = responseBody['token'];
        final userId = responseBody['id'];

        var storage = GetStorage();
        storage.write("id", userId);

        if (token != null && userId != null) {
          _tempToken = token;

          emit(state.copyWith(
            status: LoginStatus.otpSuccess,
            token: token,
          ));

          // Fetch profile next
          add(GetIndividualProfile(userId: userId));
        } else {
          emit(state.copyWith(
            status: LoginStatus.otpFailure,
            errorMessage: "Token or User ID missing",
          ));
        }
      } else {
        emit(state.copyWith(
          status: LoginStatus.otpFailure,
          errorMessage: "OTP verification failed: ${response.statusCode}",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.otpFailure,
        errorMessage: "OTP error: ${e.toString()}",
      ));
    }
  }

  _getIndividualProfile(
    GetIndividualProfile event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.profileLoading));

    final profile = await loginRepository.individualProfile(event.userId);

    if (profile != null) {
      emit(state.copyWith(profile: profile, status: LoginStatus.profileLoaded));
    } else {
      emit(state.copyWith(
        status: LoginStatus.profileError,
        //errorMessage: "Failed to fetch profile: ${e.toString()}",
      ));
    }
  }
}
