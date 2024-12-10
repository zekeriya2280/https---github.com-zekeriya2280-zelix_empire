
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zelix_empire/auth/login.dart';
import 'package:zelix_empire/auth/signup.dart';
import 'package:zelix_empire/screens.dart/game.dart';
import 'package:zelix_empire/screens.dart/howtoplay.dart';
import 'package:zelix_empire/screens.dart/intro.dart';
import 'package:zelix_empire/screens.dart/options.dart';
import 'package:zelix_empire/temp/productdisplayscreen.dart';
import 'package:zelix_empire/temp/productsyncmanager.dart';

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
    )); // Firebase'i başlat
    print("Firebase initialized.");
    runApp(const MyApp());
  } on FirebaseException catch (e) {
    print('Error initializing Firebase: $e');
  } on Exception catch (e) {
    print('An unexpected error occurred: $e');
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer periodic = Timer.periodic(const Duration(seconds: 99), (timer) {});
  @override
  void initState(){
    _syncFirebaseWithJson();
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 3));
      await _syncFirebaseWithJson();
      return true;
    });
    super.initState();
  }
  @override
  void dispose() {
    periodic.cancel();
    super.dispose();
  }
  Future<void> _syncFirebaseWithJson() async {
    final ProductSyncManager productSyncManager = ProductSyncManager();
    await productSyncManager.syncWithFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rise of Industry Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/jsondisplay', // Uygulama açıldığında ilk olarak login ekranı
      routes: {
        '/jsondisplay': (context) => ProductDisplayScreen(),
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
