import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:frontend/controller/qr_controller.dart';
import 'package:get/get.dart';
import 'controller/bt_controller.dart';

class SecondScreen extends StatefulWidget {
  final String noOfPlayers;
  final int players;
  final List<String> dlist;
  SecondScreen({super.key, required this.noOfPlayers, required this.dlist})
      : players = int.tryParse(noOfPlayers) ?? 0;
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool allFound = false;

  final BluetoothController bluetoothController =
      Get.put(BluetoothController());

  late List<ScanResult> devices;
  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    await bluetoothController.scanDevices();
    await bluetoothController.waitUntilDevicesFound();

    setState(() {
      allFound = true;
    });
    setState(() {
      devices = bluetoothController.getDevicesWithIds([widget.dlist[0]]);
    });
  }

  @override
  void dispose() {
    bluetoothController.deviceInfoStreamController.close();
    super.dispose();
  }

  final int nearThreshold = -70;
  bool isNear(int rssi) {
    return rssi >= nearThreshold;
  }

  buttonAction() {
    if (btText == 'TRACK') {
      if (isNear(devices[0].rssi)) {
        updateText(
          'Wow! You are Near to the Device.\nDid You Find It?\nYou Can Check The Result Below.',
          Colors.green,
          'VERIFY',
        );
      } else {
        updateText(
          'Oops! You are Far Away from the Device, Try More...',
          Colors.red,
          'TRACK AGAIN',
        );
      }
      devices[0].device.connect();
    } else if (btText == 'VERIFY') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return QRViewExample(
              btId: devices[0].device.id.id,
              dlist: widget.dlist,
            );
          },
        ),
      );
    } else if (btText == 'TRACK AGAIN') {
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
      // Navigator.pushReplacementNamed(context, 'second_screen');
    }
  }

  String displayText = 'FIND ME.';
  Color bgColor = Colors.white;
  String btText = 'TRACK';
  bool verifyOrNot = true;

  void updateText(String text, Color clr, String bttxt) {
    setState(() {
      displayText = text;
      btText = bttxt;
      bgColor = clr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          color: bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (allFound)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          displayText,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage('assets/toy1.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          buttonAction();
                        },
                        child: Text(btText),
                      ),
                    ),
                  ],
                )
              else
                const Column(
                  children: [
                    Center(
                      child: Text(
                        'LOADING...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
