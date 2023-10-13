import 'package:flutter/material.dart';
import 'package:just_play_test/constans/color_manager.dart';
import 'package:just_play_test/view/home_view/home_view.dart';
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.webp'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 300,
                ),
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.comentary01_100),
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/icon.webp',
                            color: ColorManager.primary100,
                          ),
                        ),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
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
