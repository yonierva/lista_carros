import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'car_list.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrCodeResult;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
  this.controller = controller;
  controller.scannedDataStream.listen((scanData) {
    setState(() {
      qrCodeResult = scanData.code;
    });

    // Detener el escaneo después de obtener un resultado
    controller.pauseCamera();

    // Mostrar el resultado o realizar alguna acción
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Código QR escaneado: $qrCodeResult')),
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear QR o Ver Lista')),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CarList()),
                    );
                  },
                  child: Text('Ver Lista de Carros'),
                ),
                if (qrCodeResult != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Resultado del QR: $qrCodeResult'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}