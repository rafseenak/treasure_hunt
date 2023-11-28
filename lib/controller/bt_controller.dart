import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool isScanning = false;
  // Use an RxList to reactively update the list of devices
  RxList<ScanResult> devices = <ScanResult>[].obs;

  // Stream controller to handle device info updates (BluetoothDevice and RSSI)
  StreamController<Map<BluetoothDevice, int>> deviceInfoStreamController =
      StreamController<Map<BluetoothDevice, int>>();

  // Completer to notify UI when desired devices are found
  Completer<void> devicesFoundCompleter = Completer<void>();

  // List of hardcoded device IDs to search for
  final List<Map<String, dynamic>> deviceList = [
    {
      'mac_id': '78:21:84:9D:B1:B2',
      'image':
          'https://th.bing.com/th?id=OIP.7uXDDlh5zaXitzyw0b1uDAHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2',
      'name': 'TOY 1',
    },
    {
      'mac_id': '78:21:84:9D:B1:B3',
      'image':
          'https://i.pinimg.com/736x/d9/3b/37/d93b3726ea9cdd9a2bc4cc53fe53ad75.jpg',
      'name': 'TOY 2',
    },
  ];
  final List<String> desiredDeviceIds = [
    "78:21:84:9D:B1:B2",
    // "12:E0:3F:BB:68:47",
    // '3B:EF:E1:F9:0F:15',
    // '01:E3:8F:7A:7D:7A',
  ];

  StreamController<Map<String, int>> rssiUpdatesStreamController =
      StreamController<Map<String, int>>.broadcast();

  BluetoothController() {
    // Listen to scan events
    flutterBlue.scan().listen((scanResult) async {
      // final List<ScanResult> foundDevices = devices;
      // for (ScanResult result in foundDevices) {
      //   print('Found Device: ${result.device.id}, RSSI: ${result.rssi}');
      // }

      // Update the list of devices
      devices.add(scanResult);

      // Notify the UI about device info changes
      deviceInfoStreamController.add({scanResult.device: scanResult.rssi});

      // Check if desired devices are found
      if (desiredDeviceIds.contains(scanResult.device.id.id)) {
        // final List<Map<String, dynamic>> rslt = [
        //   {
        //     'mac_id': scanResult.device.id.id,
        //     'rssi': scanResult.rssi,
        //   },
        // ];
        // Remove the found device from the list of desired devices
        desiredDeviceIds.remove(scanResult.device.id.id);
        // Check if all desired devices are found
      }
      if (desiredDeviceIds.isEmpty) {
        // Notify the UI that all desired devices are found
        await flutterBlue.stopScan();
        devicesFoundCompleter.complete();
      }
    });
  }

  @override
  void dispose() {
    deviceInfoStreamController.close();
    rssiUpdatesStreamController.close();
    super.dispose();
  }

  // Stream for device info changes (BluetoothDevice and RSSI)
  Stream<Map<BluetoothDevice, int>> get deviceInfoStream =>
      deviceInfoStreamController.stream;

  // Future to wait until all desired devices are found
  Future<void> waitUntilDevicesFound() async {
    // Wait until all desired devices are found
    await devicesFoundCompleter.future;
  }

  Future<void> scanDevices() async {
    flutterBlue.startScan();
    await waitUntilDevicesFound();
  }

  // Connect to device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
  }

  List<ScanResult> getDevicesWithIds(List<String> deviceIds) {
    return devices
        .where((result) => deviceIds.contains(result.device.id.id))
        .map((result) => result)
        .toList();
  }
}
