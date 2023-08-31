import 'package:datacar/initial_page.dart';
import 'package:datacar/pages/categories/provider/categories_provider.dart';
import 'package:datacar/pages/home/provider/home_provider.dart';
import 'package:datacar/pages/login/provider/login_provider.dart';
import 'package:datacar/pages/splash/providers/splash_provider.dart';
import 'package:datacar/services/shared_preferences_static.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp();
  await SharedPreferencesLocal.configurePrefs();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false,create: ( _ ) => SplashProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => LoginProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => HomeProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => CategoriesProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DataCar',
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(
                  Colors.grey.withOpacity(0.5)
              )
          )
      ),
      home: const InitialPage(),
    );
  }
}
