import 'dart:convert';
import 'package:http/http.dart' as http;

class CarService {
  final String apiUrl = 'https://carros-electricos.wiremockapi.cloud/carros';

  Future<List<dynamic>> getCarList(String token) async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
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
