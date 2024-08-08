import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jalvidyut/repository/auth_repository.dart';

import '../main.dart';

class ProfileController extends GetxController {

  // User Details

  RxBool isLoading = false.obs;
  void setLoading(bool value) {
    isLoading.value = value;
  }

  RxString userId = ''.obs;
  RxString username = ''.obs;
  RxString email = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString imageUrl = ''.obs;

  Future<void> fetchUserProfile() async{
    setLoading(true);
    var snapshot = await FirebaseFirestore.instance.collection('Users').doc(WaterElectricityTrackingApp.EMAIL).get();
    Map<String, dynamic>? data = snapshot.data();
    if (data != null) {
      userId.value = data['userId'].toString();
      username.value = data['username'].toString();
      email.value = data['email'].toString();
      phoneNumber.value = data['phoneNumber'].toString();
      await fetchUserProfileImage();
    }

    setLoading(false);
  }


  // User Profile Pic

  RxBool isProfilePicLoading = false.obs;
  setProfilePicLoading(bool value) {
    isProfilePicLoading.value = value;
  }
  final storage = FirebaseStorage.instance;

  Future fetchUserProfileImage() async {
    final ref = storage.ref().child(email.value);
    try {
      final url = await ref.getDownloadURL();
      imageUrl.value = url.toString();
    } catch (e) {
      Get.snackbar('Connection Error', 'Unable to load profile image');
    }
  }

  Future updateImage() async {
    ImagePicker imagePicker = ImagePicker();
    final pickerFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      setProfilePicLoading(true);
      File? file = File(pickerFile.path);
      await AuthRepository().uploadImage(email.value, file);
      imageUrl.value = file.path.toString();
      setProfilePicLoading(false);
    } else {
      Get.snackbar('Oops..!!', 'No Image Selected');
    }
  }


}