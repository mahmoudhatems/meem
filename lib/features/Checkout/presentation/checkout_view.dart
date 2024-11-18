import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildShoppingList(),
              SizedBox(height: 20.h),
              _buildOrderSummary(),
              SizedBox(height: 20.h),
              _buildPaymentMethods(),
              SizedBox(height: 30.h),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShoppingItem(
          imageUrl:
              'https://i.pinimg.com/736x/de/58/da/de58dacb099924318d53790d2e177db3.jpg',
          title: 'Women\'s Casual Wear',
          variations: ['Black', 'Red'],
          price: 34.00,
          originalPrice: 64.00,
          rating: 4.8,
        ),
        SizedBox(height: 16.h),
        _buildShoppingItem(
          imageUrl:
              'https://m.media-amazon.com/images/I/61DZCttaKfL._AC_SY741_.jpg',
          title: 'Men\'s Jacket',
          variations: ['Green', 'Grey'],
          price: 45.00,
          originalPrice: 67.00,
          rating: 4.7,
        ),
      ],
    );
  }

  Widget _buildShoppingItem({
    required String imageUrl,
    required String title,
    required List<String> variations,
    required double price,
    double? originalPrice,
    required double rating,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.network(
            imageUrl,
            width: 80.w,
            height: 80.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                'Variations: ${variations.join(', ')}',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  if (originalPrice != null)
                    Text(
                      '\$$originalPrice',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  SizedBox(width: 8.w),
                  Text(
                    'Rating: $rating',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 10.h),
        _buildOrderSummaryRow('Order', '\$800.0'),
        _buildOrderSummaryRow('Shipping', '\$30'),
        _buildOrderSummaryRow('Total', '\$830.0', isTotal: true),
      ],
    );
  }

  Widget _buildOrderSummaryRow(String title, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 10.h),
        _buildPaymentOption('Visa', '********2109', Colors.pinkAccent),
        _buildPaymentOption('PayPal', '********2109', Colors.blueAccent),
        _buildPaymentOption('MasterCard', '********2109', Colors.redAccent),
        _buildPaymentOption('Apple Pay', '********2109', Colors.grey),
      ],
    );
  }

  Widget _buildPaymentOption(String title, String number, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
        color: color.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            number,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          onPressed: () {
            // Handle continue action
          },
          child: Text(
            'Continue',
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
