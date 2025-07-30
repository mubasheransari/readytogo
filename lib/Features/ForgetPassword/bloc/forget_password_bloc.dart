import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Repositories/forget_password_repository.dart';
import 'package:readytogo/widgets/toast_widget.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordState()) {
    on<RequestForgetPasswordOtp>(_onRequestOtp);
    on<SubmitForgetPasswordOtp>(submitForgetPasswordOtp);
    on<ForgetPasswordToken>(forgetPasswordToken);
    on<ResetForgetPassword>(resetForgetPassword);
    on<RequestForgetPasswordOtpSMS>(forgotPasswordThroughSMS);
  }
}
// ForgetPasswordBloc()
//     : super(ForgetPasswordInitial()) {
//   on<RequestForgetPasswordOtp>(_onRequestOtp);
// }

ForgetPasswordRepository forgetPasswordRepository = ForgetPasswordRepository();

_onRequestOtp(
  RequestForgetPasswordOtp event,
  Emitter<ForgetPasswordState> emit,
) async {
  emit(ForgetPasswordLoading());

  try {
    final response = await forgetPasswordRepository.requestOTPForgetPassword(
      event.email,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print("RESPONSE OF FORGET $decoded");
      print("RESPONSE OF FORGET $decoded");
      print("RESPONSE OF FORGET $decoded");
      final message = decoded['message'] ?? 'OTP sent successfully';
      emit(ForgetPasswordSuccess(message));
    } else {
      emit(ForgetPasswordFailure("Failed with status ${response.statusCode}"));
    }
  } catch (e) {
    emit(ForgetPasswordFailure("Error: ${e.toString()}"));
  }
}

forgetPasswordToken(
  ForgetPasswordToken event,
  Emitter<ForgetPasswordState> emit,
) async {
  emit(ForgetPasswordTokenLoading());

  try {
    final response = await forgetPasswordRepository.forgetPasswordToken(
      event.email,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print("TOKEN ::: ${decoded['token']}");
      print("TOKEN ::: ${decoded['token']}");
      print("TOKEN ::: ${decoded['token']}");

      final box = GetStorage();
      box.write("token-forgetPassword", decoded['token']);

      final message = decoded['message'] ?? 'OTP sent successfully';
      emit(ForgetPasswordTokenSuccess(message));
    } else {
      emit(ForgetPasswordTokenFailure(
          "Failed with status ${response.statusCode}"));
    }
  } catch (e) {
    emit(ForgetPasswordTokenFailure("Error: ${e.toString()}"));
  }
}

submitForgetPasswordOtp(
  SubmitForgetPasswordOtp event,
  Emitter<ForgetPasswordState> emit,
) async {
  emit(ForgetPasswordLoading());
  try {
    final response = await forgetPasswordRepository.verifyOTPForgetPassword(
      event.email,
      event.otp,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      emit(ForgetPasswordOtpVerifiedSuccess());
    } else {
      emit(ForgetPasswordOtpVerifiedFailure(
          "Verification failed: ${response.statusCode}"));
    }
  } catch (e) {
    emit(ForgetPasswordOtpVerifiedFailure(
        "Verification error: ${e.toString()}"));
  }
}

resetForgetPassword(
  ResetForgetPassword event,
  Emitter<ForgetPasswordState> emit,
) async {
  emit(ResetForgetPasswordLoading());
  try {
    final response = await forgetPasswordRepository.resetForgetPassword(
        event.email, event.password, event.confirmPassword);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("RESET PASSWORD $data");
      print("RESET PASSWORD $data");
      print("RESET PASSWORD $data"); //Testing1234@
      toastWidget("Password has been reset.", Colors.green);

      emit(ResetForgetPasswordSuccess());
    } else {
      emit(ResetForgetPasswordFailure(
          "Verification failed: ${response.statusCode}"));
    }
  } catch (e) {
    emit(ResetForgetPasswordFailure("Verification error: ${e.toString()}"));
  }
}

forgotPasswordThroughSMS(
  RequestForgetPasswordOtpSMS event,
  Emitter<ForgetPasswordState> emit,
) async {
  emit(ForgetPasswordSMSInitial());

  try {
    final response =
        await forgetPasswordRepository.requestForgetPasswordThroughSMS(
      event.phone,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print("RESPONSE OF FORGET $decoded");
      print("RESPONSE OF FORGET $decoded");
      print("RESPONSE OF FORGET $decoded");
      final message = decoded['message'] ?? 'OTP sent successfully';
      emit(ForgetPasswordSMSSuccess(message));
    } else {
      emit(ForgetPasswordSMSFailure(
          "Failed with status ${response.statusCode}"));
    }
  } catch (e) {
    emit(ForgetPasswordSMSFailure("Error: ${e.toString()}"));
  }
}
