import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:meem/config/router/app_router.dart';
import 'package:meem/config/router/routes.dart';
import 'package:meem/core/api/dio_consumer.dart';
import 'package:meem/core/utils/di/di.dart';
import 'package:meem/features/Auth/data/repos/auth_repo.dart';
import 'package:meem/features/Auth/presentation/cubits/cubit/auth_cubit.dart';
import 'package:meem/features/Products/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:meem/features/Products/presentation/cubits/get_product_cubit/get_products_cubit.dart';
import 'package:meem/features/Products/presentation/cubits/get_product_details_cubit/get_product_details_cubit.dart';
import 'package:meem/features/cart/data/repos/cart_repo.dart';
import 'package:meem/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:meem/features/home/data/repos/home_repo.dart';
import 'package:meem/features/my_favorites/data/data_sources/favorites_data_source.dart';
import 'package:meem/features/my_favorites/data/repos/favorites_repo.dart';
import 'package:meem/features/my_favorites/presentation/cubits/change_favorites/change_favorites_cubit.dart';
import 'package:meem/features/user_profile/presentation/cubits/get_user_info_cubit/get_user_info_cubit.dart';

import 'core/utils/constant.dart';

class MeemApp extends StatelessWidget {
  const MeemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(
                authRepo: git.get<AuthRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => ChangeFavoritesCubit(
                favoritesRepo:MyFavoritesRepoImpl(favoritesDataSource: MyFavoritesDataSourceImpl(apiConsumer:git.get<DioConsumer>() )) ,
              ),
            ),
            BlocProvider(
              create: (context) => CartCubit(
                cardRepo: git.get<CartRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) => GetUserInfoCubit(
                homeRepo: git.get<HomeRepoImpl>(),
              ),
            ),
            BlocProvider(
              create: (context) =>
                  GetProductDetailsCubit(homeRepo: git.get<HomeRepoImpl>()),
            ),
            BlocProvider(
              create: (context) =>
                  GetProductsCubit(homeRepo: git.get<HomeRepoImpl>())
                    ..getProducts(),
            ),
            BlocProvider(
              create: (context) =>
                  CategoryCubit(homeRepo: git.get<HomeRepoImpl>())
                    ,
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Meem',
             initialRoute:
               Hive.box(Constants.tokenBox).get(Constants.tokenKey) == null
                     ? Routes.onboarding
                   : Routes.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}
