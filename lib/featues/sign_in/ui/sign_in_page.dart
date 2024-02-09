import 'package:bloc_project_test/domain/repository/user_repository.dart';
import 'package:bloc_project_test/featues/sign_in/cubit/sign_in_cubit.dart';
import 'package:bloc_project_test/featues/sign_in/ui/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignInCubit>(
          create: (_) => SignInCubit(context.read<UserRepository>()),
          child: const SignInForm(),
        ),
      ),
    );
  }
}
