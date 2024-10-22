import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/features/Search/presentation/cubit/get_searched_product_cubit/get_searched_product_cubit.dart';
import 'package:meem/features/Search/presentation/widgets/search_bar.dart';
import 'package:meem/features/Search/presentation/widgets/search_view_app_bar.dart';
import 'package:meem/features/Search/presentation/widgets/searched_product.dart';

// ignore: must_be_immutable
class SearchView extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomScrollView(
        slivers: [
          const SearchViewAppBar(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: form,
              child: CustomSearchBar(
                controller: controller,
                onSubmit: (_) {
                  BlocProvider.of<GetSearchedProductCubit>(context)
                      .getSearchedProduct(searchedText: controller.text);
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.h,
            ),
          ),
          const SearchedProduct()
        ],
      ),
    );
  }
}
