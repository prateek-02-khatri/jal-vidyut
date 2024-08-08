import 'package:flutter/material.dart';
import 'custom_card.dart';
import 'custom_row.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomCard(
                  cardTitle: 'Support',
                  cardSubtitle: 'rate our app'
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Column(
                  children: [
                    CustomRow(
                        title: 'Contact Support',
                        leading: Icons.contact_support
                    ),

                    CustomRow(
                        title: 'Rate our App',
                        leading: Icons.star_rate_sharp
                    ),

                    CustomRow(
                        title: 'Share',
                        leading: Icons.share
                    )
                  ],
                ),
              )
            ]
        )
    );
  }
}
