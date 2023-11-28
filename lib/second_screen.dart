import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'controller/bt_controller.dart';

class SecondScreen extends StatefulWidget {
  final String noOfPlayers;
  const SecondScreen({super.key, required this.noOfPlayers});
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

    // Fluttertoast.showToast(
    //   msg: 'All found!',
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.green,
    //   textColor: Colors.red,
    //   fontSize: 16.0,
    // );
    setState(() {
      devices = bluetoothController.getDevicesWithIds(["78:21:84:9D:B1:B2"]);
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

  players() {
    if (widget.noOfPlayers == '1') {
      return 1;
    }
    if (widget.noOfPlayers == '2') {
      return 2;
    }
    if (widget.noOfPlayers == '3') {
      return 3;
    } else if (widget.noOfPlayers == '4') {
      return 4;
    }
  }

  String displayText = 'FIND ME';
  Color bgColor = Colors.pink;
  String btText = 'START TRACKING';
  bool verifyOrNot = true;
  void updateText(String text, Color clr, String bttxt) {
    setState(() {
      displayText = text;
      btText = bttxt;
      bgColor = clr;
    });
  }

  void verify() {
    print('verified');
  }

  void noVerify() {
    print('Not verified');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          color: bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.network(
                        'https://th.bing.com/th?id=OIP.7uXDDlh5zaXitzyw0b1uDAHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
                        width: 250,
                        height: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        // onPressed: () {
                        //   updateText('text', Colors.red, 'bttxt');
                        // },
                        onPressed: () {
                          if (isNear(devices[0].rssi)) {
                            updateText(
                                'Wow! You are Near to the Device. Did You Find It, Then You Can Check The Result Below.',
                                Colors.green,
                                'VERIFY');
                          } else {
                            updateText(
                                'Oops! You are Far Away from the Device, Try More...',
                                Colors.red,
                                'TRACK AGAIN');
                          }
                          devices[0].device.connect();
                        },
                        child: Text(btText),
                      ),
                    ),
                  ],
                )
              else
                Center(
                  child: Text(
                    'LOADING...${players().toString()}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
// ElevatedButton(
//     onPressed: isNear(devices[0].rssi)
//         ? () {
//             verify;
//           }
//         : () {
//             noVerify;
//           },
//     child: const Text('CLICK ME'),
//   ),