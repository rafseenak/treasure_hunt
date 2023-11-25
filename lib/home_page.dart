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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: StreamBuilder<bool>(
          stream: FlutterBluePlus.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data!) {
              return FloatingActionButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    FlutterBluePlus.turnOn();
                  }
                  FlutterBluePlus.stopScan();
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
                onPressed: () => FlutterBluePlus.startScan(
                  timeout: const Duration(seconds: 10),
                ),
              );
            }
          },
        ),
        body: StreamBuilder<List<ScanResult>>(
          stream: FlutterBluePlus.scanResults,
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
                        device.advName.isNotEmpty ? device.advName : 'Unknown Device';
                    final deviceAddress = device.remoteId.toString();

                    // if (scanResult.advertisementData.connectable) {
                      return ListTile(
                        tileColor: Colors.white60,
                        title: Text(deviceName),
                        subtitle: Text(deviceAddress),
                        onTap: () async {
                          FlutterBluePlus.stopScan();
                        },
                      );
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
