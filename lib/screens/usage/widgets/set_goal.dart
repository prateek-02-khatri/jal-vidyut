import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jalvidyut/utils/utils.dart';

class SetGoal extends StatelessWidget {
  const SetGoal({super.key});

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
                'Set a Goal to manage your water consumption',
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
                    onPressed: () {},
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
