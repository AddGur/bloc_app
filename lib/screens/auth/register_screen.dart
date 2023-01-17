import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Name'),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthEventSignIn(
                  _emailController.text,
                  _passwordController.text,
                  _nameController.text));
            },
            child: const Text('Register user')),
        InkWell(
          child: const Text('Already have an account? Log in'),
          onTap: () {
            context.read<AuthBloc>().add(AuthEventShouldLogin());
          },
        )
      ]),
    );
  }
}
