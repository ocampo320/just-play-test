import 'package:flutter/material.dart';
import 'package:just_play_test/bloc/home_bloc.dart';
import 'package:just_play_test/bloc/home_event.dart';
import 'package:just_play_test/constans/color_manager.dart';
import 'package:just_play_test/view/home_view/save_page.dart';
import 'package:just_play_test/view/login_view/app_typography.dart';
import 'package:just_play_test/view/widgets/card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(
          HomeStarted(),
        );
    return Scaffold(
     
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.comentary03_900,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SavePage()),
        ),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title:  Text('Agenda de canchas',style:  AppTypography.stRaleway(
          color: ColorManager.comentary03_900,
          fontSize: 22,
          fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: ColorManager.neutral800,
      ),
      body:  SafeArea(
          child: Scaffold(
            backgroundColor:   ColorManager.neutral800,
        body: const SingleChildScrollView(
          child: CardWidget(),
        ),
      )),
    );
  }
}
