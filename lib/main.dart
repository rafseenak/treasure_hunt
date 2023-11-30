import 'package:flutter/material.dart';
import 'package:frontend/first_screen.dart';
import 'package:frontend/result.dart';
import 'package:splashscreen/splashscreen.dart';
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

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new SecondScreen(),
      title: new Text(
        'GeeksForGeeks',
        textScaleFactor: 2,
      ),
      image: new Image.network(
          'https://www.geeksforgeeks.org/wp-content/uploads/gfg_200X200.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}
