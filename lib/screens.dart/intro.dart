import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

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
