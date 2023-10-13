import 'package:flutter/material.dart';
import 'package:just_play_test/bloc/home_bloc.dart';
import 'package:just_play_test/bloc/home_event.dart';
import 'package:just_play_test/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_play_test/constans/color_manager.dart';
import 'package:just_play_test/core/constants/constans.dart';
import 'package:just_play_test/models/court.dart';
import 'package:just_play_test/services/weather_map_services.dart';
import 'package:just_play_test/view/home_view/home_view.dart';
import 'package:just_play_test/view/utils/app_typography.dart';
import 'package:just_play_test/view/widgets/text_card.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, this.nameCourt, this.date, this.userName});
  final String? nameCourt;
  final String? date;
  final String? userName;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeStarted());
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomeStarted());
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.when(
            save: (b) => const SizedBox(),
            initial: () => SizedBox(
                    child: Center(
                        child: Text(
                  'Agrege algo ',
                  style: AppTypography.stRaleway(
                      color: ColorManager.neutralWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ))),
            loading: () => const CircularProgressIndicator(),
            data: (data) => Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                  child: Column(
                    children: data
                        .map(
                          (e) => Center(
                            child: Card(
                              color: ColorManager.comentary02_400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: BorderSide(
                                    color: ColorManager.comentary03_900,
                                    width:
                                        2.0), // Cambia el color y el ancho del borde
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    trailing: IconButton(
                                      onPressed: () =>
                                          showAlertDialog(context, e),
                                      icon: CircleAvatar(
                                        backgroundColor:
                                            ColorManager.neutral600,
                                        child: Icon(
                                          Icons.delete,
                                          color: ColorManager.comentary03_900,
                                        ),
                                      ),
                                    ),
                                    title: FutureBuilder<String>(
                                        future: WeatherMapServices
                                            .getWeatherMapServices(
                                                'city', e.date ?? ''),
                                        builder: (context, snapshot) {
                                          return snapshot.data != null
                                              ? Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Icon(
                                                        Icons.wb_cloudy_sharp,
                                                        color: ColorManager
                                                            .neutral600,
                                                        size: 25,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: TextCard(
                                                        text: snapshot.data
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Center(
                                                child: const CircularProgressIndicator(),
                                              );
                                        }),
                                    leading: Icon(
                                      color: ColorManager.neutral600,
                                      Icons.check_circle_outline,
                                      size: 40,
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextCard(
                                              text: e.user ?? "",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            TextCard(
                                              text: e.court ?? "",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            TextCard(
                                              text: e.date ?? "",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
            error: (error) {
              return Text(error.message);
            });
      },
    );
  }
}
showAlertDialog(BuildContext context, Court e) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text(Constants.ok),
    onPressed: () {
      context.read<HomeBloc>().add(DeleteStarted(e));
      Navigator.of(context).pop(); // Cierra el AlertDialog
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(Constants.attention),
    content: const Text(Constants.areYouSure),
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

