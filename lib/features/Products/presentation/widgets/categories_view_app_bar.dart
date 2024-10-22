import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';

class CategoriesViewAppBar extends StatelessWidget {
  const CategoriesViewAppBar({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            // ignore: prefer_const_constructors
            icon: Icon(Icons.arrow_back_ios_new)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          name,
          style: TextStyle(
            fontFamily: StringManager.fontFamily,
            color: ColorsManager.textBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
      ),
    );
  }
}
