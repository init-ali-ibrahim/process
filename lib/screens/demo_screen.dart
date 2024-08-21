import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final MobileScannerController cameraController = MobileScannerController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: Column(
        children: [
          Text('data'),
          MobileScanner(
            fit: BoxFit.fill,
            controller: MobileScannerController(
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
            onDetect: (barcodes) {
              // QrScannerOverlayShape
            },
            overlayBuilder: (context, constraints) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(
                        ),
                      ),
                    ),
                  ),
                  // ... другие пользовательские виджеты
                ],
              );
            },
          )
        ],
      )
    );
  }
}


