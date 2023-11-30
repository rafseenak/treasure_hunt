import 'package:flutter/material.dart';
import 'package:frontend/first_screen.dart';
import 'package:frontend/result.dart';
import 'controller/qr_controller.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
      home: const FirstScreen(),
      routes: {
        'qrread': (context) => const QRViewExample(),
        'rslt': (context) => const CenteredText(),
        'rslt2': (context) => const CenteredText2(),
      },
    );
  }
}
