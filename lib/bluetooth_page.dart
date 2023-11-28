import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'controller/bt_controller.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  final BluetoothController bluetoothController =
      Get.put(BluetoothController());

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    await bluetoothController.scanDevices();
    await bluetoothController.waitUntilDevicesFound();

    // Fluttertoast.showToast(
    //   msg: 'LET US FIND THE TOY',
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.green,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                List<ScanResult> devices = bluetoothController.devices;
                return ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    var device = devices[index].device;

                    return ListTile(
                      title: Text(device.name),
                      subtitle: Text(device.id.toString()),
                      trailing: Text('RSSI: ${devices[index].rssi}'),
                      onTap: () {
                        bluetoothController.connectToDevice(device);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
