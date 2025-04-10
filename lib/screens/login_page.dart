import 'package:flutter/material.dart';
import '../services/auth_service.dart'; 
import '../screens/car_list.dart'; 

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
    AuthService authService = AuthService();
    await authService.login(
      _emailController.text,
      _passwordController.text,
    );

    // Si el login es exitoso, redirigir a la página de autos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CarList()),
    );
  } catch (e) {
    // Mostrar un mensaje de error si ocurre algún problema
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
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Correo Electrónico')),
            TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Contraseña')),
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
