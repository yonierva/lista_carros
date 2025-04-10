import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String apiUrl = 'https://carros-electricos.wiremockapi.cloud/auth';

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Parseamos el cuerpo de la respuesta
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Validamos si el token está presente
        if (data.containsKey('token')) {
          final String token = data['token'];

          // Guardamos el token en SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);

          print('Token almacenado correctamente.');
        } else {
          throw Exception('El token no está presente en la respuesta.');
        }
      } else {
        throw Exception('Error al iniciar sesión: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}