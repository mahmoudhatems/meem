// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';
import 'package:meem/features/Products/presentation/cubits/get_product_details_cubit/get_product_details_cubit.dart';
import 'package:meem/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/calculate_discount_percentage.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isDescriptionExpanded = false;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showAddToCartDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: 330.w, // Set the dialog width
          height: 330.h, // Set the dialog height
          child: Center(
            child: Lottie.asset(
              'assets/images/Animation2.json',
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
    // Close the dialog after a delay
    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product Details",
          style: TextStyle(
            fontFamily: StringManager.fontFamily,
            color: ColorsManager.textBlue,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorsManager.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<GetProductDetailsCubit, GetProductDetailsState>(
          builder: (context, state) {
        if (state is GetProductDetailsSuccess) {
          final productData = state.product;
          final double discountPercentage = calculateDiscountPercentage(
              productData.oldPrice!.toDouble(), productData.price!.toDouble());

          return Padding(
            padding: EdgeInsets.all(18.sp),
            child: ListView(
              children: [
                // Main Product Image with Carousel
                Column(
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: productData.images!.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              productData.images![index],
                              fit: BoxFit.scaleDown,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Center(child: Icon(Icons.error)),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    // Dots Indicator under the images within the card
                    SizedBox(height: 10.h),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: productData.images!.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: ColorsManager.mainBlue,
                        dotHeight: 8.0.h,
                        dotWidth: 8.0.w,
                        spacing: 5.0.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Product Name
                Text(
                  productData.name!,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Ratings and Reviews Count
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18.sp),
                    Icon(Icons.star, color: Colors.amber, size: 18.sp),
                    Icon(Icons.star, color: Colors.amber, size: 18.sp),
                    Icon(Icons.star, color: Colors.amber, size: 18.sp),
                    Icon(Icons.star_half, color: Colors.amber, size: 18.sp),
                    SizedBox(width: 8.w),
                    const Text("56,890 reviews"),
                  ],
                ),
                SizedBox(height: 8.h),

                // Price and Discount Information
                Row(
                  children: [
                    Text(
                      "EGP ${productData.price}",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.h),
                    if (productData.oldPrice != productData.price)
                      Text(
                        "EGP ${productData.oldPrice}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    SizedBox(width: 10.w),
                    if (discountPercentage > 0)
                      Text(
                        "${discountPercentage.toStringAsFixed(0)}% Off",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Product Details
                Text(
                  "Product Details",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                // Expandable Product Description
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDescriptionExpanded = !isDescriptionExpanded;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDescriptionExpanded
                            ? productData.description!
                            : (productData.description!.length > 100
                                ? '${productData.description!.substring(0, 100)}...'
                                : productData.description!),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        isDescriptionExpanded ? "Show Less" : "Show More",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0.r),
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0.sp, horizontal: 20.0.sp),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 26.sp,
                        ),
                        label: Text(
                          "Add To Cart",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                        onPressed: () {
                          _showAddToCartDialog(); // Show the dialog

                          // Add product to cart
                          BlocProvider.of<CartCubit>(context)
                              .addOrRemoveFromCart(
                                  id: productData.id.toString());
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Delivery Information
                Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.red,
                        size: 26.sp,
                      ),
                      SizedBox(width: 8.w),
                      const Text(
                        "Delivery in \nTwo Days",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          );
        } else if (state is GetProductDetailsFail) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return Center(child: const CupertinoActivityIndicator());
        }
      }),
    );
  }
}
