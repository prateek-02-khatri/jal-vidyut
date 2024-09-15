import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/repository/user_repository.dart';
import 'package:jalvidyut/utils/routes/routes.dart';
import 'package:jalvidyut/utils/utils.dart';

class AuthRepository {

  Future<void> login(String email, String password, context) async {
    try {
      Utils.showLoadingBox(context: context, title: 'Logging in...');

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {

        var snapshot = await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).get();
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromMap(data);

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.navigationMenu,
          (route) => false,
          arguments: user
        );
        Utils.showSnackBar(title: 'Login Successful', message: 'Welcome');
      } else {
        Utils.showSnackBar(title: 'Login Unsuccessful', message: 'Unable to sign into account..!!');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Utils.customAlertBox(context: context, title: e.code);
    }
  }

  Future<bool> createAccount({
    required context,
    required UserModel user,
    required var profileImage,
  }) async {
    try {
      Utils.showLoadingBox(context: context, title: 'Creating Account...');
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create User Account
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password
      );

      if (userCredential.user != null) {

          UserRepository userRepository = UserRepository();

          // Save Upload Profile Image
          String profileImageUrl = '';
          if (profileImage != null && user.imageUrl != '') {
            profileImageUrl = await userRepository.uploadImage('profileImage/${user.email}', profileImage);
          }

          // Save User Info
          Map<String, String> userMap = {
            'username': user.username,
            'userId': userCredential.user!.uid,
            'imageUrl': profileImageUrl,
            'email': user.email,
            'password': user.password,
            'phoneNumber': user.phoneNumber,
            'tankHeight': user.tankHeight,
            'tankWidth': user.tankWidth,
            'tankCapacity': user.tankCapacity,
          };
          await firestore.collection('Users').doc(user.email).set(userMap);

          // Save Goal Info
          Map<String, String> goalMap = {
            'daily': '550',
            'weekly': '3800'
          };
          await firestore.collection('Users').doc(user.email).collection('goal').doc(user.email).set(goalMap);

          // Initial Tank Real-time value
          double height = double.parse(user.tankHeight) / 10;
          await FirebaseDatabase.instance.ref(userCredential.user!.uid).set({
            'distance': height.toString()
          });

          Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.navigationMenu,
              (route) => false,
              arguments: UserModel.fromMap(userMap)
          );
          Utils.showSnackBar(title: 'Sign-Up Successful', message: 'Account created successfully');
          return true;
      } else {
        Utils.showSnackBar(title: 'Sign-Up Failed', message: 'Unable to create account..!!');
        Navigator.pushReplacementNamed(context, Routes.signup);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Utils.customAlertBox(context: context, title: e.code.toString());
      return false;
    }
  }
  
  Future<void> logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
  }
}