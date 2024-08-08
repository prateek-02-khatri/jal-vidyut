import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jalvidyut/repository/auth_repository.dart';

import '../../screens/auth/tank_specification_screen.dart';
import '../../utils/utils.dart';

class SignupController extends GetxController {

  // Sign-Up Screen
  final usernameController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  RxString imageUrl = ''.obs;
  File? file;

  RxBool passwordVisibility = false.obs;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void checkCredentials(BuildContext context) async {
    String username = usernameController.value.text.trim();
    String email =  emailController.value.text.trim();
    String phoneNumber = phoneNumberController.value.text.trim();
    String password = passwordController.value.text.trim();

    if (username != "" && email != "" && phoneNumber != "" && password != "") {
      if (!AuthenticateUserCredentials.isValidUsername(username)) {
        Utils.customAlertBox(context: context, title: 'Please enter valid username..!!');
        return;
      }
      else if (username.length < 4) {
        Utils.customAlertBox(context: context, title: 'Username length must be greater than 4..!!');
        return;
      }
      else if(!AuthenticateUserCredentials.isValidEmail(email)) {
        Utils.customAlertBox(context: context, title: 'Please enter valid email..!!');
        return;
      }
      else if(!AuthenticateUserCredentials.isValidPhoneNumber(phoneNumber)) {
        Utils.customAlertBox(context: context, title: 'Please enter valid phone number..!!');
        return;
      }
      else if(!AuthenticateUserCredentials.isValidPassword(password)) {
        Utils.customAlertBox(context: context, title: 'Password length must be greater than 6..!!');
        return;
      }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TankSpecificationScreen())
        );
      }
    }
    else {
      Utils.customAlertBox(context: context, title: 'Please fill required fields..!!');
    }
  }

  Future<void> getImage() async {
    ImagePicker imagePicker = ImagePicker();
    final pickerFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      file = File(pickerFile.path);
      imageUrl.value = file!.path.toString();
    }
  }

  // Water Tank Specification Screen

  final waterTankHeight = TextEditingController().obs;
  final waterTankDiameter = TextEditingController().obs;
  final waterTankCapacity = TextEditingController().obs;

  Future<void> getStarted({
    required context,
  }) async{

    String username = usernameController.value.text;
    String email = emailController.value.text;
    String phoneNumber = phoneNumberController.value.text;
    String password = passwordController.value.text;

    String tankWidth = waterTankHeight.value.text;
    String tankHeight = waterTankDiameter.value.text;
    String tankCapacity = waterTankCapacity.value.text;

    if (tankWidth.isEmpty || tankHeight.isEmpty || tankCapacity.isEmpty) {
      Utils.customAlertBox(context: context, title: 'Please fill required fields..!!');
      return;
    }
    else {
      String userId = '${username.replaceAll(' ', '').substring(0, 4).toLowerCase()}_${phoneNumber.substring(6, 10)}';
      await AuthRepository().createAccount(
          context: context,
          username: username,
          userId: userId,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
          tankWidth: tankWidth,
          tankHeight: tankHeight,
          tankCapacity: tankCapacity
      );
      if (imageUrl.value != '' && file != null) {
        await AuthRepository().uploadImage(email, file);
      }
    }
  }

}

class AuthenticateUserCredentials {

  static bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[\w.\-]+@gmail.com$');
    return regex.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    final RegExp regex = RegExp(r'^[0-9]{10}$');
    return regex.hasMatch(phoneNumber);
  }

  static bool isValidUsername(String username) {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(username);
  }

  static bool isValidPassword(String password) {
    if (password.length < 6) {
      return false;
    }
    return true;
  }
}