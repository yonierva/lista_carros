import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool scanned = false;

  void handleBarcode(String code) async {
    if (!scanned) {
      setState(() {
        scanned = true;
      });

      try {
        final response = await http.get(Uri.parse('https://67f7d1812466325443eadd17.mockapi.io/carros/$code'));

        if (response.statusCode == 200) {
          final car = jsonDecode(response.body);
          Navigator.pushNamed(context, '/detail', arguments: car);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Carro no encontrado')),
          );
          setState(() {
            scanned = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al conectar con el servidor')),
        );
        setState(() {
          scanned = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear QR')),
      body: MobileScanner(
        onDetect: (barcode, args) {
          if (barcode.rawValue != null) {
            final code = barcode.rawValue!;
            if (code.isNotEmpty) {
              handleBarcode(code);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Código QR inválido')),
              );
            }
          }
        },
      ),
    );
  }
}