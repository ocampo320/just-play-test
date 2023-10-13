import 'package:flutter/material.dart';
import 'package:just_play_test/constans/color_manager.dart';
import 'package:just_play_test/view/widgets/button_just_play.dart';
import 'package:just_play_test/view/widgets/input_just_play.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController t = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/loginImg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 300,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        InputJustPlay(
                          placeHolder: "Name",
                          controller: t,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                         InputJustPlay(
                          controller: t,
                          placeHolder: "Password",
                        ), 
                        const SizedBox(
                          height: 70,
                        ),
                        ButtonJustPlay(
                          colorText: ColorManager.neutralWhite,
                          height: 45,
                          width: 180,
                          title: "Log in",
                          color: ColorManager.comentary03_900,
                          onTap: () {},
                          fontSize: 20,
                        ), 
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
