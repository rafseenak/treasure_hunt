import 'package:flutter/material.dart';
import 'package:frontend/second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SELECT THE NUMBER OF PLAYERS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return SecondScreen(
                                noOfPlayers: '1',
                                dlist: const [
                                  "78:21:84:9D:B1:B2",
                                ],
                              );
                            },
                          ),
                        );
                      },
                      child: const Text('1'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return SecondScreen(
                                noOfPlayers: '2',
                                dlist: const [
                                  "78:21:84:9D:B1:B2",
                                  "44:17:93:7C:65:02",
                                ],
                              );
                            },
                          ),
                        );
                      },
                      child: const Text('2'),
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: SizedBox(
            //         width: 100,
            //         height: 50,
            //         child: ElevatedButton(
            //           onPressed: () {
            //             Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (ctx) {
            //                   return SecondScreen(
            //                     noOfPlayers: '3',
            //                     dlist: const [
            //                       "78:21:84:9D:B1:B2",
            //                       // "44:17:93:7C:65:02",
            //                     ],
            //                   );
            //                 },
            //               ),
            //             );
            //           },
            //           child: const Text('3'),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: SizedBox(
            //         width: 100,
            //         height: 50,
            //         child: ElevatedButton(
            //           onPressed: () {
            //             Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (ctx) {
            //                   return SecondScreen(
            //                     noOfPlayers: '4',
            //                     dlist: const [
            //                       "78:21:84:9D:B1:B2",
            //                       // "44:17:93:7C:65:02",
            //                     ],
            //                   );
            //                 },
            //               ),
            //             );
            //           },
            //           child: const Text('4'),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
