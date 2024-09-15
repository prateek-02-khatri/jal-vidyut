import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/repository/auth_repository.dart';

class LoginController extends GetxController {
  RxBool passwordVisibility = false.obs;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  AuthRepository authRepository = AuthRepository();

  Future<void> login(BuildContext context, String email, String password) async {
    authRepository.login(email, password, context);
  }

}