import 'package:flutter/material.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import 'package:jalvidyut/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isObscure,
    required this.suffixIcon,
  });

  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        style: Utils.customTextStyle(),
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: Utils.customTextStyle(),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColors.waterColor
            )
          ),
        ),
      ),
    );
  }
}
