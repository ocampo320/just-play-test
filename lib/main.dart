import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_play_test/view/home_view/home_view.dart';

import 'bloc/home_bloc.dart';
import 'repository/data/court_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CourtStore(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(courtStore: CourtStore()),
          ),
        ],
        child: const MaterialApp(
          title: 'Just play App',
          home: HomePage(),
        ),
      ),
    );
  }
}
