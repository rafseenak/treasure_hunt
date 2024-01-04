import 'package:flutter/material.dart';
import 'package:frontend/first_screen.dart';
import 'package:frontend/second_screen.dart';

class CenteredText extends StatelessWidget {
  const CenteredText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'WOW! YOU WIN.',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return const FirstScreen();
                    },
                  ),
                );
              },
              child: const Text('PLAY AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}

class CenteredText2 extends StatelessWidget {
  final List<String> dlist;
  const CenteredText2({super.key, required this.dlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'OOPS! YOU ARE WRONG',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return SecondScreen(
                        noOfPlayers: dlist.length.toString(),
                        dlist: dlist,
                      );
                    },
                  ),
                );
              },
              child: const Text('TRY AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
