import 'package:app_yu_home_front/models/detalle_catalogo_model.dart';

class CatalogosModel {
  int? id;
  String? nombre;
  String? descripcion;
  List<DetalleCatalogoModel>? detalleCatalogoModelList ;

  CatalogosModel({this.id, this.nombre, this.descripcion});

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombre':nombre,
      'descripcion':descripcion
    };
  }

  factory CatalogosModel.fromMap(Map<String, dynamic> map) {
    return CatalogosModel(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion']
    );
  }

  CatalogosModel.fromJson(Map<String, dynamic> json) {
    id = json['ca_id'];
    nombre = json['ca_nombre'];
    descripcion = json['ca_descripcion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ca_id'] = id;
    data['ca_nombre'] = nombre;
    data['ca_descripcion'] = descripcion;
    return data;
  }
}