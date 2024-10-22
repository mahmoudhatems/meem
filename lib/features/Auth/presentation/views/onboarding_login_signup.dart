import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/router/routes.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/string.dart';
import '../widgets/custom_bottom.dart';

class OnboardingLoginSignUp extends StatelessWidget {
  const OnboardingLoginSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainBlue,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 180.h,
                ),
                Center(
                  child: Text(
                    "meem",
                    style: TextStyle(
                      fontSize: 98.sp,
                      fontFamily: StringManager.fontFamily,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Center(
                  child: Text(
                    "Shop Loud, Live Bold. Make\nEvery Purchase a Statement",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: StringManager.fontFamily,
                      fontWeight: FontWeight.normal,
                      color: ColorsManager.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 128.h,
                ),
                CustomBorderBottom(
                  text: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.logIn);
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                InkWell(
                  hoverColor: Colors.white,
                  splashColor: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.signUp);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: ColorsManager.white, // White border
                        width: 1.3.sp,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 20.w), // Padding for the button content
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontFamily: StringManager.fontFamily,
                                fontWeight: FontWeight.w500,
                                color: ColorsManager.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
