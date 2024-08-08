import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key,required this.title, required this.leading});

  final IconData leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      title: Text(
        title,
        style: Utils.customHeadFontStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        )
      ),
      leading: Icon(
        leading,
        size: 30,
      ),
      trailing: const Icon(
        Icons.arrow_forward_sharp,
        size: 30,
      ),
    );
  }
}
