import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';
import 'package:meem/features/Auth/presentation/widgets/custom_bottom.dart';
import '../widgets/custom_text_form_field.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  // Declare the email controller
  final TextEditingController _emailController = TextEditingController();

  // Email validator method
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align title to the left
                children: [
                  SizedBox(height: 10.h),

                  // Title
                  Text(
                    "Forgot\npassword?",
                    style: TextStyle(
                      fontSize: 35.sp,
                      fontFamily: StringManager.fontFamily,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.textBlue,
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Email Field
                  CustomTextFormField(
                    controller: _emailController,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 24.sp,
                      color: ColorsManager.gray,
                    ),
                    hintText: "Enter your email address",
                    validator: _emailValidator,
                  ),

                  SizedBox(height: 35.h),
                  RichText(
                    text: const TextSpan(
                      text: " *",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontFamily: StringManager.fontFamily),
                      children: [
                        TextSpan(
                          text:
                              " We will send you a message to set or reset\n  your new password",
                          style: TextStyle(
                              color: ColorsManager.gray,
                              fontFamily: StringManager.fontFamily,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 35.h),

                  // Submit button
                  CustomBottom(
                    text: "Submit",
                    onPressed: () {
                      // Handle submit logic of Forgot Passwoooooooooooooooooooooooooooooooooooord  here ); ););););););););););););); ););););););););););););); ););););););););););););); ););););););););););););); ););););););););););););); ););););););););););););
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
