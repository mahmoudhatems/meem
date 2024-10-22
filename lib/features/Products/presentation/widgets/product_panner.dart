import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductPanner extends StatelessWidget {
  const ProductPanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.sp),
      child: ListView(
        children: [
          // Shimmer effect for the Main Product Image with Carousel
          Column(
            children: [
              SizedBox(
                height: 200.h, // Adjust the height as needed
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Dots Indicator Placeholder
              SizedBox(height: 10.h),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Shimmer effect for the Product Name
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 24.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),

          // Shimmer effect for Ratings and Reviews Count
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.grey, size: 18.sp),
                Icon(Icons.star, color: Colors.grey, size: 18.sp),
                Icon(Icons.star, color: Colors.grey, size: 18.sp),
                Icon(Icons.star, color: Colors.grey, size: 18.sp),
                Icon(Icons.star_half, color: Colors.grey, size: 18.sp),
                SizedBox(width: 8.w),
                Container(
                  width: 100.w,
                  height: 16.h,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Shimmer effect for Price and Discount Information
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Container(
                  width: 80.w,
                  height: 22.h,
                  color: Colors.white,
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 50.w,
                  height: 16.h,
                  color: Colors.grey[300],
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 40.w,
                  height: 16.h,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Shimmer effect for Product Details Title
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 200.w,
              height: 20.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),

          // Shimmer effect for Expandable Product Description
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 40.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          // Shimmer effect for Add to Cart & Buy Now Buttons
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Container(
                  width: 160.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 160.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Shimmer effect for Delivery Information
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    color: Colors.grey,
                    size: 26.sp,
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 100.w,
                    height: 16.h,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
