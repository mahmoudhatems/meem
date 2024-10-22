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
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'; // Add this import

import 'package:meem/config/router/routes.dart';
import '../widgets/social_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    "Welcome\nBack!",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontFamily: StringManager.fontFamily,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.textBlue,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Email and Password Fields
                  EmailAndPassword(
                    formKeyController: authCubit.loginFormKeyController,
                    autovalidateModeController:
                        authCubit.loginAutovalidateModeController,
                    emailController: authCubit.loginEmailController,
                    passwordController: authCubit.loginPasswordController,
                  ),

                  // Forgot password option
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.forgotPassword);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorsManager.mainBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Login button
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
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
                      } else if (state is LoginFailureState) {
                        context.showAwesomeSnackBar(
                          title: 'Error!',
                          message: state.errorMessage,
                          contentType: ContentType.failure,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
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
                          text: "Login",
                          onPressed: () {
                            if (authCubit.loginFormKeyController.currentState!
                                .validate()) {
                              authCubit.login(
                                email: authCubit.loginEmailController.text,
                                password:
                                    authCubit.loginPasswordController.text,
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
                  SizedBox(height: 50.h),

                  // Social sign-in options
                  SocialSignIn(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.signUp);
                    },
                    textBegin: "Create An Account ",
                    textEnd: "Sign Up",
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
