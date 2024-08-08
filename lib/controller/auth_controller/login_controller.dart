import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/repository/auth_repository.dart';

import '../../utils/utils.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  RxBool passwordVisibility = false.obs;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  Future<void> login(BuildContext context) async {
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();

    if (email == "" || password == "") {
      Utils.customAlertBox(context: context, title: 'Please fill required fields..!!');
    }
    else if (password.length < 6) {
      Utils.customAlertBox(context: context, title: 'Password length must be greater than 6..!!');
    } else {
      AuthRepository().signIn(email, password, context);
    }
  }

}