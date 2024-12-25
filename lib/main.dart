import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zelix_empire/auth/login.dart';
import 'package:zelix_empire/auth/signup.dart';
import 'package:zelix_empire/pages/citiespage.dart';
import 'package:zelix_empire/screens.dart/game.dart';
import 'package:zelix_empire/screens.dart/howtoplay.dart';
import 'package:zelix_empire/screens.dart/intro.dart';
import 'package:zelix_empire/screens.dart/options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zelix Empire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/intro': (context) => const IntroScreen(),
        '/game': (context) => const GameScreen(),
        '/options': (context) => const OptionsScreen(),
        '/howtoplay': (context) => const HowToPlayScreen(),
        '/cities': (context) => const CitiesPage()
      },
    );
  }
}