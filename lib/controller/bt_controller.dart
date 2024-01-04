import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool isScanning = false;

  RxList<ScanResult> devices = <ScanResult>[].obs;

  StreamController<Map<BluetoothDevice, int>> deviceInfoStreamController =
      StreamController<Map<BluetoothDevice, int>>();

  Completer<void> devicesFoundCompleter = Completer<void>();

  final List<String> desiredDeviceIds = [
    "78:21:84:9D:B1:B2",
    // "44:17:93:7C:65:02",
  ];

  StreamController<Map<String, int>> rssiUpdatesStreamController =
      StreamController<Map<String, int>>.broadcast();

  BluetoothController() {
    flutterBlue.scan().listen((scanResult) async {
      devices.add(scanResult);
      deviceInfoStreamController.add({scanResult.device: scanResult.rssi});
      if (desiredDeviceIds.contains(scanResult.device.id.id)) {
        desiredDeviceIds.remove(scanResult.device.id.id);
      }
      if (desiredDeviceIds.isEmpty) {
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

  Stream<Map<BluetoothDevice, int>> get deviceInfoStream =>
      deviceInfoStreamController.stream;
  Future<void> waitUntilDevicesFound() async {
    await devicesFoundCompleter.future;
  }

  Future<void> scanDevices() async {
    flutterBlue.startScan();
    await waitUntilDevicesFound();
  }

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
