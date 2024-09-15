import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/screens/profile/widgets/custom_card.dart';
import 'package:jalvidyut/utils/routes/routes.dart';
import 'package:jalvidyut/utils/utils.dart';
import '../../../controller/profile_controller.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.user,
    required this.controller,
  });

  final UserModel user;
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const CustomCard(cardTitle: 'Profile', cardSubtitle: 'adjust your profile'),

          const SizedBox(height: 5,),

          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.userDetail,
                arguments: {
                  'user': user,
                  'controller': controller
                }
              );
            },

            child: Container(

              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(10))
              ),

              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),

                leading: Obx(() => controller.imageUrl.value == '' ?
                  const Icon(
                    Icons.account_circle_sharp,
                    size: 48,
                  ) :
                  Hero(
                    tag: 'image',
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: NetworkImage(controller.imageUrl.value),
                    ),
                  )
                ),

                title: Text(
                    user.username,
                    style: Utils.customHeadFontStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(
                    user.email,
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
    );
  }
}
