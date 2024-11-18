import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/features/Products/presentation/cubits/get_product_cubit/get_products_cubit.dart';
import 'package:meem/features/Products/presentation/widgets/product_list.dart';

class ProductsListBuilder extends StatelessWidget {
  const ProductsListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsSuccess) {
          return ProductList(
            products: state.products,
          );
        } else if (state is GetProductsFail) {
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
