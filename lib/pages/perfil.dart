import 'package:app_yu_home_front/models/cliente_model.dart';
import 'package:app_yu_home_front/models/usuario_model.dart';
import 'package:app_yu_home_front/pages/home.dart';
import 'package:app_yu_home_front/repository/usuario_repository.dart';
import 'package:app_yu_home_front/repository/clientes_repository.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget{
  final User user = User();
  final ClienteModel cliente = ClienteModel();
  Perfil({super.key});

  @override
  State<Perfil> createState()=> PerfilState();
}

class PerfilState extends State<Perfil>{
  final UserRepository _usuarioRepostitory = UserRepository();
  final ClientesRepository _clienteRepostitory = ClientesRepository();

  final Map<String, TextEditingController> controles = {};

  void inicializarControles(User user, ClienteModel cliente){
    user.toMap().forEach((key,value){
      controles[key] = TextEditingController(text: value);
    });

    cliente.toMap().forEach((key,value){
      controles[key] = TextEditingController(text: value);
    });
  }

  @override
  void initState() {
    super.initState();
    inicializarControles(widget.user, widget.cliente);
  }


  Future<bool> _agregarUsuario() async {
    User nuevoUsuario = User(usuario: controles['usuario']!.text, password:controles['password']!.text, idTipoUsuario: "Cliente", idPerfil: 2);
    User resultado = await _usuarioRepostitory.insertarUsuario(nuevoUsuario);
    ClienteModel nuevoCliente = ClienteModel(
      apellido: controles['apellido']!.text, 
      direccion: controles['direccion']!.text,
      email: controles['email']!.text,
      cedula: controles['cedula']!.text,
      telefono: controles['telefono']!.text,
      idUsuario: resultado.id,
      nombre: controles['nombre']!.text
      );
    ClienteModel resultadoClienteCreado = await _clienteRepostitory.crearCliente(nuevoCliente);
    return nuevoCliente!=null;
  }

  List<Widget> camposFormulario(){
    return [
      TextField(
        controller: controles['nombre'],
        decoration: const InputDecoration(labelText: 'Nombre'),
      ),
      TextField(
        controller: controles['usuario'],
        decoration: const InputDecoration(labelText: 'Usuario'),
      ),
      TextField(
        controller: controles['password'],
        decoration: const InputDecoration(labelText: 'Conntraseña'),
      ),TextField(
        controller: controles['idTipoUsuario'],
        decoration: const InputDecoration(labelText: 'Id Tipo Usuario'), // Hay que cambiar por combo o por defecto
      ),TextField(
        controller: controles['idPerfil'],
        decoration: const InputDecoration(labelText: 'Id Perfil'),// Hay que cambiar por combo o por defecto
      ),TextField(
        controller: controles['apellido'],
        decoration: const InputDecoration(labelText: 'Apellido'),
      ),TextField(
        controller: controles['direccion'],
        decoration: const InputDecoration(labelText: 'Direccion'),
      ),TextField(
        controller: controles['email'],
        decoration: const InputDecoration(labelText: 'Email'),
      ),TextField(
        controller: controles['cedula'],
        decoration: const InputDecoration(labelText: 'Cedula'),
      ),
      ElevatedButton(onPressed:() async { 
        bool agregado = await _agregarUsuario();
        if(agregado)
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context)=> const Home())
            );
        }
      }
      ,child: const Text('Usuario Guardado')
      )
    ];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color(0xFF869E00), 
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,),
      body: SingleChildScrollView(
        child: Center(
        child: Column(
          children: camposFormulario(),
        ),
      ),
      ) 
    );
  }
}