import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

    Fluttertoast.showToast(
      msg: 'All desired devices found!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    setState(() {
      devices = bluetoothController.getDevicesWithIds(["12:E0:3F:BB:68:47"]);
    });
  }

  @override
  void dispose() {
    bluetoothController.deviceInfoStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.noOfPlayers)),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (allFound)
              Column(
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
                      onPressed: () {
                        devices[0].device.connect();
                      },
                      child: const Text('START TRACKING'),
                    ),
                  ),
                ],
              )
            else
              const Center(
                child: Text(
                  'Waiting for all devices to connect...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
