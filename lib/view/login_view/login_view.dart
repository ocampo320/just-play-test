import 'package:flutter/material.dart';
import 'package:just_play_test/constans/color_manager.dart';
import 'package:just_play_test/core/constants/constans.dart';
import 'package:just_play_test/services/login_services.dart';
import 'package:just_play_test/view/home_view/home_view.dart';
import 'package:just_play_test/view/widgets/button_just_play.dart';
import 'package:just_play_test/view/widgets/input_just_play.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController user = TextEditingController();
    TextEditingController password = TextEditingController();
    return MaterialApp(
    
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constants.mainImage),
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
                            Constants.iconImage,
                            color: ColorManager.primary100,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InputJustPlay(
                          placeHolder: Constants.name,
                          controller: user,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputJustPlay(
                          controller: password,
                          placeHolder: Constants.password,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        ButtonJustPlay(
                          colorText: ColorManager.neutralWhite,
                          height: 45,
                          width: 180,
                          title: Constants.logIn,
                          color: ColorManager.comentary03_900,
                          onTap: () {
                            AuthServices.login(
                                    user.value.text, password.value.text)
                                .then((value) {
                              if (value) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              }else{
                                Text(Constants.errorConnecting);
                              }
                            });
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
