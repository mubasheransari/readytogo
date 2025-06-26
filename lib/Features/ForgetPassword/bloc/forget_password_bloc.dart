import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:readytogo/Repositories/forget_password_repository.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordState()) {
    on<RequestForgetPasswordOtp>(_onRequestOtp);
    on<SubmitForgetPasswordOtp>(submitForgetPasswordOtp);
    on<ForgetPasswordToken>(forgetPasswordToken);
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
      print("FORGET PASSSWORD TOKEN ${decoded['token']}");
      print("FORGET PASSSWORD TOKEN ${decoded['token']}");
      print("FORGET PASSSWORD TOKEN ${decoded['token']}");
      print("FORGET PASSSWORD TOKEN ${decoded}");
      print("FORGET PASSSWORD TOKEN ${decoded}");

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
