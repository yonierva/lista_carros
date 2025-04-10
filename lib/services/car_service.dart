import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CarService {
  final String apiUrl = 'https://carros-electricos.wiremockapi.cloud/carros';

  Future<List<dynamic>> getCarList() async {
    try {
      // Recuperar el token de SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('No se encontró un token almacenado.');
      }

      // Realizar la solicitud HTTP con el token
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Asegúrate de usar el formato correcto
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Error al obtener la lista de autos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}