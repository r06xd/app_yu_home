class User {
  int? id;
  String? usuario;
  String? password;
  String? idTipoUsuario;
  int? idPerfil;

  User({this.id, this.usuario, this.password, this.idTipoUsuario, this.idPerfil});

  //Mapea usuario
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'usuario':usuario,
      'password':password,
      'idTipoUsuario':idTipoUsuario,
      'idPerfil':idPerfil
    };
  }

  //Usuario desde Map
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['id'],
      usuario: map['usuario'],
      password: map['pass'],
      idTipoUsuario: map['idTipoUsuario'],
      idPerfil: map['idPerfil']
    );
  }

  User.fromJson(Map<String, dynamic> json) {
    id = json['us_id'];
    usuario = json['us_nombre'];
    password = json['us_password'];
    idTipoUsuario = json['us_tipo_usuario'];
    idPerfil = json['us_id_perfil'];
  }

  Map<String, dynamic> toJson() => {
    'us_id': id,
    'us_nombre': usuario,
    'us_password': password,
    'us_tipo_usuario': idTipoUsuario,
    'us_id_perfil': idPerfil,};
}