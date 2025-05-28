import 'dart:convert';

import 'package:app_yu_home_front/models/producto_model.dart';
import 'package:app_yu_home_front/models/producto_variacion_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ProductosRepository {
    String get apiUrl {
    final url = dotenv.env['API_URL'];
    if (url == null) throw Exception("API_URL no encontrada en .env");
    return url;
  }

    /* Acceso API */
  Future<ProductoModel> crearProducto(ProductoModel cliente) async {
    final body = jsonEncode(cliente.toJson());
    final response = await http.post(Uri.parse('${apiUrl}producto'), body: body, headers: {"Content-Type": "application/json"});
    return ProductoModel.fromJson(jsonDecode(response.body));
  }

   Future<ProductoModel> actualizarProducto(ProductoModel producto) async {
    final body =jsonEncode(producto.toJson());
    final response = await http.put(Uri.parse('${apiUrl}producto/${producto.id}'), body: body, headers: {"Content-Type": "application/json"});
    return ProductoModel.fromJson(jsonDecode(response.body));
  }

  Future<List<ProductoModel>> obtenerProducto() async {
    final response = await http.get(Uri.parse('${apiUrl}productos'));
    final List<dynamic> data = jsonDecode(response.body);
    final List<ProductoModel> productos = data.map((item) => ProductoModel.fromJson(item)).toList();
    productos.forEach((item) async{
      item.variaciones = await getVariacion(item.id!);
    });

    return productos;
  }

  Future<ProductoModel> obtenerProductoById(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}productosById/$id'));
    return ProductoModel.fromJson(jsonDecode(response.body));
  }

  Future<ProductoModel> obtenerClienteByUsuario(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}clientesByIdUsuario/$id'));
    return ProductoModel.fromJson(jsonDecode(response.body));
  }

  Future<List<ProductoVariacionModel>> getVariacion(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}variacionByProducto/$id'));
    final List<dynamic> data = jsonDecode(response.body);
    final List<ProductoVariacionModel> productos = data.map((item) => ProductoVariacionModel.fromJson(item)).toList();
    return productos;
  }
}