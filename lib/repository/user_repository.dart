import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:jalvidyut/models/goal_model.dart';

import '../models/user_model.dart';

class UserRepository {

  Future<UserModel> fetchUserData(String email) async {
    var snapshot = await FirebaseFirestore.instance.collection('Users').doc(email).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  Future<GoalModel> fetchUserGoal(String email) async {
    var snapshot = await FirebaseFirestore.instance.collection('Users').doc(email).collection('goal').doc(email).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return GoalModel.fromMap(data);
  }

  Future<String> uploadImage(String ref, var file) async {
    UploadTask? uploadTask;
    FirebaseStorage storage = FirebaseStorage.instance;
    if (file is File) {
      uploadTask = storage.ref().child(ref).putFile(file);
    }
    if (file is Uint8List) {
      uploadTask = storage.ref().child(ref).putData(file);
    }

    TaskSnapshot? snapshot = await uploadTask;
    String imageUrl = await snapshot!.ref.getDownloadURL();
    return imageUrl;
  }

  updateUserData(String email, String id, String value) async {
    await FirebaseFirestore.instance.collection('Users').doc(email).update({
      id: value
    });
  }

  updateUserGoal(String email, String dailyLimit, String weeklyLimit) async {
    await FirebaseFirestore.instance.collection('Users').doc(email).collection('goal').doc(email).update({
      'daily': dailyLimit,
      'weekly': weeklyLimit,
    });
  }
}