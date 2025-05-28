class DetalleCatalogoModel {
  int? id;
  String? nombre;
  String? descripcion;
  int? idCatalogo;
  
  DetalleCatalogoModel({this.id, this.nombre, this.descripcion, this.idCatalogo});

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'nombre':nombre,
      'descripcion':descripcion,
      'idCatalogo':idCatalogo
    };
  }

  factory DetalleCatalogoModel.fromMap(Map<String, dynamic> map) {
    return DetalleCatalogoModel(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      idCatalogo: map['idCatalogo']
    );
  }

  DetalleCatalogoModel.fromJson(Map<String, dynamic> json) {
    id = json['dc_id'];
    nombre = json['dc_nombre'];
    descripcion = json['dc_descripcion'];
    idCatalogo = json['dc_id_catalogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dc_id'] = id;
    data['dc_nombre'] = nombre;
    data['dc_descripcion'] = descripcion;
    data['dc_id_catalogo'] = idCatalogo;
    return data;
  }
}