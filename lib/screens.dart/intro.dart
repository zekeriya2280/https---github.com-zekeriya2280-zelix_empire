import 'package:flutter/material.dart';
import 'package:zelix_empire/firebase/fbcontroller.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    Fbcontroller().addProductsToFirestore();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Intro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
              child: const Text('Game'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/how-to-play');
              },
              child: const Text('How to Play'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/options');
              },
              child: const Text('Options'),
            ),
          ],
        ),
      ),
    );
  }
}
