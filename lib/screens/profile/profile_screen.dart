import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/controller/profile_controller.dart';
import 'package:jalvidyut/screens/profile/widgets/appearance_components.dart';
import 'package:jalvidyut/screens/profile/widgets/support.dart';
import 'package:jalvidyut/screens/profile/widgets/system_components.dart';
import 'package:jalvidyut/screens/profile/widgets/user_profile.dart';
import 'package:jalvidyut/utils/app_colors.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ProfileController controller = Get.put(ProfileController());

    controller.fetchUserProfile();

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: Obx(() =>
        controller.isLoading.value ?
        Center(child: CircularProgressIndicator(color: AppColors.waterColor,)) :
        SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),

                      UserProfile(
                          username: controller.username.value,
                          userId: controller.userId.value,
                          email: controller.email.value,
                          phoneNumber: controller.phoneNumber.value,
                          controller: controller
                      ),

                      const SizedBox(height: 10,),

                      const SystemComponents(),

                      const SizedBox(height: 10,),

                      const AppearanceComponents(),

                      const SizedBox(height: 10,),

                      const Support(),
                    ],
                  ),
                )
              ],
            )
        ),
      )
    );
  }
}
