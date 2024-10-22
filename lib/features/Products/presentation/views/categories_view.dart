import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/features/Products/presentation/widgets/categories_products.dart';
import 'package:meem/features/Products/presentation/widgets/categories_view_app_bar.dart';

// ignore: must_be_immutable
class CategoriesView extends StatelessWidget {
  String name;
  final TextEditingController controller = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  CategoriesView({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            CategoriesViewAppBar(name: name),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            const CategoriesProducts(),
          ],
        ),
      ),
    );
  }
}