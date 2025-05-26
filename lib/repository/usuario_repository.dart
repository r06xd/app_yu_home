import 'dart:convert';

import 'package:app_yu_home_front/database/database_helper.dart';
import 'package:app_yu_home_front/models/usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class UserRepository{

  final String apiUrl = 'https://app-store-shoes.onrender.com/api/usuarios';//'http://192.168.100.13:3000/api/usuarios';

  Future<int> insertarUsuario(User usuario) async {
    final db = await DatabaseHelper.getDatabase();
    await db.insert(
      'usuarios', 
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
      );

      final body = jsonEncode({
      "us_nombre": usuario.usuario,
      "us_password": usuario.password,
      "us_tipo_usuario": "Cliente",
      "us_id_perfil": 2
    });

    final response = await http.post(Uri.parse(apiUrl), body: body, headers: {"Content-Type": "application/json"});

    return response.statusCode;
    
  }

  Future<List<User>> obtenerUsuarios() async {
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('usuarios');

    return List.generate(maps.length, (i){
      return User.fromMap(maps[i]);
    });
  }

  Future<void> actualizarUsuario(User usuario) async {
    final db= await DatabaseHelper.getDatabase();
    await db.update('usuarios',
    usuario.toMap(),
    where: 'id=?',whereArgs: [usuario.id]
    );
  }

  Future<void> eliminarUsuario(int id) async {
    final db = await DatabaseHelper.getDatabase();
    await db.delete('usuarios',where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> validarUsuario(String usuario, String pass) async {
    final db = await DatabaseHelper.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'usuarios',
      where: 'usuario = ? and pass = ?',
      whereArgs: [usuario,pass]
    );
    return maps.isNotEmpty;
  }
}