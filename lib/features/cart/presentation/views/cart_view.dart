// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:meem/core/utils/string.dart';
import 'package:meem/features/cart/data/models/cart_item/cart_item.dart';
import 'package:meem/features/cart/presentation/cubits/cubit/cart_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utils/colors.dart';
import '../../../Auth/presentation/widgets/custom_bottom.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartCubit>(context).getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            fontFamily: StringManager.fontFamily,
            color: ColorsManager.textBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomScrollView(
          slivers: [
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (state is AddOrRemoveFromCartSuccess) {
                  BlocProvider.of<CartCubit>(context).getCartProducts();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      content: const AwesomeSnackbarContent(
                        title: 'Removed',
                        message: "removed from cart",
                        contentType: ContentType.success,
                      ),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      margin: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is GetCartProductsSuccess) {
                  List<CartItem> cartItems = state.products;
                  double totalAmount =
                      calculateTotal(cartItems); // Calculate total amount

                  if (cartItems.isNotEmpty) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index < cartItems.length) {
                            CartItem cartItem = cartItems[index];
                            final DateTime deliveryDate =
                                DateTime.now().add(const Duration(days: 2));
                            final String formattedDeliveryDate =
                                DateFormat('d MMM y').format(deliveryDate);

                            return Dismissible(
                              key: Key(cartItem.id.toString()),
                              // Unique key for each item
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                BlocProvider.of<CartCubit>(context)
                                    .addOrRemoveFromCart(
                                        id: cartItem.product!.id.toString());
                              },
                              child: buildCartItem(
                                  cartItem, formattedDeliveryDate),
                            );
                          } else if (index == cartItems.length) {
                            return buildApplyCouponsSection();
                          } else if (index == cartItems.length + 1) {
                            return buildOrderPaymentDetailsSection(totalAmount);
                          } else {
                            return CustomBottom(
                              text: "Checkout",
                              onPressed: () {
                                // Handle checkout action
                              },
                            );
                          }
                        },
                        childCount:
                            cartItems.length + 3, // Add sections and buttons
                      ),
                    );
                  } else {
                    return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: SvgPicture.asset("assets/images/emptycart.svg",
                              height: 240.h, fit: BoxFit.contain),
                        ));
                  }
                } else if (state is GetCartProductsFail) {
                  return SliverFillRemaining(
                      child: Center(
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(
                        fontFamily: StringManager.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: Colors.red,
                      ),
                    ),
                  ));
                } else {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ); // Use shimmer for loading state
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(CartItem cartItem, String formattedDeliveryDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          // handel NAve to product details of product ya 3maaaaaaaar
        },
        child: Card(
          color: ColorsManager.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 90.h,
                          width: 120.w,
                          child: FittedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.network(
                                cartItem.product!.image!,
                                height: 100.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(child: Icon(Icons.error));
                                },
                              ),
                            ),
                          ),
                        ),
                        if (cartItem.product!.discount! > 0)
                          Positioned(
                            top: 5.h,
                            left: 5.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                '${cartItem.product!.discount}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItem.product!.name!,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            cartItem.product!.description!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'EGP ${cartItem.product!.price!.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, size: 20.sp),
                                    onPressed: () {
                                      // Decrement logic
                                    },
                                  ),
                                  Text(
                                    cartItem.quantity.toString(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 20.sp),
                                    onPressed: () {
                                      // Increment logic
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInfoContainer('Free Shipping', Colors.green),
                    buildInfoContainer(
                        'Delivery by $formattedDeliveryDate', Colors.blue),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoContainer(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget buildApplyCouponsSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apply Coupons',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: StringManager.fontFamily,
              color: ColorsManager.textBlue,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter coupon code',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0.w,
                        horizontal: 12.0.h), // Set vertical padding here
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () {
                  // Apply coupon logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 16.0.w,
                      horizontal: 16.0.h), // Same vertical padding
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: StringManager.fontFamily),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 20.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 20.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderPaymentDetailsSection(double totalAmount) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          buildOrderDetailRow('Subtotal', totalAmount),
          Divider(color: Colors.grey.shade300),
          buildOrderDetailRow('Total Amount', totalAmount),
        ],
      ),
    );
  }

  Widget buildOrderDetailRow(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: StringManager.fontFamily,
            color: ColorsManager.textBlue,
          ),
        ),
        Text(
          'EGP ${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  double calculateTotal(List<CartItem> items) {
    double total = 0;
    for (var item in items) {
      total += item.product!.price! * item.quantity!;
    }
    return total;
  }
}
