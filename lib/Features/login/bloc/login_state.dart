 class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}



// import 'package:equatable/equatable.dart';

// enum LoginStateStates { initial, success , failure }

// // ignore: must_be_immutable
// class LoginState extends Equatable {
//   LoginStateStates loginStateStates = LoginStateStates.initial;

//   LoginState({
//     this.loginStateStates = LoginStateStates.initial,
//   });

//   LoginState copyWith(
//       {LoginStateStates loginStateStates = LoginStateStates.initial}) {
//     return LoginState(loginStateStates: loginStateStates);
//   }

//   @override
//   List<Object> get props => [loginStateStates];
// }
