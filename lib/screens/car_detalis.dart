
import 'package:flutter/material.dart';

class CarDetails extends StatelessWidget {
  final Map car;

  const CarDetails({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Carro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.electric_car, size: 100, color: Colors.blue),
                SizedBox(height: 20),
                Text('Placa: ${car['placa']}', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text('Conductor: ${car['conductor']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('ID: ${car['id']}', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
