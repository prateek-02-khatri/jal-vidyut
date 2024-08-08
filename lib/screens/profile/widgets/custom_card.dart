import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.cardTitle, required this.cardSubtitle});

  final String cardTitle;
  final String cardSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(cardTitle, style: Utils.customHeadFontStyle()),
        Text(cardSubtitle,style: Utils.customBodyFontStyle(color: Colors.grey)),
        const SizedBox(height: 5,),
      ]
    );
  }
}
