import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/features/Products/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:meem/features/Products/presentation/widgets/product_list.dart';

class CategoriesProducts extends StatefulWidget {
  const CategoriesProducts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesProductsState createState() => _CategoriesProductsState();
}

class _CategoriesProductsState extends State<CategoriesProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is GetCategoryProductsSuccess) {
       return ProductList(
            products: state.products,
          );
        } else if (state is GetCategoryProductsFail) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp, color: Colors.redAccent),
            ),
          );
        } else {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
      },
    );
  }
}
