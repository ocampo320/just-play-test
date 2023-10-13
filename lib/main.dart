import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_play_test/view/login_view/login_view.dart';

import 'bloc/home_bloc.dart';
import 'core/constants/app_localizations.dart';
import 'core/constants/constans.dart';
import 'core/themes/custom_theme.dart';
import 'repository/data/court_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
 @override
  void initState() {
    
    super.initState();
     // _initRemoteConfig();
  }
  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
        theme: CustomTheme.theme,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
      
      ],
      home: MultiRepositoryProvider(
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
            home: LoginScreen(),
          ),
        ),
      ),
    );
  }

   void _initRemoteConfig() async{
    final t=await  _setupRemoteConfig();
    _setupL10n(t.getString(Constants.l10n));
   
  }

  Future<FirebaseRemoteConfig> _setupRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.pluginConstants.values.forEach((element) {
      print(element);
     });

    // Configura las opciones de Remote Config
    final settings = RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    );

    try {
      await remoteConfig.setConfigSettings(settings);

      // Realiza la recuperación y activación de la configuración remota
      await remoteConfig.fetchAndActivate();

      return remoteConfig;
    } catch (e) {
      print('Error al configurar Firebase Remote Config: $e');
      return remoteConfig; // Retorna la instancia incluso si hay un error
    }
  }

  void _setupL10n(
    String data,
  ) {
    var jsonData = jsonDecode(data) as Map;
    AppLocalizations.of(context)?.localizedValues =jsonData.map((key, value) => MapEntry(key, value as String));
  }
}
