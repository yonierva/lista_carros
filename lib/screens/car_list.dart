import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List cars = [];

  Future<void> fetchCars() async {
    final response = await http.get(
      Uri.parse('https://67f7d1812466325443eadd17.mockapi.io/carros'),
    );

    if (response.statusCode == 200) {
      setState(() {
        cars = jsonDecode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Carros Eléctricos')),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.electric_car, size: 40),
              title: Text('Placa: ${cars[index]['placa']}'),
              subtitle: Text('Conductor: ${cars[index]['conductor']}'),
            ),
          );
        },
      ),
    );
  }
}