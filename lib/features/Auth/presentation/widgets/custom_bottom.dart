import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width,
      this.height = 50});
  final double height;
  final double? width;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width ?? MediaQuery.of(context).size.width,
      child: MaterialButton(
        onPressed: onPressed,
        color: ColorsManager.mainBlue,
        textColor: ColorsManager.white,
        padding: EdgeInsets.only(right: 50.w, left: 50.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
        hoverColor: ColorsManager.white.withOpacity(0.1),
        highlightColor: ColorsManager.white.withOpacity(0.2),
        splashColor: ColorsManager.white.withOpacity(0.3),
        elevation: 0,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: StringManager.fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomBorderBottom extends StatelessWidget {
  const CustomBorderBottom(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h, // Button height
      width: MediaQuery.of(context).size.width, // Button width
      child: MaterialButton(
        onPressed: onPressed,
        color: ColorsManager.white, // Button background color
        textColor: ColorsManager.mainBlue, // Button text color
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // Rounded corners
          side: const BorderSide(
            // Border color and width
            color: ColorsManager.mainBlue, // Set border color
            width: 2, // Set border width
          ),
        ),
        hoverColor: ColorsManager.mainBlue.withOpacity(0.1),
        highlightColor: ColorsManager.mainBlue.withOpacity(0.2),
        splashColor: ColorsManager.mainBlue.withOpacity(0.3),
        elevation: 0,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: StringManager.fontFamily,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
