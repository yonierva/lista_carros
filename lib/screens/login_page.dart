import 'package:flutter/material.dart';
import '../screens/qr_scan.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Validar credenciales localmente
      if (_emailController.text == 'admin' && _passwordController.text == 'admin') {
        // Si las credenciales son correctas, redirigir a la página de autos
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => QRScanPage()),
        );
      } else {
        // Mostrar un mensaje de error si las credenciales son incorrectas
        throw Exception('Credenciales incorrectas.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Iniciar Sesión'),
                  ),
          ],
        ),
      ),
    );
  }
}