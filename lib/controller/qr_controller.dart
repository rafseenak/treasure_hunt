import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "VERIFY";
  String btId = '';
  @override
  Widget build(BuildContext context) {
    btId = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          // (btId == qrText) ? const Text("Ok") : const Text("Not Ok"),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print('Scanned1111111111111');
        qrText = scanData.code.toString();
        print('qrText is $qrText and $btId');
      });

      if (btId == qrText) {
        Navigator.pushNamed(
          context,
          'rslt',
        );
      } else {
        Navigator.pushNamed(
          context,
          'rslt2',
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
