import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_text_field.dart';

import '../../controller/auth_controller/login_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/routes/routes.dart';
import '../../utils/utils.dart';
import '../../components/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginController authController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/app_logo.png', width: 55, height: 55,),
                    const SizedBox(width: 25,),
                    Text('Jal Vidyut', style: Utils.customBodyFontStyle(fontSize: 30),),
                  ],
                ),

                const SizedBox(height: 100,),

                CustomTextField(
                  controller: emailController,
                  labelText: 'E-Mail',
                  isObscure: false,
                  suffixIcon: const Icon(Icons.email_sharp),
                ),

                const SizedBox(height: 10,),

                Obx(() =>
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    isObscure: authController.passwordVisibility.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        authController.togglePasswordVisibility();
                      },
                      icon: Icon(
                        authController.passwordVisibility.value ?
                        Icons.visibility_off :
                        Icons.visibility
                      )
                    ),
                  )
                ),

                const SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'New User..!!',
                      style: Utils.customTextStyle(
                        fontWeight: FontWeight.w500
                      )
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, Routes.signup);
                      },
                      child: Text(
                        'Sign Up',
                        style: Utils.customTextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppColors.waterColor
                        )
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 50,),

                CustomElevatedButton(
                  onPressed: () {
                    String email = emailController.value.text.trim();
                    String password = passwordController.value.text.trim();
                    if (email == "" || password == "") {
                      Utils.customAlertBox(context: context, title: 'Please fill required fields..!!');
                    } else if (password.length < 6) {
                      Utils.customAlertBox(context: context, title: 'Password length must be greater than 6..!!');
                    } else {
                      authController.login(context, email, password);
                    }
                  },
                  buttonName: 'Login'
                ),
              ],
            ),
          ),
        )
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
