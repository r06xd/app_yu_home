import 'dart:convert';

import 'package:app_yu_home_front/models/detalle_catalogo_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DetalleCatalogoRepository {
    String get apiUrl {
    final url = dotenv.env['API_URL'];
    if (url == null) throw Exception("API_URL no encontrada en .env");
    return url;
  }

    Future<List<DetalleCatalogoModel>> getDetalleCatalogos() async {
    final response = await http.get(Uri.parse('${apiUrl}catalogos/detalleCatalogoByCatalogo'));
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => DetalleCatalogoModel.fromJson(item)).toList();
  }

  Future<List<DetalleCatalogoModel>> getDetalleCatalogosByCatalogo(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}catalogos/detalleCatalogoByCatalogo/$id'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => DetalleCatalogoModel.fromJson(item)).toList();
  }
}