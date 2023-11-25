// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io';

class BtList extends StatefulWidget {
  const BtList({Key? key}) : super(key: key);

  @override
  State<BtList> createState() => _BtListState();
}

class _BtListState extends State<BtList> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 230, 135, 135),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: StreamBuilder<bool>(
          stream: flutterBlue.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data!) {
              return FloatingActionButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    FlutterBluePlus.instance.turnOn();
                  }
                  flutterBlue.stopScan();
                },
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.stop,
                  color: Colors.white,
                ),
              );
            } else {
              return FloatingActionButton(
                child: const Icon(
                  Icons.bluetooth,
                  color: Colors.white,
                ),
                onPressed: () => flutterBlue.startScan(
                  timeout: const Duration(seconds: 10),
                ),
              );
            }
          },
        ),
        body: StreamBuilder<List<ScanResult>>(
          stream: flutterBlue.scanResults,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final scanResults = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: scanResults.length,
                  itemBuilder: (context, index) {
                    final scanResult = scanResults[index];
                    final device = scanResult.device;
                    final deviceName =
                        device.name.isNotEmpty ? device.name : 'Unknown Device';
                    final deviceAddress = device.id.toString();

                    if (scanResult.advertisementData.connectable) {
                      return ListTile(
                        tileColor: Colors.white60,
                        title: Text(deviceName),
                        subtitle: Text(deviceAddress),
                        onTap: () async {
                          flutterBlue.stopScan();
                          device.connect(autoConnect: false);
                          // print("done");
                        },
                      );
                    } else {
                      return Container(); // or any placeholder widget when not connectable
                    }
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
    );
  }
}
