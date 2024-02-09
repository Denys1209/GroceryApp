import 'package:bloc/bloc.dart';
import 'package:bloc_project_test/domain/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../exceptions/SignUpWithEmailAndPasswordFailure .dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._userRepository) : super(const SignUpState());

  final UserRepository _userRepository;

  void emailChanged(String value) {
    final email = value;
    emit(
      state.copyWith(
        email: email,
        isValid:
            (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email) &&
                state.confirmedPassword == state.password &&
                RegExp('^(?=.*[A-Z]).{6,}\$').hasMatch(state.password)),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = value;
    emit(
      state.copyWith(
        password: password,
        isValid: (RegExp('^(?=.*[A-Z]).{6,}\$').hasMatch(password) &&
            state.confirmedPassword == password),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = value;
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: (RegExp('^(?=.*[A-Z]).{6,}\$').hasMatch(confirmedPassword) &&
            state.password == confirmedPassword),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final AuthErrors response = await _userRepository.SignUpUser(
          email: state.email, password: state.password);
      if (response == AuthErrors.Success) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
