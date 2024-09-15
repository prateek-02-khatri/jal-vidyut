import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/models/chart_data.dart';
import 'package:jalvidyut/models/user_model.dart';
import 'package:jalvidyut/utils/routes/routes.dart';
import 'package:jalvidyut/utils/utils.dart';

class SetGoal extends StatelessWidget {
  const SetGoal({
    super.key,
    required this.isWater,
    required this.user,
    required this.weekData,
    required this.dailyData
  });

  final bool isWater;
  final UserModel user;
  final List<int> weekData;
  final List<ChartData> dailyData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set a Goal',
                style: Utils.customBodyFontStyle(
                  fontSize: 16,
                )
              ),

              const SizedBox(height: 5),

              Text(
                'Set a Goal to manage your consumption',
                textAlign: TextAlign.left,
                style: Utils.customBodyFontStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500
                )
              ),

              const SizedBox(height: 10),

              Center(
                child: SizedBox(
                  width: Get.width * 0.33,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.goal,
                        arguments: {
                          'isWater': isWater,
                          'user': user,
                          'weekData': weekData,
                          'dailyData': dailyData,
                        }
                      );

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const GPT_Goal_Screen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21),
                      )
                    ),
                    child: Text(
                      'Set goal',
                      style: Utils.customBodyFontStyle(
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
