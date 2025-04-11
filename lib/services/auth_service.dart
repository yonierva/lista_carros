
class AuthService {
  Future<void> login(String username, String password) async {
    try {
      // Validar credenciales
      if (username == 'admin' && password == 'admin') {
        print('Inicio de sesión exitoso.');
      } else {
        throw Exception('Credenciales incorrectas.');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}