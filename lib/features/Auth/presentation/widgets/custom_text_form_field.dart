import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meem/core/utils/colors.dart';
import 'package:meem/core/utils/string.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      this.contentPadding,
      this.focusedBorder,
      this.enableBorder,
      this.errorBorder,
      this.focusedErrorBorder,
      this.inputTextStyle,
      required this.hintText,
      this.onSaved,
      this.onChanged,
      this.isObscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.backgroundColor,
      required this.validator,
      this.controller});

  final EdgeInsetsDirectional? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enableBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? inputTextStyle;
  final String hintText;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Function(String?) validator;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    double height = 70.h;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        cursorColor: ColorsManager.mainBlue,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        obscureText: widget.isObscureText ?? false,
        style: widget.inputTextStyle ?? TextStyle(fontSize: 16.sp),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(
                horizontal: 16.w, // Consistent horizontal padding
                vertical: 14.h, // Consistent vertical padding
              ),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: StringManager.fontFamily,
            color: ColorsManager.gray,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: widget.enableBorder ?? customBorder(),
          focusedBorder:
              widget.focusedBorder ?? customBorder(ColorsManager.lightPink),
          errorBorder: widget.errorBorder ?? customBorder(Colors.red),
          focusedErrorBorder:
              widget.focusedErrorBorder ?? customBorder(Colors.red),
          errorStyle: TextStyle(fontSize: 12.sp),
        ),
        validator: (value) => widget.validator(value),
      ),
    );
  }

  OutlineInputBorder customBorder([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100), // Consistent border radius
      borderSide: BorderSide(
        color: color ?? Colors.black,
        width: 1, // Consistent border width
      ),
    );
  }
}
