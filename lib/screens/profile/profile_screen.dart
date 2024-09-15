import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/controller/profile_controller.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/screens/profile/widgets/appearance_components.dart';
import 'package:jalvidyut/screens/profile/widgets/support.dart';
import 'package:jalvidyut/screens/profile/widgets/system_components.dart';
import 'package:jalvidyut/screens/profile/widgets/user_profile.dart';
import 'package:jalvidyut/utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.email});

  final String email;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ProfileController controller = Get.put(ProfileController());
  late UserModel user;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    user = await controller.fetchData(widget.email);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: Obx(() =>
        controller.isProfileLoading.value ?
        Center(child: CircularProgressIndicator(color: AppColors.waterColor)) :
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
                          user: user,
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
        )
      )
    );
  }
}
