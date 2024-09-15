import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jalvidyut/utils/utils.dart';

import '../../models/user_model.dart';
import '../../utils/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  nextScreen() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var snapshot = await FirebaseFirestore.instance.collection('Users').doc(user.email).get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      UserModel userModel = UserModel.fromMap(data);
      Navigator.pushReplacementNamed(
        context,
        Routes.navigationMenu,
        arguments: userModel
      );
    }
    else {
      Navigator.pushNamed(context, Routes.login);
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      nextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/app_logo.png', width: 55, height: 55,),
              const SizedBox(width: 25,),
              Text('Jal Vidyut', style: Utils.customBodyFontStyle(fontSize: 30),),
            ],
          ),
        )
    );
  }
}
