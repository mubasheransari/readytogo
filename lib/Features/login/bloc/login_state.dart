import 'package:equatable/equatable.dart';

enum LoginStateStates { loading, loaded, initial }

// ignore: must_be_immutable
class LoginState extends Equatable {
  LoginStateStates loginStateStates = LoginStateStates.initial;

  LoginState({
    this.loginStateStates = LoginStateStates.initial,
  });

  LoginState copyWith(
      {LoginStateStates loginStateStates = LoginStateStates.initial}) {
    return LoginState(loginStateStates: loginStateStates);
  }

  @override
  List<Object> get props => [loginStateStates];
}
