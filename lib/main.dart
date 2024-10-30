import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zelix_empire/auth/login.dart';
import 'package:zelix_empire/auth/signup.dart';
import 'package:zelix_empire/screens.dart/game.dart';
import 'package:zelix_empire/screens.dart/howtoplay.dart';
import 'package:zelix_empire/screens.dart/intro.dart';
import 'package:zelix_empire/screens.dart/options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAf1Cu9E4ovFROVxCWi9-7pb44ben58Nys",
      appId: "1:742305620820:android:7dd78eabb2f5a218eb1ec1",
      messagingSenderId: "742305620820",
      projectId: "zelix-empire",
      storageBucket: "zelix-empire.appspot.com",
    )
  ); // Firebase'i başlat
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Rise of Industry Game',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/login', // Uygulama açıldığında ilk olarak login ekranı
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/intro': (context) => const IntroScreen(),
            '/game': (context) => const GameScreen(),
            '/howtoplay': (context) => const HowToPlayScreen(),
            '/options': (context) => const OptionsScreen(),
          },
        );
  }
}
