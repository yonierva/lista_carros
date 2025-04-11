import 'package:flutter/material.dart';
import '../services/car_service.dart';

class CarList extends StatefulWidget {
  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarList> {
  bool _isLoading = true;
  List<dynamic> _cars = [];

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  void _loadCars() async {
    try {
      CarService carService = CarService();
      final cars = await carService.getCarList(); // Llamada al servicio para obtener la lista de carros
      setState(() {
        _cars = cars;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listado de Autos')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (context, index) {
                final car = _cars[index];
                return ListTile(
                  leading: car['imagen'] != null
                      ? Image.network(car['imagen'], width: 50, height: 50, fit: BoxFit.cover)
                      : Icon(Icons.directions_car), // Icono predeterminado si no hay imagen
                  title: Text(car['conductor'] ?? 'Conductor no disponible'),
                  subtitle: Text(car['placa'] ?? 'Placa no disponible'),
                );
              },
            ),
    );
  }
}