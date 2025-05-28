class ClienteModel {
  int? id;
  int? idUsuario;
  String? nombre;
  String? apellido;
  String? direccion;
  String? telefono;
  String? email;
  String? cedula;
  DateTime? fechaCreacion;
  DateTime? fechaModificacion;
  int? idUsuarioModificacion;

  ClienteModel({
    this.id,
    this.idUsuario,
    this.nombre,
    this.apellido,
    this.direccion,
    this.telefono,
    this.email,
    this.cedula,
    this.fechaCreacion,
    this.fechaModificacion,
    this.idUsuarioModificacion
    });

    Map<String, dynamic> toMap(){
      return {
        'id':id,
        'idUsuario':idUsuario,
        'nombre':nombre,
        'apellido':apellido,
        'direccion':direccion,
        'telefono':telefono,
        'email':email,
        'cedula':cedula,
        'fechaCreacion':fechaCreacion,
        'fechaModificacion':fechaModificacion,
        'idUsuarioModificacion':idUsuarioModificacion
      };
    }

    factory ClienteModel.fromMap(Map<String, dynamic> map) => ClienteModel(
      id: map['id'],
      idUsuario: map['idUsuario'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      direccion: map['direccion'],
      telefono: map['telefono'],
      email: map['email'],
      cedula: map['cedula'],
      fechaCreacion: map['fechaCreacion'],
      fechaModificacion: map['fechaModificacion'],
      idUsuarioModificacion: map['idUsuarioModificacion']
    );

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
    id: json['cl_id'],
    idUsuario: json['cl_id_usuario'],
    nombre: json['cl_nombre'],
    apellido: json['cl_apellido'],
    direccion: json['cl_direccion'],
    telefono: json['cl_telefono'],
    email: json['cl_email'],
    cedula: json['cl_cedula'],
    fechaCreacion: json['cl_fecha_creacion'],
    fechaModificacion: json['cl_fecha_modificacion'],
    idUsuarioModificacion: json['cl_id_usuario_modificacion']
  );

  Map<String, dynamic> toJson() => {
    'cl_id': id,
    'cl_id_usuario': idUsuario,
    'cl_nombre': nombre,
    'cl_apellido': apellido,
    'cl_direccion': direccion,
    'cl_telefono': telefono,
    'cl_email': email,
    'cl_cedula': cedula,
    'cl_fecha_creacion': fechaCreacion,
    'cl_fecha_modificacion': fechaModificacion,
    'cl_id_usuario_modificacion': idUsuarioModificacion
  };
}