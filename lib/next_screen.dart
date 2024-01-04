import 'package:flutter/material.dart';
import 'package:frontend/second_screen.dart';

class NextScreen extends StatefulWidget {
  final List<String> dlist;
  const NextScreen({super.key, required this.dlist});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'LET US FIND NEXT TOY.',
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
                        noOfPlayers: widget.dlist.length.toString(),
                        dlist: widget.dlist,
                      );
                    },
                  ),
                );
              },
              child: const Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }
}
