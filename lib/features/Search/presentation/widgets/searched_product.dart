import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meem/features/Products/presentation/widgets/product_list.dart';
import 'package:meem/features/Search/presentation/cubit/get_searched_product_cubit/get_searched_product_cubit.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSearchedProductCubit, GetSearchedProductState>(
      builder: (context, state) {
        if (state is GetSearchedProductSuccess) {
          return ProductList(
            products: state.products,
          );
        } else if (state is GetSearchedProductFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Text(
              state.errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.sp, color: Colors.redAccent),
            ),
          );
        } else if (state is GetSearchedProductInitial) {
          return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: SvgPicture.asset("assets/images/searching.svg",
                    height: 240.h, fit: BoxFit.contain),
              ));
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
