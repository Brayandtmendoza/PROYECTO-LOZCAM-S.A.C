import 'package:flutter/material.dart';
import '../service/digi_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Usamos DigiService que es tu archivo real
  final DigiService _digiService = DigiService();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // CORRECCIÓN DEL ERROR TYPE 'NULL': 
    // Usamos '?' para que no explote si no hay argumentos y '??' para un valor por defecto.
    final String role = (ModalRoute.of(context)?.settings.arguments as String?) ?? 'Usuario';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Lozcam - $role'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
                  const SizedBox(height: 30),
                  
                  // Campo de Usuario
                  TextFormField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => 
                        value == null || value.isEmpty ? 'Por favor ingresa tu usuario' : null,
                  ),
                  const SizedBox(height: 20),
                  
                  // Campo de Contraseña
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) => 
                        value == null || value.isEmpty ? 'Por favor ingresa tu contraseña' : null,
                  ),
                  const SizedBox(height: 30),
                  
                  // Botón de Ingreso
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Llamada al servicio Node.js
                          bool success = await _digiService.login(
                            _userController.text, 
                            _passwordController.text
                          );

                          if (success) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('¡Bienvenido como $role!')),
                            );
                            // Navega a la pantalla de productos
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error: Usuario o clave incorrectos'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('INICIAR SESIÓN', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}