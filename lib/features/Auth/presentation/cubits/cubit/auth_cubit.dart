// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meem/core/utils/models/auth_model/auth_model.dart';
import 'package:meem/features/Auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AutovalidateMode loginAutovalidateModeController = AutovalidateMode.disabled;
  final GlobalKey<FormState> loginFormKeyController = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  AutovalidateMode registerAutovalidateModeController =
      AutovalidateMode.disabled;
  final GlobalKey<FormState> registerFormKeyController = GlobalKey<FormState>();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerPhoneController = TextEditingController();
  final AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  Future login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    var result = await authRepo.login(email: email, password: password);
    result.fold(
      (failure) => emit(LoginFailureState(errorMessage: failure.errorMessage)),
      (authModel) => emit(
        LoginSuccessState(authModel: authModel),
      ),
    );
  }

  Future register(
    context, {
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    var result = await authRepo.register(
      context,
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    result.fold(
      (failure) =>
          emit(RegisterFailureState(errorMessage: failure.errorMessage)),
      (authModel) => emit(
        RegisterSuccessState(authModel: authModel),
      ),
    );
  }
}
