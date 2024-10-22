import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';
import 'package:meem/features/Products/presentation/widgets/products_list_builder.dart';
import 'package:meem/features/home/presentation/widgets/banners.dart';
import 'package:meem/features/home/presentation/widgets/categories_list.dart';
import 'package:meem/features/home/presentation/widgets/section_title.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/cart logo.png', height: 40.h),
          Text("meem",
              style: TextStyle(
                fontSize: 26.sp,
                fontFamily: StringManager.fontFamily,
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ))
        ])),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.h,
            ),
            child: Text(
              "All Featured",
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: StringManager.fontFamily,
                fontWeight: FontWeight.w600,
                color: ColorsManager.textBlue,
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: CategoriesList()),
        SliverToBoxAdapter(child: buildBannerSlider()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 5),
            child: SectionTitle(
              title: "Popular Products",
              press: () {},
            ),
          ),
        ),
        const ProductsListBuilder()
      ],
    );
  }
}
