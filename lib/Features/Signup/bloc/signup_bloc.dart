import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readytogo/Features/Signup/bloc/signup_event.dart';
import 'package:readytogo/Features/Signup/bloc/signup_state.dart';
import 'package:readytogo/Repositories/signup_repositoy.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<SignupEvent>(signUpEvent);
    // on<EmailValidationEvent>((event, emit) => _onEmailChanged(event, emit));
    //on<OnSubmitButtonPressed>((event, emit) => _onSubmitted(event, emit));
  }
  SignUpRepository signUpRepository = SignUpRepository();

  // signup(SignUpEvent event, state) {

  //   signUpRepository.signUpRepository();
  // }

  signUpEvent(SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event is SignupEvent) {
      var response = await signUpRepository.signUpRepository(
        event.firstName ?? "",
        event.lastName ?? "",
        event.email ?? "",
        event.userName ?? "",
        event.password ?? "",
        event.confirmPassword ?? "",
        event.phoneNumber ?? "",
        event.zipCode ?? "",
        event.referralCode ?? "",
      );
      print("RESPONSE OF SIGNUP $response");
      print("RESPONSE OF SIGNUP $response");
      print("RESPONSE OF SIGNUP $response");
      print("RESPONSE OF SIGNUP $response");
    }
  }

  // _onEmailChanged(event, emit) {
  //   emit(ForgotPasswordState().copyWith(email: Email.dirty(event.email)));
  // }

  // Future<void> _onSubmitted(event, emit) async {
  //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
  //   Map response = await repo.requestPasswordReset(state.email.value);
  //   bool isVerified = response['success'];
  //   emit(state.copyWith(
  //       status: isVerified ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure,
  //       response: isVerified ? '' : response['message']));
  // }

}
