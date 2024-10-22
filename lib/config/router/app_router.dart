import 'package:flutter/material.dart';
import 'package:meem/config/router/routes.dart';
import 'package:meem/features/Auth/presentation/views/login_view.dart';
import 'package:meem/features/Auth/presentation/views/logout_view.dart';
import 'package:meem/features/Products/presentation/views/categories_view.dart';
import 'package:meem/features/cart/presentation/views/cart_view.dart';
import 'package:meem/features/home/presentation/view/home_view.dart';
import 'package:meem/features/onBoarding/presentation/view/onboarding_view.dart';
import 'package:meem/features/user_profile/presentation/views/user_profile_view.dart';

import '../../features/Auth/presentation/views/forgot_password_view.dart';
import '../../features/Auth/presentation/views/onboarding_login_signup.dart';
import '../../features/Auth/presentation/views/signup_view.dart';
import '../../features/Products/presentation/views/product_details_view.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingView(),
        );
      case Routes.logIn:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case Routes.categoriesView:
        return MaterialPageRoute(
          builder: (context) => CategoriesView(
            name: settings.arguments as String,
          ),
        );
      case Routes.logOut:
        return MaterialPageRoute(
          builder: (context) => const LogoutView(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
     
      case Routes.userProfile:
        return MaterialPageRoute(
          // ignore: prefer_const_constructors
          builder: (context) => UserProfileView(),
        );
      case Routes.cart:
        return MaterialPageRoute(
          builder: (context) => const CartView(),
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (context) => const SignUpView(),
        );

      case Routes.productDetailsPage:
        return MaterialPageRoute(
            builder: (context) => const ProductDetailsPage());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (context) => ForgotPasswordView());
      case Routes.onboardingLoginSignUp:
        return MaterialPageRoute(
            builder: (context) => const OnboardingLoginSignUp());

      default:
        return unDefineRoute();
    }
  }
}

Route unDefineRoute() {
  return MaterialPageRoute(
    builder: (context) => const Scaffold(
      body: Center(
        child: Text('No route defined'),
      ),
    ),
  );
}
