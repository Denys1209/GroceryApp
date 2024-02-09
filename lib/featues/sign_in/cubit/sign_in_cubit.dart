import 'package:bloc/bloc.dart';
import 'package:bloc_project_test/domain/repository/user_repository.dart';
import 'package:bloc_project_test/featues/sign_in/exceptions/sign_in_with_email_and_password_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._userRepository) : super(const SignInState());

  final UserRepository _userRepository;

  void emailChanged(String value) {
    final email = value;
    emit(
      state.copyWith(
        email: email,
        isValid: RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = value;
    emit(
      state.copyWith(
          password: password,
          isValid: RegExp('^(?=.*[A-Z]).{6,}\$').hasMatch(password)),
    );
  }

  Future<void> signInFormSubmitted() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final LoginErrors response = await _userRepository.loginUser(
          email: state.email, password: state.password);
      if (response == LoginErrors.Success) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } on SignInWithEmailAndPasswordFailure catch (e) {
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
