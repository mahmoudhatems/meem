import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meem/config/router/routes.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/string.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Choose Products",
      "subtitle":
          "Discover bold, trendsetting products. Swipe, choose, and elevate your style with every click. Your perfect picks await.",
      "image": "assets/images/firstSplash.svg"
    },
    {
      "title": "Make Payment",
      "subtitle":
          "Secure your style with ease. Fast, simple, and safe payments for a seamless shopping experience. Own it now.",
      "image": "assets/images/secoandSplash.svg"
    },
    {
      "title": "Get Your Order",
      "subtitle":
          "Your order is on the way! Track, receive, and unwrap your style. Get ready to elevate your look.",
      "image": "assets/images/thirdSplash.svg"
    }
  ];

  void _onNextPressed() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil( Routes.signUp,(context){return false;});
    }
  }

  void _onPrevPressed() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSkipPressed() {
    Navigator.of(context).pushNamedAndRemoveUntil( Routes.signUp,(context){return false;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: _onSkipPressed,
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: ColorsManager.textBlue,
                          fontFamily: StringManager.fontFamily,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  title: onboardingData[index]['title']!,
                  subtitle: onboardingData[index]['subtitle']!,
                  image: onboardingData[index]['image']!,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(

                      controller: _pageController,
                      count: onboardingData.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: ColorsManager.textBlue,
                        dotColor: Colors.grey.shade300,
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        expansionFactor: 2,
                        spacing: 5.0,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPage == 0)
                          SizedBox(width: 50.w)
                        else
                          TextButton(
                            onPressed: _onPrevPressed,
                            child: Text(
                              "Prev",
                              style: TextStyle(
                                color: ColorsManager.lightGray,
                                fontFamily: StringManager.fontFamily,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        TextButton(
                          onPressed: _onNextPressed,
                          child: Text(
                            _currentPage < onboardingData.length - 1
                                ? "Next"
                                : "Get Started",
                            style: TextStyle(
                              color: ColorsManager.mainBlue,
                              fontFamily: StringManager.fontFamily,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: ColorsManager.white,
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image, height: 400, fit: BoxFit.contain),
          SizedBox(height: 40.h),
          Text(
            title,
            style: TextStyle(
              fontFamily: StringManager.fontFamily,
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: ColorsManager.textBlue,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: StringManager.fontFamily,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManager.lightGray,
            ),
          ),
        ],
      ),
    );
  }
}
