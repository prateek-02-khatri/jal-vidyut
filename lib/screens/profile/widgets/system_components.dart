import 'package:flutter/material.dart';
import 'package:jalvidyut/screens/profile/widgets/custom_card.dart';
import 'package:jalvidyut/screens/profile/widgets/custom_row.dart';

class SystemComponents extends StatelessWidget {
  const SystemComponents({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomCard(
                  cardTitle: 'System',
                  cardSubtitle: 'customise your system'
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Column(
                  children: [
                    CustomRow(
                        title: 'Reminders',
                        leading: Icons.notifications
                    ),

                    CustomRow(
                        title: 'Water',
                        leading: Icons.water
                    ),

                    CustomRow(
                        title: 'Electricity',
                        leading: Icons.lightbulb
                    )
                  ],
                ),
              )
            ]
        )
    );
  }
}
