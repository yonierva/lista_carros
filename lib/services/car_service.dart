import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CarService {
  final String _baseUrl = 'https://67f7d1812466325443eadd17.mockapi.io/carros';

  Future<List<dynamic>> getCarList() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body); // Decodifica la respuesta JSON
    } else {
      throw Exception('Error al obtener la lista de carros: ${response.statusCode}');
    }
  }
}