import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String noOfPlayers;
  const SecondScreen({super.key, required this.noOfPlayers});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(noOfPlayers)),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'FIND ME',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                'https://th.bing.com/th/id/OIP.PnrPt-2unjmxqZhPl5uFrQHaE8?pid=ImgDet&rs=1',
                width: 250,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('START TRACKING'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
