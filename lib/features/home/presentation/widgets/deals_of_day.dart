import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/string.dart';

class DealsOfDay extends StatelessWidget {
  const DealsOfDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: ColorsManager.mainBlue),
        height: 65.h,
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
        child: ListTile(
          title: Text(
            "Deals of the Day",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: ColorsManager.white,
            ),
          ),
          subtitle: Row(
            children: [
              // ignore: prefer_const_constructors
              Icon(Icons.timer_outlined, color: ColorsManager.white),
              SizedBox(width: 4.sp),
              // Space between icon and text
              Text(
                "22h 55m 20s", // Placeholder for timer text
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: StringManager.fontFamily,
                  fontWeight: FontWeight.normal,
                  color: ColorsManager.white,
                ),
              ),
            ],
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_outlined,
                color: ColorsManager.white,
                size: 28.sp,
              )),
        ));
  }
}
