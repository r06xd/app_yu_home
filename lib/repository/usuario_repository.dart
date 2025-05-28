import 'dart:convert';

import 'package:app_yu_home_front/database/database_helper.dart';
import 'package:app_yu_home_front/models/cliente_model.dart';
import 'package:app_yu_home_front/models/usuario_model.dart';
import 'package:app_yu_home_front/repository/clientes_repository.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserRepository{

  //final String apiUrl = 'https://app-store-shoes.onrender.com/api/usuarios';//'http://192.168.100.13:3000/api/usuarios';

  String get apiUrl {
    final url = dotenv.env['API_URL'];
    if (url == null) throw Exception("API_URL no encontrada en .env");
    return url;
  }

  Future<User> insertarUsuario(User usuario) async {
    final body = jsonEncode(usuario.toJson());
    final response = await http.post(Uri.parse('${apiUrl}usuarios'), body: body, headers: {"Content-Type": "application/json"});
    // final db = await DatabaseHelper.getDatabase();
    //     await db.insert(
    //       'usuarios', 
    //       usuario.toMap(),
    //       conflictAlgorithm: ConflictAlgorithm.replace
    //       );

    return User.fromJson(jsonDecode(response.body));
  }

  Future<List<User>> obtenerUsuarios() async {
    // final db = await DatabaseHelper.getDatabase();
    // final List<Map<String, dynamic>> maps = await db.query('usuarios');

    // return List.generate(maps.length, (i){
    //   return User.fromMap(maps[i]);
    // });

    final response = await http.get(Uri.parse('${apiUrl}usuarios'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => User.fromJson(item)).toList();
  }

  Future<User> actualizarUsuario(User usuario) async {
    // final db= await DatabaseHelper.getDatabase();
    // await db.update('usuarios',
    // usuario.toMap(),
    // where: 'id=?',whereArgs: [usuario.id]
    // );
    final body = jsonEncode(usuario.toJson());
    final response = await http.put(Uri.parse('${apiUrl}usuarios/${usuario.id}'), body: body, headers: {"Content-Type": "application/json"});
    return User.fromJson(jsonDecode(response.body));
  }

  Future<void> eliminarUsuario(int id) async {
    // final db = await DatabaseHelper.getDatabase();
    // await db.delete('usuarios',where: 'id = ?', whereArgs: [id]);

    await http.delete(Uri.parse('${apiUrl}usuarios/$id'));
  }

  Future<bool> validarUsuario(String usuario, String pass) async {
  //   final db = await DatabaseHelper.getDatabase();
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'usuarios',
  //     where: 'usuario = ? and pass = ?',
  //     whereArgs: [usuario,pass]
  //   );
  //   return maps.isNotEmpty;
  // }

  final response = await http.get(Uri.parse('${apiUrl}usuarios'));
  final List<dynamic> data = jsonDecode(response.body);
  final List<User> usuarios = data.map((item) => User.fromJson(item)).toList();
  if( usuarios.any((user) => user.usuario == usuario && user.password == pass))
  {
    User usuarioEncontrado = usuarios.firstWhere((user) => user.usuario == usuario && user.password == pass);
    insertarUsuarioLocal(usuarioEncontrado);
    return true;
  }
  return false;
  }

  Future<void> insertarUsuarioLocal(User usuario)async{
    ClientesRepository clientesRepository = ClientesRepository();
    final ClienteModel cliente = await clientesRepository.obtenerClienteByUsuario(usuario.id!);
       final db = await DatabaseHelper.getDatabase();
         await db.insert(
          'usuarios', 
           {'idUsuario': usuario.id, 'idCliente': cliente.id},
           conflictAlgorithm: ConflictAlgorithm.replace
           );
  }

  Future<int> obtenerIdClienteLocal()async{
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return maps[0]['idCliente'];
  }
  Future<int> obtenerIdUsuariolocal()async{
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return maps[0]['idUsuario'];
  }
}