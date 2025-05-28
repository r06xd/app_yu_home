import 'dart:convert';

import 'package:app_yu_home_front/models/venta_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VentasRepository {

   String get apiUrl {
    final url = dotenv.env['API_URL'];
    if (url == null) throw Exception("API_URL no encontrada en .env");
    return url;
  }
  
  /* Acceso API */
  Future<VentaModel> crearVenta(VentaModel venta) async {
    final body =jsonEncode(venta.toJson());
    final response = await http.post(Uri.parse('${apiUrl}ventas/encabezadoVentas'), body: body, headers: {"Content-Type": "application/json"});
    
    venta.detalles?.forEach((item) async{
      await crearDetalleVenta(item);
    });
    
    return VentaModel.fromJson(jsonDecode(response.body));
  }

   Future<VentaModel> actualizarVenta(VentaModel venta) async {
    final body = jsonEncode(venta.toJson());
    final response = await http.put(Uri.parse('${apiUrl}ventas/${venta.id}'), body: body, headers: {"Content-Type": "application/json"});
    return VentaModel.fromJson(jsonDecode(response.body));
  }

  Future<List<VentaModel>> obtenerVenta() async {
    final response = await http.get(Uri.parse('${apiUrl}ventas'));
    final List<dynamic> data = jsonDecode(response.body);
    List<VentaModel> ventas = data.map((item) => VentaModel.fromJson(item)).toList();
    ventas.forEach((item)async{
      item.detalles = await obtenerDetalleVentaByVenta(item.id!);
    });
    return ventas;
  }

  Future<VentaModel> obtenerVentaByCliente(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}ventas/ventasByCliente/$id'));
    VentaModel venta = VentaModel.fromJson(jsonDecode(response.body));
    venta.detalles = await obtenerDetalleVentaByVenta(venta.id!);
    return venta;
  }

  Future<void> eliminarVenta(int id) async {
    await http.delete(Uri.parse('${apiUrl}ventas/$id'));
  }

  Future<DetalleVentasModel> crearDetalleVenta(DetalleVentasModel detalle) async{
    final body = jsonEncode(detalle.toJson());
    final response = await http.post(Uri.parse('${apiUrl}ventas/detalleVentas'), body: body, headers: {"Content-Type": "application/json"});
    return DetalleVentasModel.fromJson(jsonDecode(response.body));
  }

  Future<DetalleVentasModel> actualizarDetalleVenta(DetalleVentasModel detalle) async{
    final body = jsonEncode(detalle.toJson());
    final response = await http.put(Uri.parse('${apiUrl}ventas/detalleVentas'), body: body, headers: {"Content-Type": "application/json"});
    return DetalleVentasModel.fromJson(jsonDecode(response.body));
  }

  Future<List<DetalleVentasModel>> obtenerDetalleVenta() async{
    final response = await http.get(Uri.parse('${apiUrl}ventas/detalleVentas'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => DetalleVentasModel.fromJson(item)).toList();
  }

  Future<DetalleVentasModel> obtenerDetalleVentaById(int id) async{
    final response = await http.get(Uri.parse('${apiUrl}ventas/detalleVentasById/$id'));
    return DetalleVentasModel.fromJson(jsonDecode(response.body));
  }

  Future<List<DetalleVentasModel>> obtenerDetalleVentaByVenta(int id) async{
    final response = await http.get(Uri.parse('${apiUrl}ventas/detalleVentasByIdVentas/$id'));
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => DetalleVentasModel.fromJson(item)).toList();
  }
}