import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes_firebase_bloc/bloc/cart_bloc/cart_bloc.dart';
import 'package:my_notes_firebase_bloc/bloc_observer.dart';
import 'package:my_notes_firebase_bloc/screens/list_screen.dart';
import 'package:my_notes_firebase_bloc/screens/auth/login_screen.dart';
import 'package:my_notes_firebase_bloc/screens/auth/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = TrackState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (BuildContext context) =>
              CartBloc()..add(const LoadCartEvent(cart: [])),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLogged) {
          return const ListScreen();
        }
        if (state is AuthEventLogOut || state is AuthStateLogging) {
          return const LoginScreen();
        } else if (state is AuthStateRegistering) {
          return const RegisterScreen();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
