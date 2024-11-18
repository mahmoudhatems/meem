import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/string.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatelessWidget {
  void Function(String)? onSubmit;
  TextEditingController? controller;
  CustomSearchBar({
    super.key,
    this.onSubmit,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.sp, vertical: 8.sp),
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.075),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Row(
          children: [
            const Icon(Icons.search_outlined, color: ColorsManager.lightGray),
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: onSubmit,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: StringManager.fontFamily,
                  fontWeight: FontWeight.normal,
                  color: ColorsManager.lightGray,
                ),
                decoration: const InputDecoration(
                    hintText: ' Search any product', border: InputBorder.none),
              ),
            ),
            const Icon(Icons.mic_none_rounded, color: ColorsManager.lightGray),
          ],
        ),
      ),
    );
  }
}
