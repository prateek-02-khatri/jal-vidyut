import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/utils/routes/routes_name.dart';
import 'package:jalvidyut/utils/utils.dart';

class AuthRepository {

  Future<void> signIn(String email, String password, context) async {
    try {
      Navigator.pushNamed(context, RoutesName.waiting);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Get.snackbar('Login Successful', 'Welcome');
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.navigationMenu, (route) => false);
      } else {
        Get.snackbar('Login Unsuccessful', 'Unable to sign into account..!!');
      }
    } on FirebaseAuthException catch (e) {
      Utils.customAlertBox(context: context, title: e.code);
    }
  }

  Future<void> createAccount({
    required context,
    required String username,
    required String userId,
    required String email,
    required String phoneNumber,
    required String password,
    required String tankWidth,
    required String tankHeight,
    required String tankCapacity
  }) async {
    try {
      Navigator.pushNamed(context, RoutesName.waiting);
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Map<String, String> userData = {
          'username': username,
          'userId': userId,
          'email': email,
          'phoneNumber': phoneNumber,
          'tankHeight': tankHeight,
          'tankWidth': tankWidth,
          'tankCapacity': tankCapacity,
        };
        await FirebaseFirestore.instance.collection('Users').doc(email).set(userData);
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.navigationMenu, (route) => false);
        Get.snackbar('Sign-in Successful', 'Account created successfully');
        Navigator.pushReplacementNamed(context, RoutesName.signup);
      } else {
        Get.snackbar('Failed', 'Unable to create account..!!');
        Navigator.pushReplacementNamed(context, RoutesName.signup);
      }
    } on FirebaseAuthException catch (e) {
      Utils.customAlertBox(context: context, title: e.code.toString());
    }
  }
  
  Future<void> logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, RoutesName.login);
  }

  Future uploadImage(String email, var file) async {
    final storage = FirebaseStorage.instance;
    if (file is File) {
      await storage.ref().child(email).putFile(file);
    }
    if (file is Uint8List) {
      await storage.ref().child(email).putData(file);
    }
  }
}