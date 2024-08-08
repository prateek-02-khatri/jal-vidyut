import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/controller/auth_controller/signup_controller.dart';
import 'package:jalvidyut/components/custom_elevated_button.dart';

import '../../utils/app_colors.dart';
import '../../utils/utils.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  SignupController authController = Get.put(SignupController());
  final double size = Get.width * 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      appBar: CustomAppBar(),

      body: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              GestureDetector(

                onTap: () {
                  authController.getImage();
                },

                child: Obx(() =>Column(
                  children: [
                    authController.imageUrl.value == ''
                    ?
                    Icon(
                      size: size,
                      Icons.account_circle_sharp,
                      color: Colors.grey,
                    ) :
                    CircleAvatar(
                      radius: size/2,
                      backgroundImage: FileImage(
                        File(authController.imageUrl.value).absolute,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Choose profile photo',
                      style: Utils.customBodyFontStyle(
                          fontSize: 12,
                          color: AppColors.waterColor
                      ),
                    ),
                  ],
                )),
              ),

              const SizedBox(height: 85,),

              customTextField(
                text: 'Username',
                controller: authController.usernameController.value,
                suffixIcon: const Icon(Icons.person),
              ),

              const SizedBox(height: 10,),

              customTextField(
                text: 'E-Mail',
                controller: authController.emailController.value,
                suffixIcon: const Icon(Icons.email_sharp),
              ),

              const SizedBox(height: 10,),

              customTextField(
                text: 'Phone Number',
                controller: authController.phoneNumberController.value,
                suffixIcon: const Icon(Icons.phone_android_sharp),
              ),

              const SizedBox(height: 10,),

              Obx(() => customTextField(
                text: 'Password',
                controller: authController.passwordController.value,
                suffixIcon: IconButton(
                    onPressed: () {
                      authController.togglePasswordVisibility();
                    },
                    icon: Icon(
                      authController.passwordVisibility.value ?
                      Icons.visibility :
                      Icons.visibility_off
                    )
                ),
                isObscure: authController.passwordVisibility.value,
              )),

              const SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Already have account..!!',
                    style: Utils.customTextStyle(
                      fontWeight: FontWeight.w500
                    )
                  ),

                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                        return Colors.transparent;
                      },
                      ),
                    ),

                    child: Text(
                      'Login',
                      style: Utils.customTextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.waterColor
                      )
                    ),
                  )
                ],
              ),

              const SizedBox(height: 45,),

              CustomElevatedButton(onPressed: () {
                authController.checkCredentials(context);
              }, buttonName: 'Sign Up'),

              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  customTextField({
    required String text,
    required TextEditingController controller,
    required Widget suffixIcon,
    bool? isObscure
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isObscure ?? false,
        style: Utils.customTextStyle(),
        decoration: InputDecoration(
          hintText: text,
          suffixIcon: suffixIcon,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            )
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: AppColors.waterColor
            )
          ),
        ),
      ),
    );
  }
}