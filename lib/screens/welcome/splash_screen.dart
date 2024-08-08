import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jalvidyut/main.dart';
import 'package:jalvidyut/utils/routes/routes_name.dart';
import 'package:jalvidyut/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String nextScreen() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? email = user.email;
      if (email != null) {
        WaterElectricityTrackingApp.EMAIL = email;
      }
      return RoutesName.navigationMenu;
    }
    else {
      return RoutesName.login;
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, nextScreen());
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
