import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/controller/profile_controller.dart';
import 'package:jalvidyut/screens/profile/widgets/custom_card.dart';
import 'package:jalvidyut/utils/utils.dart';
import '../user_detail.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
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
    return Obx(() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const CustomCard(cardTitle: 'Profile', cardSubtitle: 'adjust your profile'),

          const SizedBox(height: 5,),

          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                        UserDetail(
                          username: username,
                          userId: userId,
                          email: email,
                          phoneNumber: phoneNumber,
                          controller: controller,
                        )
                  )
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                leading: controller.imageUrl.value == '' ?
                const Icon(
                  Icons.account_circle_sharp,
                  size: 48,
                ) :
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: NetworkImage(controller.imageUrl.value),
                ),

                title: Text(username,
                    style: Utils.customHeadFontStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(userId,
                    style: Utils.customBodyFontStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                trailing: const Icon(
                  Icons.arrow_forward_sharp,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
