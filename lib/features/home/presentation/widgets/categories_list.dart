
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/config/router/routes.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';
import 'package:meem/features/Products/presentation/cubits/category_cubit/category_cubit.dart';

import '../../data/models/category_model.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});
 static  List <CategoryModel> categories =<CategoryModel>[
  CategoryModel(id: 44,
      name: "Electronic devices",
      image: "assets/images/electronic.jpg"
  ) , CategoryModel(id: 43,
      name: "Prevent Corona",
      image: "assets/images/Prevent Corona.jpg"
  ) , CategoryModel(id: 42,
      name: "Sports",
      image: "assets/images/sports.jpeg"
  )  ,CategoryModel(id: 40,
      name: "Lighting",
      image: "assets/images/Lighting.jpg"
  ),  CategoryModel(id: 46,
      name: "Clothes",
      image: "assets/images/clothes.png"
  ),  CategoryModel(id: 47,
      name: "Groceries",
      image: "assets/images/Groceries.jpg")
];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
child: Container(
  height: 120.h,
  padding: EdgeInsets.symmetric(horizontal: 8.w),
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.categoriesView,
              arguments: categories[index].name);
          BlocProvider.of<CategoryCubit>(context)
              .getCategoryProducts(
              id: categories[index].id.toString());
        },
        child: Padding(
          padding: EdgeInsets.all(
              8.sp), // Adjust padding to be responsive
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage:
                AssetImage(categories[index].image! ,
                ),
                radius: 34.r,
              ),
              SizedBox(
                  height: 8.h), // SizedBox with responsive height
              SizedBox(
                width: 80.w,
                child: Text(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  categories[index].name!,
                  style: TextStyle(
                    fontFamily: StringManager.fontFamily,
                    color: ColorsManager.textBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
)
    );
  }
}
