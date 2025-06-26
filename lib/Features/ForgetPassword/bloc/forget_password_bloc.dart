import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:readytogo/Repositories/forget_password_repository.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordState()) {
    on<RequestForgetPasswordOtp>(_onRequestOtp);
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
      final message = decoded['message'] ?? 'OTP sent successfully';
      emit(ForgetPasswordSuccess(message));
    } else {
      emit(ForgetPasswordFailure("Failed with status ${response.statusCode}"));
    }
  } catch (e) {
    emit(ForgetPasswordFailure("Error: ${e.toString()}"));
  }
}
