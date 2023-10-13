import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:just_play_test/bloc/home_bloc.dart';
import 'package:just_play_test/bloc/home_event.dart';
import 'package:just_play_test/bloc/home_state.dart';
import 'package:just_play_test/constans/color_manager.dart';
import 'package:just_play_test/core/constants/constans.dart';
import 'package:just_play_test/models/court.dart';
import 'package:just_play_test/view/utils/app_typography.dart';
import 'package:just_play_test/view/widgets/button_just_play.dart';

import '../widgets/input_just_play.dart';

class SavePage extends StatelessWidget {
  const SavePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.neutral800,
      appBar: AppBar(
        backgroundColor: ColorManager.neutral800,
        centerTitle: true,
        title: Text(
          Constants.scheduleCourts,
          style: AppTypography.stRaleway(
              color: ColorManager.comentary03_900,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: const SaveForm(),
    );
  }
}

class SaveForm extends StatefulWidget {
  const SaveForm({super.key});

  @override
  _SaveFormState createState() => _SaveFormState();
}

class _SaveFormState extends State<SaveForm> {
  final _formKey = GlobalKey<FormState>();
  List courts = ["Cancha grande", "Cancha media", "Cancha peque"];
  TextEditingController dateInput = TextEditingController(text: '');
  TextEditingController userInput = TextEditingController(text: '');
  TextEditingController courtInput = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
            child: Column(
              children: [
                InputJustPlay(
                  onChanged: (v) {
                    setState(() {
                      validateButtom();
                    });
                  },
                  controller: userInput,
                  placeHolder:Constants.nameResponsible,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.neutralWhite),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: DropdownButtonFormField(
                      focusColor: ColorManager.primary100,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      dropdownColor: ColorManager.comentary01_800,
                      
                      onTap: () {
                        setState(() {
                          validateButtom();
                        });
                      },
                      hint: Text(
                        Constants.selectCourt,
                        style: AppTypography.stRaleway(
                            color: ColorManager.neutralWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      // Down Arrow Icon
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors
                                  .white, // Cambia el color del ícono a blanco
                            ),
                          ],
                        ),
                      ),

                      // Array list of items
                      items: courts.map((items) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            setState(() {
                              validateButtom();
                            });
                          },
                          value: items,
                          child: Text(
                            items,
                            style: AppTypography.stRaleway(
                                color: ColorManager.neutralWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          validateButtom();
                          courtInput.text = newValue ?? '';
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.neutralWhite),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                        controller: dateInput,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                          hintText: Constants.date,
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: ColorManager
                                .neutralWhite, // Cambia el color del icono de fecha a blanco
                          ),
                          
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          setState(() {
                            validateButtom();
                          });

                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            dateInput.text = formattedDate;
                          } else {}
                        },
                        style: AppTypography.stRaleway(
                            color: ColorManager.neutralWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ButtonJustPlay(
                  color: ColorManager.comentary03_900,
                  colorText: ColorManager.neutralWhite,
                  fontSize: 16,
                  height: 50,
                   width: double.infinity,
                  onTap: validateButtom() == true
                      ? () async {
                          var coutn = await context
                              .read<HomeBloc>()
                              .getCountAndSum(courtInput.text);
                          var vaialblecourt = await context
                              .read<HomeBloc>()
                              .isCourtAvailable(
                                  dateInput.text, courtInput.text);
                          if (vaialblecourt == false) {
                            showAlertDialog(context);
                          } else {
                            context.read<HomeBloc>().add(SaveCourtStarted(Court(
                                  count: coutn,
                                  court: courtInput.text,
                                  date: dateInput.text,
                                  user: userInput.text,
                                )));
                            Navigator.pop(context);
                          }
                        }
                      : () {},
                  title: Constants.schedule,
                 
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool validateButtom() {
    var isActive = false;
    if (dateInput.text.isNotEmpty &&
        userInput.text.isNotEmpty &&
        courtInput.text.isNotEmpty) {
      isActive = false;
    } else {
      isActive = true;
      
    }
    return isActive;
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child:const Text(Constants.ok),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(Constants.error),
    content:const Text(Constants.courtNoLonger),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
