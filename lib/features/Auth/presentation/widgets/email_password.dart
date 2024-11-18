import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/features/Auth/presentation/cubits/cubit/auth_cubit.dart';
import 'package:meem/features/Auth/presentation/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class EmailAndPassword extends StatefulWidget {
  final bool
      showConfirmPassword; // Control whether to show the confirm password field
  final GlobalKey<FormState> formKeyController;
  AutovalidateMode autovalidateModeController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  EmailAndPassword({
    required this.formKeyController,
    required this.autovalidateModeController,
    required this.emailController,
    required this.passwordController,
    super.key,
    this.showConfirmPassword =
        false, // Default is false (for login), can set to true (for registration)
  });

  @override
  // ignore: library_private_types_in_public_api
  _EmailAndPasswordState createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true; // State variable to toggle password visibility
  bool isObscureConfirmText =
      true; // State variable to toggle confirm password visibility

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    // Simple email validation
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value !=
        BlocProvider.of<AuthCubit>(context).registerPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Form(
      key: widget.formKeyController,
      autovalidateMode: widget.autovalidateModeController,
      child: Column(
        children: [
          // Email field
          CustomTextFormField(
            controller: widget.emailController,
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 24.sp,
              color: ColorsManager.gray,
            ),
            hintText: "Email",
            validator: _emailValidator,
          ),
          SizedBox(height: 6.h),

          // Password field
          CustomTextFormField(
            controller: widget.passwordController,
            isObscureText: isObscureText,
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              size: 24.sp,
              color: ColorsManager.gray,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isObscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 24.sp,
                color: ColorsManager.gray,
              ),
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText; // Toggle password visibility
                });
              },
            ),
            hintText: "Password",
            validator: _passwordValidator,
          ),

          // Conditionally show Confirm Password field
          if (widget.showConfirmPassword) ...[
            SizedBox(height: 6.h),
            CustomTextFormField(
              validator: _confirmPasswordValidator,
              controller: authCubit.registerConfirmPasswordController,
              isObscureText: isObscureConfirmText,
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                size: 24.sp,
                color: ColorsManager.gray,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isObscureConfirmText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 24.sp,
                  color: ColorsManager.gray,
                ),
                onPressed: () {
                  setState(() {
                    isObscureConfirmText =
                        !isObscureConfirmText; // Toggle confirm password visibility
                  });
                },
              ),
              hintText: "Confirm Password",
            ),
          ],
        ],
      ),
    );
  }
}
