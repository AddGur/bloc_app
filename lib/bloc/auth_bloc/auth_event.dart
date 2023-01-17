part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthEventSignIn(this.email, this.password, this.name);
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn(this.email, this.password);
}

class AuthEventLogOut extends AuthEvent {}

class AuthEventShouldRegister extends AuthEvent {}

class AuthEventShouldLogin extends AuthEvent {}
