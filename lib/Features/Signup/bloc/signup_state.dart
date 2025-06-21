import 'package:equatable/equatable.dart';

enum SignUpStateStates { loading, loaded, initial }

// ignore: must_be_immutable
class SignUpState extends Equatable {
  SignUpStateStates signUpStateStates = SignUpStateStates.initial;

  SignUpState({
    this.signUpStateStates = SignUpStateStates.initial,
  });

  SignUpState copyWith(
      {SignUpStateStates signUpStateStates = SignUpStateStates.initial}) {
    return SignUpState(signUpStateStates: signUpStateStates);
  }

  @override
  List<Object> get props => [signUpStateStates];
}
