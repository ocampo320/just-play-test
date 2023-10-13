import 'package:flutter/material.dart';

import 'constans/color_manager.dart';
import 'view/login_view/login_view.dart';

class TopsitesClient extends StatefulWidget {
  const TopsitesClient({super.key});

  @override
  State<TopsitesClient> createState() => _TopsitesClientState();
}

class _TopsitesClientState extends State<TopsitesClient> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: ColorManager.neutral100,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              color: ColorManager.textDarkMedium,
            ),
            hintStyle: TextStyle(
              color: ColorManager.textDarkMedium,
            ),
            errorStyle: TextStyle(
              color: ColorManager.comentary03_900,
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.comentary03_900),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
              borderSide: BorderSide(color: ColorManager.textDarkLow),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.comentary02_900),
            ),
          ),
        ),
        home: const LoginScreen()

        // initialRoute: '/',

        );
  }
}
