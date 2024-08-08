import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/controller/profile_controller.dart';
import 'package:jalvidyut/repository/auth_repository.dart';
import 'package:jalvidyut/components/custom_app_bar.dart';
import 'package:jalvidyut/screens/profile/widgets/elevated_button_icon.dart';
import 'package:jalvidyut/utils/app_colors.dart';
import 'package:jalvidyut/utils/utils.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({
    super.key,
    required this.username,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.controller,
  });

  final String username;
  final String userId;
  final String email;
  final String phoneNumber;
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {

    final imageHeight = Get.width * 0.3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'User Profile'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [

            Obx(() => GestureDetector(
              onTap: () {
                controller.updateImage();
              },
              child: controller.imageUrl.value == '' ?
              Icon(
                size: imageHeight,
                Icons.account_circle_sharp,
              ) :
                controller.isProfilePicLoading.value ?
                SizedBox(
                  width: imageHeight,
                  height: imageHeight,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.waterColor
                    ),
                  ),
                ) :
                CircleAvatar(
                  radius: imageHeight/2,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    controller.imageUrl.value,
                  ),
                ),
            )),

            const SizedBox(height: 16),

            Text(
              username,
              style: Utils.customTextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              )
            ),

            const SizedBox(height: 5),

            Text(
                userId,
                style: Utils.customTextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                )
            ),

            const SizedBox(height: 24),

            ListTile(
              leading: const Icon(Icons.email),
              title: Text(email, style: Utils.customBodyFontStyle(),),
            ),

            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(phoneNumber, style: Utils.customBodyFontStyle(),),
            ),

            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text('Address', style: Utils.customBodyFontStyle(),),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Coins Earned: ',
                    style: Utils.customBodyFontStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(
                    ' \$ 50',
                    style: Utils.customBodyFontStyle(
                        fontSize: 20
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'use',
                      style: Utils.customTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.waterColor
                      ),
                    )
                  )
                ],
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonIcon(
                    onPressed: () {},
                    buttonName: 'Edit Profile',
                    icon: Icons.edit
                ),

                ElevatedButtonIcon(
                  onPressed: () {
                    AuthRepository().logout(context);
                  },
                  buttonName: 'Logout',
                  icon: Icons.logout,
                )
              ],
            ),

            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}