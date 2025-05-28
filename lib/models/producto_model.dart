import 'package:app_yu_home_front/models/producto_variacion_model.dart';

class ProductoModel {
  int? id;
  String? nombre;
  String? descripcion;
  int? modelo;
  String? codigoNegocio;
  int? tipoProducto;
  int? tematica;
  List<ProductoVariacionModel>? variaciones;

  ProductoModel({this.id, this.nombre, this.descripcion, this.modelo, this.codigoNegocio, this.tipoProducto, this.tematica, this.variaciones});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'modelo': modelo,
      'codigoNegocio': codigoNegocio,
      'tipoProducto': tipoProducto,
      'tematica': tematica,
    };
  }

  factory ProductoModel.fromMap(Map<String, dynamic> map) {
    return ProductoModel(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      modelo: map['modelo'],
      codigoNegocio: map['codigoNegocio'],
      tipoProducto: map['tipoProducto'],
      tematica: map['tematica'],
    );
  }

  ProductoModel.fromJson(Map<String, dynamic> json) {
    id = json['pr_id'];
    nombre = json['pr_nombre'];
    descripcion = json['pr_description'];
    modelo = json['pr_id_catalogo_modelo'];
    codigoNegocio = json['pr_codigo_negocio'];
    tipoProducto = json['pr_id_catalogo_tipo_producto'];
    tematica = json['pr_id_catalogo_tematica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pr_id'] = id;
    data['pr_nombre'] = nombre;
    data['pr_description'] = descripcion;
    data['pr_id_catalogo_modelo'] = modelo;
    data['pr_codigo_negocio'] = codigoNegocio;
    data['pr_id_catalogo_tipo_producto'] = tipoProducto;
    data['pr_id_catalogo_tematica'] = tematica;
    return data;
  }
}