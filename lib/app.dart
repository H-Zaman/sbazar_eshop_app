import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sbazar/app/pages/authenticationPage.dart';
import 'package:sbazar/others/resources/colors.dart';
import 'package:sbazar/others/resources/fonts.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: CFontFamily.REGULAR,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: AppColor.GREEN
          )
        )
      ),
      home: AuthenticationPage(),
    );
  }
}
