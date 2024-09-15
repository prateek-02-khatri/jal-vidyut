import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import 'package:jalvidyut/utils/utils.dart';

import '../../controller/auth_controller/signup_controller.dart';
import '../../components/custom_elevated_button.dart';

class TankSpecificationScreen extends StatelessWidget {

  const TankSpecificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignupController authController = Get.put(SignupController());
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.05,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome ',
                    style: Utils.customTextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700
                    )
                  ),
                  Text(
                    authController.usernameController.value.text.split(' ')[0],
                    style: Utils.customTextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.waterColor
                    )
                  ),
                ],
              ),

              SizedBox(height: Get.height * 0.05,),

              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('Water Tank Specification',
                    style: Utils.customBodyFontStyle(fontSize:  22)),
              ),

              SizedBox(height: Get.height * 0.1,),

              customTextField(
                  controller: authController.waterTankHeight.value,
                  text: 'Water Tank Height',
                  suffixText: 'mm'
              ),

              const SizedBox(height: 15),

              customTextField(
                  controller: authController.waterTankDiameter.value,
                  text: 'Water Tank Diameter',
                  suffixText: 'mm'
              ),

              const SizedBox(height: 15),

              customTextField(
                  controller: authController.waterTankCapacity.value,
                  text: 'Water Tank Capacity',
                  suffixText: 'L'
              ),

              SizedBox(height: Get.height * 0.1,),

              CustomElevatedButton(
                onPressed: () {
                  authController.getStarted(context: context);
                },
                buttonName: 'Get Started'
              ),

              SizedBox(height: Get.height * 0.05,),
            ],
          ),
        ),
      ),
    );
  }

  customTextField({
    required TextEditingController controller,
    required  String text,
    required  String suffixText
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        style: Utils.customTextStyle(),
        decoration: InputDecoration(
          hintText: text,
          suffixText: suffixText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColors.waterColor
            )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                width: 2,
            )
          ),
        ),
      ),
    );
  }
}
