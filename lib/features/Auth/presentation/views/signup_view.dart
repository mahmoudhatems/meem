import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/functions/navigate_to_view.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/extension.dart';
import 'package:meem/core/utils/string.dart';
import 'package:meem/features/Auth/presentation/cubits/cubit/auth_cubit.dart';
import 'package:meem/features/Auth/presentation/widgets/custom_bottom.dart';
import 'package:meem/features/Auth/presentation/widgets/email_password.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'; // Import added

import '../../../../config/router/routes.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/social_sign_in.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),

                  // Title
                  Text(
                    "Create an \naccount",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontFamily: StringManager.fontFamily,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.textBlue,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Full Name field
                  CustomTextFormField(
                    controller: authCubit.registerNameController,
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      size: 24.sp,
                      color: ColorsManager.gray,
                    ),
                    hintText: "Full Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your full name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6.h),

                  // Phone Number field
                  CustomTextFormField(
                    controller: authCubit.registerPhoneController,
                    prefixIcon: Icon(
                      Icons.phone_iphone_outlined,
                      size: 24.sp,
                      color: ColorsManager.gray,
                    ),
                    hintText: "Phone Number",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 6.h),

                  // Email and Password fields
                  EmailAndPassword(
                    showConfirmPassword: true,
                    emailController: authCubit.registerEmailController,
                    formKeyController: authCubit.registerFormKeyController,
                    autovalidateModeController:
                        authCubit.registerAutovalidateModeController,
                    passwordController: authCubit.registerPasswordController,
                  ),
                  SizedBox(height: 10.h),

                  // Sign Up button
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is RegisterSuccessState) {
                        if (state.authModel.data != null) {
                          context.showAwesomeSnackBar(
                            title: 'Success!',
                            message: 'You have logged in successfully.',
                            contentType: ContentType.success,
                          );
                          if (state.authModel.data?.token != null) {
                            navigateToView(context, route: Routes.home);
                          }
                        } else {
                          context.showAwesomeSnackBar(
                            title: 'Error!',
                            message: state.authModel.message!,
                            contentType: ContentType.failure,
                          );
                        }
                      } else if (state is RegisterFailureState) {
                        context.showAwesomeSnackBar(
                          title: 'Error!',
                          message: state.errorMessage,
                          contentType: ContentType.failure,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoadingState) {
                        return SizedBox(
                          height: 55.h,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.mainBlue,
                            ),
                          ),
                        );
                      } else {
                        return CustomBottom(
                          text: "Sign Up",
                          onPressed: () {
                            if (authCubit
                                .registerFormKeyController.currentState!
                                .validate()) {
                              authCubit.register(
                                context,
                                email: authCubit.registerEmailController.text,
                                password:
                                    authCubit.registerPasswordController.text,
                                name: authCubit.registerNameController.text,
                                phone: authCubit.registerPhoneController.text,
                              );
                            } else {
                              authCubit.loginAutovalidateModeController =
                                  AutovalidateMode.always;
                            }
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Social SignIn widget (login suggestion)
                  SocialSignIn(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.logIn);
                    },
                    textBegin: "Have an Account?",
                    textEnd: " Login",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
