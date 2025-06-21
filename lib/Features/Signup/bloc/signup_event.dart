import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignupEvent extends SignUpEvent {
  const SignupEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}
