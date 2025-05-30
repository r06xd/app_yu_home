import 'package:app_yu_home_front/pages/catalogo_page.dart';
import 'package:app_yu_home_front/pages/home.dart';
import 'package:app_yu_home_front/pages/perfil.dart';
import 'package:app_yu_home_front/repository/usuario_repository.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserRepository _usuarioRepostitory = UserRepository();
  final TextEditingController _usuario = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  bool _cargando = false;

  void _iniciarSesion() async {
    setState(() => _cargando = true); // Mostrar el spinner

    bool valido = await _usuarioRepostitory.validarUsuario(_usuario.text, _pass.text);

    setState(() => _cargando = false); // Ocultar el spinner

    if (valido) {
      if (_usuario.text == 'Admin') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CatalogoPage()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El usuario no existe'), duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.jpg', width: 150, height: 150),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  controller: _usuario,
                  decoration: const InputDecoration(
                    labelText: "Correo",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  controller: _pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (_cargando)
                const CircularProgressIndicator()
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Perfil()));
                      },
                      child: const Text("Crear Usuario"),
                    ),
                    const Text("/"),
                    TextButton(
                      onPressed: _iniciarSesion,
                      child: const Text("Iniciar sesión"),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
