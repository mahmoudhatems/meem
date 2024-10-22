// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:meem/core/utils/models/product_model/product_model.dart';
import 'package:meem/core/utils/widgets/product_card.dart';


class ProductList extends StatelessWidget {
  final List<ProductModel>? products;
  const ProductList({
    super.key,
    this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.45,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
      ),
      itemCount: products!.length,
      itemBuilder: (context, index) => ProductCard(
        product: products![index],
      ),
    );
  }
}
