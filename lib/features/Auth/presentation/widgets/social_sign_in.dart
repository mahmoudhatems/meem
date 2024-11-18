import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';

class SocialSignIn extends StatelessWidget {
  final String textBegin;
  final String textEnd;
  final VoidCallback onTap;

  const SocialSignIn({
    super.key,
    required this.textBegin,
    required this.textEnd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "- OR Continue with -",
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontFamily: StringManager.fontFamily,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton('assets/images/googleicon.svg', onTap: () {
              // Add Google sign-in functionality
            }),
            SizedBox(width: 20.w),
            _socialButton('assets/images/appleicon.svg', onTap: () {
              // Add Apple sign-in functionality
            }),
            SizedBox(width: 20.w),
            _socialButton('assets/images/facebookicon.svg', onTap: () {
              // Add Facebook sign-in functionality
            }),
          ],
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: onTap, // Trigger navigation
          child: RichText(
            text: TextSpan(
              text: textBegin,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: StringManager.fontFamily),
              children: [
                TextSpan(
                  text: textEnd,
                  style: const TextStyle(
                      color: ColorsManager.mainBlue,
                      fontFamily: StringManager.fontFamily,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialButton(String assetPath,
      {required Function onTap, double iconHeight = 35}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blueAccent.withOpacity(0.1),
        child: SvgPicture.asset(
          assetPath,
          width: 30,
          height: iconHeight,
        ),
      ),
    );
  }
}
