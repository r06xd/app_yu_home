import 'package:app_yu_home_front/models/cliente_model.dart';
import 'package:app_yu_home_front/models/usuario_model.dart';
import 'package:app_yu_home_front/pages/catalogo_page.dart';
import 'package:app_yu_home_front/repository/usuario_repository.dart';
import 'package:app_yu_home_front/repository/clientes_repository.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  final int? idUsuario; // Opcional

  Perfil({super.key, this.idUsuario});

  @override
  State<Perfil> createState() => PerfilState();
}

class PerfilState extends State<Perfil> {
  final UserRepository _usuarioRepostitory = UserRepository();
  final ClientesRepository _clienteRepostitory = ClientesRepository();
  final Map<String, TextEditingController> controles = {};
  bool isLoading = false;

  void inicializarControles(User user, ClienteModel cliente) {
    controles.clear();

    user.toMap().forEach((key, value) {
      controles[key] = TextEditingController(text: value ?? '');
    });

    cliente.toMap().forEach((key, value) {
      controles[key] = TextEditingController(text: value ?? '');
    });
  }

  void mostrarCarga(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> obtenerDatosUsuarioYCliente() async {
    if (widget.idUsuario == null) return;

    setState(() => isLoading = true);
    mostrarCarga(context);

    try {
      List<User> usuarios = await _usuarioRepostitory.obtenerUsuarios();
      User usuario = usuarios.firstWhere((user)=>user.id == _usuarioRepostitory.obtenerIdUsuariolocal());
      ClienteModel cliente = await _clienteRepostitory.obtenerClienteByUsuario(widget.idUsuario!);
      inicializarControles(usuario, cliente);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar datos: $e')),
      );
    }

    Navigator.of(context).pop(); // Quitar spinner
    setState(() => isLoading = false);
  }

  Future<bool> _agregarUsuario() async {
    User nuevoUsuario = User(
      usuario: controles['usuario']!.text,
      password: controles['password']!.text,
      idTipoUsuario: "Cliente",
      idPerfil: 2,
    );

    User resultado = await _usuarioRepostitory.insertarUsuario(nuevoUsuario);

    ClienteModel nuevoCliente = ClienteModel(
      apellido: controles['apellido']!.text,
      direccion: controles['direccion']!.text,
      email: controles['email']!.text,
      cedula: controles['cedula']!.text,
      telefono: controles['telefono']!.text,
      idUsuario: resultado.id,
      nombre: controles['nombre']!.text,
    );

    ClienteModel resultadoClienteCreado =
        await _clienteRepostitory.crearCliente(nuevoCliente);

    return resultadoClienteCreado != null;
  }

  List<Widget> camposFormulario() {
    return [
      TextField(controller: controles['nombre'], decoration: const InputDecoration(labelText: 'Nombre')),
      TextField(controller: controles['usuario'], decoration: const InputDecoration(labelText: 'Usuario')),
      TextField(controller: controles['password'], decoration: const InputDecoration(labelText: 'Contraseña')),
      TextField(controller: controles['idTipoUsuario'], decoration: const InputDecoration(labelText: 'Id Tipo Usuario')),
      TextField(controller: controles['idPerfil'], decoration: const InputDecoration(labelText: 'Id Perfil')),
      TextField(controller: controles['apellido'], decoration: const InputDecoration(labelText: 'Apellido')),
      TextField(controller: controles['direccion'], decoration: const InputDecoration(labelText: 'Dirección')),
      TextField(controller: controles['email'], decoration: const InputDecoration(labelText: 'Email')),
      TextField(controller: controles['cedula'], decoration: const InputDecoration(labelText: 'Cédula')),
      TextField(controller: controles['telefono'], decoration: const InputDecoration(labelText: 'Teléfono')),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () async {
          setState(() => isLoading = true);
          mostrarCarga(context);

          bool agregado = await _agregarUsuario();

          Navigator.of(context).pop(); // Quitar spinner
          setState(() => isLoading = false);

          if (agregado) {
            bool valido = await _usuarioRepostitory.validarUsuario(
              controles['usuario']!.text,
              controles['password']!.text,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CatalogoPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al guardar usuario')),
            );
          }
        },
        child: const Text('Guardar Usuario'),
      )
    ];
  }

  @override
  void initState() {
    super.initState();

    if (widget.idUsuario != null) {
      obtenerDatosUsuarioYCliente();
    } else {
      // Si no hay ID, inicializar vacío
      inicializarControles(User(), ClienteModel());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Usuario', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF869E00),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(children: camposFormulario()),
              ),
            ),
    );
  }
}
