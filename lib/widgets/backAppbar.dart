import 'package:flutter/material.dart';

import '../utils/AppColor.dart';

AppBar backAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () { Navigator.pop(context); },
      icon: const Icon(Icons.arrow_back_ios_new,color: AppColor.white,),
    ),
  );
}