part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateLogging extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthStateRegistering extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthStateLogged extends AuthState {
  final AuthUser user;

  const AuthStateLogged({required this.user});
  @override
  List<Object> get props => [user];
}
