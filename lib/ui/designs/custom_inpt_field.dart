import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomInptField extends StatelessWidget {
  final TextEditingController textCon;
  final String labelText;
  final FocusNode focusNode;
  const CustomInptField({
    Key? key,
    required this.textCon,
    required this.labelText,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: TextFormField(
        controller: textCon,
        focusNode: focusNode,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
          hintText: labelText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.sp,
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          focusColor: Colors.grey.shade100,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.grey.shade100,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.grey.shade100,
            ),
          ),
          prefixIcon: SizedBox(
            height: 40.h,
            width: 40.h,
            child: Center(
              child: SvgPicture.asset(
                'assets/svg/Search.svg',
                color: Colors.grey,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
