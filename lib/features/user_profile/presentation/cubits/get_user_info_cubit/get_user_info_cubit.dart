// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meem/core/utils/models/auth_model/auth_model.dart';
import 'package:meem/core/utils/models/auth_model/user_info_model.dart';
import 'package:meem/features/home/data/repos/home_repo.dart';

part 'get_user_info_state.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final HomeRepo homeRepo;
  GetUserInfoCubit({required this.homeRepo}) : super(GetUserInfoInitial());

  void getUserInfo() async {
    emit(GetUserInfoLoading());
    var result = await homeRepo.getUserInfo();
    result.fold(
        (failure) =>
            emit(GetUserInfoFailure(errorMessage: failure.errorMessage)),
        (userInfo) {
      nameController.text = userInfo.name!;
      emailController.text = userInfo.email!;
      phoneController.text = userInfo.phone!;

      return emit(GetUserInfoSuccess(user: userInfo));
    });
  }

  void updateUserInfo() async {
    emit(UpdateUserInfoLoading());
    var result = await homeRepo.updateUserInfo(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );
    result.fold(
        (failure) =>
            emit(UpdateUserInfoFailure(errorMessage: failure.errorMessage)),
        (userInfo) => emit(UpdateUserInfoSuccess(user: userInfo)));
  }
}
