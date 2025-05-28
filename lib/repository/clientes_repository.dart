import 'dart:convert';

import 'package:app_yu_home_front/models/cliente_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ClientesRepository {

  String get apiUrl {
    final url = dotenv.env['API_URL'];
    if (url == null) throw Exception("API_URL no encontrada en .env");
    return url;
  }

  /* Acceso API */
  Future<ClienteModel> crearCliente(ClienteModel cliente) async {
    final body =jsonEncode(cliente.toJson());
    final response = await http.post(Uri.parse('${apiUrl}clientes'), body: body, headers: {"Content-Type": "application/json"});
    return ClienteModel.fromJson(jsonDecode(response.body));
  }

   Future<ClienteModel> actualizarCliente(ClienteModel cliente) async {
    final body = jsonEncode(cliente.toJson());
    final response = await http.put(Uri.parse('${apiUrl}clientes/${cliente.id}'), body: body, headers: {"Content-Type": "application/json"});
    return ClienteModel.fromJson(jsonDecode(response.body));
  }

  Future<ClienteModel> obtenerCliente(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}clientes/$id'));
    return ClienteModel.fromJson(jsonDecode(response.body));
  }

  Future<ClienteModel> obtenerClienteByUsuario(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}clientesByIdUsuario/$id'));
    return ClienteModel.fromJson(jsonDecode(response.body));
  }

  Future<void> eliminarUsuario(int id) async {
    await http.delete(Uri.parse('${apiUrl}clientes/$id'));
  }
}