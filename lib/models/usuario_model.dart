class User {
  int? id;
  String usuario;
  String password;

  User({this.id, required this.usuario, required this.password});

  //Mapea usuario
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'usuario':usuario,
      'pass':password
    };
  }

  //Usuario desde Map
  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map['id'],
      usuario: map['usuario'],
      password: map['pass']
    );
  }
}