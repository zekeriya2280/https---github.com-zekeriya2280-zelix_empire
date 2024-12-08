import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zelix_empire/auth/login.dart';
import 'package:zelix_empire/auth/signup.dart';
import 'package:zelix_empire/screens.dart/game.dart';
import 'package:zelix_empire/screens.dart/howtoplay.dart';
import 'package:zelix_empire/screens.dart/intro.dart';
import 'package:zelix_empire/screens.dart/options.dart';
import 'package:zelix_empire/temp/productwatcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print("Initializing Firebase...");
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAf1Cu9E4ovFROVxCWi9-7pb44ben58Nys",
        appId: "1:742305620820:android:7dd78eabb2f5a218eb1ec1",
        messagingSenderId: "742305620820",
        projectId: "zelix-empire",
        storageBucket: "zelix-empire.appspot.com",
      )
    ); // Firebase'i başlat
    print("Firebase initialized.");
    final watcher = ProductWatcher();
    print("Product watcher created. Initializing...");

    //await watcher.initialize();
    print("Getting application document directory...");
    final filePath = await getApplicationDocumentsDirectory().then((value) => '${value.path}/products.json');
    print("Watching file at $filePath");
    await watcher.watchFile(filePath);
    print("Product watcher started.");
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      print("Refreshing product watcher...");
      await watcher.watchFile(filePath);
      print("Product watcher refreshed.");
    });
    print("Running the app...");
    runApp(const MyApp());
  } on FirebaseException catch (e) {
    print('Error initializing Firebase: $e');
  } on Exception catch (e) {
    print('An unexpected error occurred: $e');
  }
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
