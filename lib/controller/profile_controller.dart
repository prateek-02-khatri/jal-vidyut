import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jalvidyut/repository/auth_repository.dart';
import 'package:jalvidyut/repository/user_repository.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {

  UserRepository userRepository = UserRepository();

  RxString imageUrl = ''.obs;

  RxBool isProfileLoading = false.obs;
  setProfilePicLoading(bool value) {
    isProfileLoading.value = value;
  }

  Future<UserModel> fetchData(String email) async {
    isProfileLoading.value = true;
    UserModel userModel = await userRepository.fetchUserData(email);
    imageUrl.value = userModel.imageUrl;
    isProfileLoading.value = false;
    return userModel;
  }

  updateImage(String email) async {
    ImagePicker imagePicker = ImagePicker();
    final pickerFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      setProfilePicLoading(true);

      File? file = File(pickerFile.path);

      String url = await userRepository.uploadImage('profileImage/$email', file);
      userRepository.updateUserData(email, 'imageUrl', url);
      imageUrl.value = url;

      setProfilePicLoading(false);
    }
  }
}