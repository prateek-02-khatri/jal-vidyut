import 'package:flutter/material.dart';
import 'custom_card.dart';
import 'custom_row.dart';

class AppearanceComponents extends StatelessWidget {
  const AppearanceComponents({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomCard(
                  cardTitle: 'Appearance',
                  cardSubtitle: 'customise your app'
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Column(
                  children: [
                    CustomRow(
                        title: 'Theme',
                        leading: Icons.settings
                    ),

                    CustomRow(
                        title: 'Home Screen',
                        leading: Icons.home
                    ),
                  ],
                ),
              )
            ]
        )
    );
  }
}
