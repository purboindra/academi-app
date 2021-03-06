import 'package:academiapp/app/theme/app_theme.dart';
import 'package:academiapp/app/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title, hint;
  final TextEditingController? controller;
  final Widget? widget;
  final void Function()? onTap;
  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.widget,
    this.onTap,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            onTap: onTap,
            readOnly: widget == null ? false : true,
            autocorrect: false,
            controller: controller,
            cursorColor:
                Get.isDarkMode ? Colors.grey.shade100 : Colors.grey.shade700,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.w10,
                vertical: Dimensions.h15,
              ),
              suffixIcon: widget,
              suffixIconColor: greyColor,
              iconColor: primaryColor,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.w10 - 3),
                borderSide: BorderSide(color: primaryColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.w10 - 3),
              ),
              hintText: hint,
              hintStyle: subTitleStyle.copyWith(
                color: darkGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
