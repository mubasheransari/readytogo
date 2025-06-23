import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readytogo/Features/login/bloc/login_event.dart';
import 'package:readytogo/Features/login/bloc/login_state.dart';
import 'package:readytogo/Repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginWithEmailPassword>(loginWithEmailPassword);
  }
  LoginRepository loginRepository = LoginRepository();

  loginWithEmailPassword(
      LoginWithEmailPassword event, Emitter<LoginState> emit) async {
    await loginRepository.loginWithEmailPassword(
      event.email ?? "",
      event.password ?? "",
    );
  }
}
