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
  final List<String> desiredDeviceIds = [
    '01:E3:8F:7A:7D:7A',
    '3C:79:F4:F8:8C:A6',
    '43:E8:39:49:B7:88',
    '59:87:08:76:67:BA',
    // '12:EB:56:40:C3:66',
  ];

  BluetoothController() {
    // Listen to scan events
    flutterBlue.scan().listen((scanResult) async {
      final List<ScanResult> foundDevices = devices;
      for (ScanResult result in foundDevices) {
        print('Found Device: ${result.device.id}, RSSI: ${result.rssi}');
      }

      // Update the list of devices
      devices.add(scanResult);

      // Notify the UI about device info changes
      deviceInfoStreamController.add({scanResult.device: scanResult.rssi});

      // Check if desired devices are found
      if (desiredDeviceIds.contains(scanResult.device.id.id)) {
        // Mark the device as found
        print('Found desired device: ${scanResult.device.id.id}');

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
}
