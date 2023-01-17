import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:my_notes_firebase_bloc/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogging()) {
    on<AuthEventSignIn>(_signUp);
    on<AuthEventLogIn>(_logIn);
    on<AuthEventLogOut>(_logOut);
    on<AuthEventShouldRegister>(_shouldRegiser);
    on<AuthEventShouldLogin>(_shouldLogin);
  }

  Future<void> _signUp(AuthEventSignIn event, Emitter<AuthState> emit) async {
    if (state is AuthStateRegistering) {
      try {
        final email = event.email;
        final password = event.password;
        final name = event.name;
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        AuthUser user = AuthUser(id: cred.user!.uid, email: email, name: name);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.id)
            .set(user.toJson());
        emit(AuthStateLogged(
            user: AuthUser(email: email, id: user.id, name: name)));
      } on FirebaseException catch (e) {
        emit(AuthStateRegistering());
        log(e.toString());
      }
    }
  }

  Future<void> _logIn(AuthEventLogIn event, Emitter<AuthState> emit) async {
    if (state is AuthStateLogging) {
      try {
        final email = event.email;
        final password = event.password;
        UserCredential cred = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        var userSnap = await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .get();
        emit(AuthStateLogged(
            user: AuthUser(
          email: email,
          id: cred.user!.uid,
          name: userSnap.data()!['username'],
        )));
      } on FirebaseAuthException catch (e) {
        emit(AuthStateLogging());
        log(e.toString());
      }
    }
  }

  Future<void> _logOut(AuthEventLogOut event, Emitter<AuthState> emit) async {
    if (state is AuthStateLogged) {
      await FirebaseAuth.instance.signOut();
      emit(AuthStateLogging());
    }
  }

  void _shouldRegiser(AuthEventShouldRegister event, Emitter<AuthState> emit) {
    emit(AuthStateRegistering());
  }

  void _shouldLogin(AuthEventShouldLogin event, Emitter<AuthState> emit) {
    emit(AuthStateLogging());
  }
}
