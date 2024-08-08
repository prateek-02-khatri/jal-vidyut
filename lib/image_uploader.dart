import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {

  @override
  Widget build(BuildContext context) {
    ImageController controller = Get.put(ImageController());
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Center(
          child: Obx(() =>

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.getImage();
                      log('Process Done..!!');
                    },

                    child: controller.imageUrl.value == '' ?
                    const Icon(
                      Icons.account_circle_sharp,
                      size: 75,
                    ) :
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(
                        File(controller.imageUrl.value).absolute,
                      ),
                    ),
                  ),

                GestureDetector(
                  onTap: () {
                    controller.getUserProfileImage('prateek');
                  },
                  child:
                  controller.networkImage.value == '' ?
                  const CircularProgressIndicator() :
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                      controller.networkImage.value,
                    ),
                  ),
                )
              ],
            )
          )
        )
      ),
    );
  }
}

class ImageController extends GetxController {
  RxString imageUrl = ''.obs;
  RxBool isLoading = false.obs;
  RxString networkImage = ''.obs;

  Future<void> getUserProfileImage(String userId) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child(userId);
    try {
      final url = await ref.getDownloadURL();
      networkImage.value = url.toString();
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  Future<void> uploadImage(String uid, var file) async {
    log('Uploading Image');
    UploadTask? uploadTask;
    if (file is File) {
      uploadTask = FirebaseStorage.instance.ref().child(uid).putFile(file);
    }
    if (file is Uint8List) {
      uploadTask = FirebaseStorage.instance.ref().child(uid).putData(file);
    }
    TaskSnapshot? snapshot = await uploadTask;
    String imageUrl = await snapshot!.ref.getDownloadURL();
    networkImage.value = imageUrl.toString();
    log('Uploading Completed');
    isLoading.value = false;
  }

  getImage() async {
    isLoading.value = true;
    final ImagePicker imagePicker = ImagePicker();
    log('Picking Image');
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? file = File(pickedFile.path);
      log('Image Picked');
      uploadImage('new_file', file).toString();
      imageUrl.value = file.path.toString();
    }

    else {
      Get.snackbar('Oops..!!', 'No Image Selected');
      isLoading.value = false;
      return null;
    }
  }
}