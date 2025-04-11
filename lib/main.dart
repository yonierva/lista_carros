import 'package:lista_carros/screens/car_list.dart';
import 'package:lista_carros/screens/car_detalis.dart';
import 'package:lista_carros/screens/login_page.dart';
import 'package:lista_carros/screens/menu_page.dart';
import 'package:lista_carros/screens/qr_scan.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carros Eléctricos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/carList': (context) => CarList(),
        '/menu': (context) => MenuPage(),
        '/scanner': (context) => QRScanner(),
        '/detail': (context) => CarDetails(car: ModalRoute.of(context)!.settings.arguments as Map),
      },
    );
  }
}