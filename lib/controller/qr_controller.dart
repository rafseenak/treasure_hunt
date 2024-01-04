import 'package:flutter/material.dart';
import 'package:frontend/next_screen.dart';
import 'package:frontend/result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final String btId;
  final List<String> dlist;
  const QRViewExample({super.key, required this.btId, required this.dlist});
  @override
  QRViewExampleState createState() => QRViewExampleState();
}

class QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "VERIFY";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code.toString();
      });
      List<String> updatedDList = List.from(widget.dlist);
      if (widget.btId == qrText) {
        updatedDList.remove(widget.btId);
        if (updatedDList.isEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return const CenteredText();
              },
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return NextScreen(
                  dlist: updatedDList,
                );
              },
            ),
          );
        }
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return CenteredText2(
                dlist: widget.dlist,
              );
            },
          ),
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
