import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/di/di.dart';
import 'package:meem/features/Search/presentation/cubit/get_searched_product_cubit/get_searched_product_cubit.dart';
import 'package:meem/features/Search/presentation/pages/search_view.dart';
import 'package:meem/features/cart/presentation/views/cart_view.dart';
import 'package:meem/features/Products/presentation/views/product_view.dart';
import 'package:meem/features/home/data/repos/home_repo.dart';
import 'package:meem/features/user_profile/presentation/views/user_profile_view.dart';
import '../../../../core/utils/colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> screens = [
    const ProductsView(),
    BlocProvider(
      create: (context) =>
          GetSearchedProductCubit(homeRepo: git.get<HomeRepoImpl>()),
      child: SearchView(),
    ),
    const CartView(),
    const UserProfileView()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: GNav(
            tabBorderRadius: 15.r,
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: ColorsManager.mainBlue,
            iconSize: 24.sp,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search_outlined,
                text: 'Search',
              ),
              GButton(
                icon: Icons.shopping_cart_outlined,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.person_outline_rounded,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
