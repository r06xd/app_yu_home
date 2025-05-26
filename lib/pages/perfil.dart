import 'package:app_yu_home_front/models/usuario_model.dart';
import 'package:app_yu_home_front/pages/home.dart';
import 'package:app_yu_home_front/pages/pre_visualizacion_producto.dart';
import 'package:app_yu_home_front/repository/usuario_repository.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget{
  const Perfil({super.key});

  @override
  State<Perfil> createState()=> perfilState();
}

class perfilState extends State<Perfil>{
  final UserRepository _usuarioRepostitory = UserRepository();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<bool> _agregarUsuario() async {
    User nuevoUsuario = User(usuario: _email.text, password: _password.text);
    int resultado = await _usuarioRepostitory.insertarUsuario(nuevoUsuario);

    return resultado == 201;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Gestion Perfil'),),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _nombre,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Correo Electronico'),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'Conntraseña'),
            ),
            ElevatedButton(
              onPressed:() async { 
                bool agregado = await _agregarUsuario();
                if(agregado)
                {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context)=> const Home())
                          );
                }
              }
              , 
              child: const Text('Usuario Guardado'))
          ],
        ),
      ),
    );
  }
}