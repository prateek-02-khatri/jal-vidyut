import 'package:flutter/material.dart';

import '../../utils/utils.dart';

CustomAppBar({String? title}) {
  return AppBar(
    toolbarHeight: 65,
    centerTitle: true,
    title: Text(
      title ?? 'Jal Vidyut',
      style: Utils.customBodyFontStyle(
          fontSize: 24
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/app_logo.png',
            width: 35,
            height: 35,
          ),
          const SizedBox(width: 15)
        ],
      )
    ],
  );
}
