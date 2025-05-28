class ProductoVariacionModel {
  int? id;
  int? idProducto;
  String? color;
  String? talla;
  String? stock;
  double? precio;

  ProductoVariacionModel({this.id, this.idProducto, this.color, this.talla, this.stock, this.precio});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idProducto': idProducto,
      'color': color,
      'talla': talla,
      'stock': stock,
      'precio': precio,
    };
  }

  factory ProductoVariacionModel.fromMap(Map<String, dynamic> map) {
    return ProductoVariacionModel(
      id: map['id'],
      idProducto: map['idProducto'],
      color: map['color'],
      talla: map['talla'],
      stock: map['stock'],
      precio: map['precio'],
    );
  }

  ProductoVariacionModel.fromJson(Map<String, dynamic> json) {
    id = json['pv_id'];
    idProducto = json['pv_id_producto'];
    color = json['pv_color'];
    talla = json['pv_talla'];
    stock = json['pv_stock'];
    precio = json['pv_precio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pv_id'] = id;
    data['pv_id_producto'] = idProducto;
    data['pv_color'] = color;
    data['pv_talla'] = talla;
    data['pv_stock'] = stock;
    data['pv_precio'] = precio;
    return data;
  }
}