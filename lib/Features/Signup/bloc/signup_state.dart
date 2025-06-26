import 'package:equatable/equatable.dart';

 class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;
  SignUpSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpFailure extends SignUpState {
  final String error;
  SignUpFailure(this.error);

  @override
  List<Object> get props => [error];
}


// enum SignUpStateStates { loading, loaded, initial }

// // ignore: must_be_immutable
// class SignUpState extends Equatable {
//   SignUpStateStates signUpStateStates = SignUpStateStates.initial;

//   SignUpState({
//     this.signUpStateStates = SignUpStateStates.initial,
//   });

//   SignUpState copyWith(
//       {SignUpStateStates signUpStateStates = SignUpStateStates.initial}) {
//     return SignUpState(signUpStateStates: signUpStateStates);
//   }

//   @override
//   List<Object> get props => [signUpStateStates];
// }
