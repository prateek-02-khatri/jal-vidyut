import 'package:flutter/material.dart';
import 'package:jalvidyut/utils/utils.dart';

class Challenges extends StatelessWidget {
  const Challenges({super.key, required this.title, required this.desc, required this.cost, required this.isCompleted});

  final String title;
  final String desc;
  final int cost;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Children 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Utils.customHeadFontStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.attach_money_sharp,
                        size: 25,
                      ),
                      Text(
                        cost.toString(),
                        style: Utils.customHeadFontStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        )
                      )
                    ],
                  ),
                ],
              ),

              // Children 2
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    desc,
                    style: Utils.customBodyFontStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )
                )
              ),

              const SizedBox(
                height: 10,
              ),

              // Children 3
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 260,
                  height: 35,
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.green : Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      isCompleted ? 'Challenge completed' : 'Challenge not completed',
                      style: Utils.customTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    )
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
