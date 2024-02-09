import 'package:bloc_project_test/domain/repository/user_repository.dart';
import 'package:bloc_project_test/featues/sign_up/cubit/sign_up_cubit.dart';
import 'package:bloc_project_test/featues/sign_up/ui/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<UserRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
