import 'package:flutter/material.dart';
import 'package:frontend/bluetooth_page.dart';
import 'package:frontend/first_screen.dart';
// import 'package:frontend/second_screen.dart';

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
      home: const BluetoothPage(),
      // routes: {
      //   'first_screen': (ctx) {
      //     return const FirstScreen();
      //   },
      //   'second_screen': (ctx) {
      //     return SecondScreen();
      //   },
      // },
    );
  }
}
