import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/string.dart';

import '../../../../core/utils/colors.dart';

class SearchViewAppBar extends StatelessWidget {
  const SearchViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Text(
        'Search',
        style: TextStyle(
            fontFamily: StringManager.fontFamily,
            color: ColorsManager.textBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
      ),
    );
  }
}
