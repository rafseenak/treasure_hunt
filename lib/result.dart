import 'package:flutter/material.dart';
import 'package:frontend/second_screen.dart';

class CenteredText extends StatelessWidget {
  const CenteredText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'WOW! YOU WIN',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CenteredText2 extends StatelessWidget {
  const CenteredText2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'OOPS! YOU ARE WRONG',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "DON'T WORRY!",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              MaterialPageRoute(
                builder: (ctx) {
                  return const SecondScreen(noOfPlayers: '1');
                },
              );
            },
            child: const Text('TRY AGAIN'),
          ),
        ],
      ),
    );
  }
}
