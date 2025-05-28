import 'dart:convert';

import 'package:app_yu_home_front/models/catalogos_model.dart';
import 'package:app_yu_home_front/models/detalle_catalogo_model.dart';
import 'package:app_yu_home_front/repository/detalle_catalogo_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CatalogoRepository {

  String get apiUrl {
    final url = dotenv.env['API_URL'];
    if (url == null) throw Exception("API_URL no encontrada en .env");
    return url;
  }
  
  Future<List<CatalogosModel>> getCatalogos() async {
    DetalleCatalogoRepository detalleCatalogoRepository = DetalleCatalogoRepository();
    final response = await http.get(Uri.parse('${apiUrl}catalogos'));
    final List<dynamic> data = jsonDecode(response.body);
    List<CatalogosModel> catalogos = data.map((item) => CatalogosModel.fromJson(item)).toList();
    catalogos.forEach((item) async {
      List<DetalleCatalogoModel> detalle = await detalleCatalogoRepository.getDetalleCatalogosByCatalogo(item.id!);
      item.detalleCatalogoModelList = detalle;
    });

    return catalogos;
  }

  Future<CatalogosModel> getCatalogosById(int id) async {
    DetalleCatalogoRepository detalleCatalogoRepository = DetalleCatalogoRepository();
    final response = await http.get(Uri.parse('${apiUrl}catalogoById/$id'));
    CatalogosModel datos = CatalogosModel.fromJson(jsonDecode(response.body));
    List<DetalleCatalogoModel> detalle = await detalleCatalogoRepository.getDetalleCatalogosByCatalogo(datos.id!);
    datos.detalleCatalogoModelList = detalle;
    return datos;
  }
}