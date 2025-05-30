class VentaModel {
  int? id;
  int? idCliente;
  DateTime? fecha;
  String? totalVentas;
  String? factura;
  String? direccion;
  String? estado;
  int? idTipoPago;
  String? fechaCreacion;
  String? fechaModificacion;
  int? idUsuarioModificacion;
  List<DetalleVentasModel>? detalles;

  VentaModel({
    this.id,
    this.idCliente,
    this.fecha,
    this.totalVentas,
    this.factura,
    this.direccion,
    this.estado,
    this.idTipoPago,
    this.fechaCreacion,
    this.fechaModificacion,
    this.idUsuarioModificacion,
    this.detalles});

    Map<String, dynamic> toMap(){
      return{
        'id':id,
        'idCliente':idCliente,
        'fecha':fecha,
        'totalVentas':totalVentas,
        'factura':factura,
        'direccion':direccion,
        'estado':estado,
        'idTipoPago':idTipoPago,
        'fechaCreacion':fechaCreacion,
        'fechaModificacion':fechaModificacion,
        'idUsuarioModificacion':idUsuarioModificacion
      };
    }

    factory VentaModel.fromMap(Map<String, dynamic> json) => new VentaModel(
      id: json["id"],
      idCliente: json["idCliente"],
      fecha: json["fecha"],
      totalVentas: json["totalVentas"],
      factura: json["factura"],
      direccion: json["direccion"],
      estado: json["estado"],
      idTipoPago: json["idTipoPago"],
      fechaCreacion: json["fechaCreacion"],
      fechaModificacion: json["fechaModificacion"],
      idUsuarioModificacion: json["idUsuarioModificacion"],
    );

    VentaModel.fromJson(Map<String, dynamic> json) {
      id = json['ev_id'];
      idCliente = json['ev_id_cliente'];
      fecha = json['ev_fecha'];
      totalVentas = json['ev_total_venta'];
      factura = json['ev_factura'];
      direccion = json['ev_direccion'];
      estado = json['ev_estado_compra'];
      idTipoPago = json['ev_id_catalogo_tipo_pago'];
      fechaCreacion = json['ev_fecha_creacion'];
      fechaModificacion = json['ev_fecha_modificacion'];
      idUsuarioModificacion = json['ev_id_usuario'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['ev_id'] = this.id;
      data['ev_id_cliente'] = this.idCliente;
      data['ev_fecha'] = this.fecha;
      data['ev_total_venta'] = this.totalVentas;
      data['ev_factura'] = this.factura;
      data['ev_direccion'] = this.direccion;
      data['ev_estado_compra'] = this.estado;
      data['ev_id_catalogo_tipo_pago'] = this.idTipoPago;
      data['ev_fecha_creacion'] = this.fechaCreacion;
      data['ev_fecha_modificacion'] = this.fechaModificacion;
      data['ev_id_usuario'] = this.idUsuarioModificacion;
      return data;
    }

}
class DetalleVentasModel {
  int? id;
  int? idProducto;
  int? idVenta;
  String? fechaCreacion;
  String? fechaModificacion;
  int? idUsuarioModificacion;

  DetalleVentasModel({this.id, this.idProducto, this.idVenta, this.fechaCreacion, this.fechaModificacion, this.idUsuarioModificacion});

  DetalleVentasModel.fromJson(Map<String, dynamic> json) {
    id = json['dvp_id'];
    idProducto = json['dvp_id_producto'];
    idVenta = json['dvp_id_encabezado_venta'];
    fechaCreacion = json['dvp_fecha_creacion'];
    fechaModificacion = json['dvp_fecha_modificacion'];
    idUsuarioModificacion = json['dvp_id_usuario_modificacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dvp_id'] = this.id;
    data['dvp_id_producto'] = this.idProducto;
    data['dvp_id_encabezado_venta'] = this.idVenta;
    data['dvp_fecha_creacion'] = this.fechaCreacion;
    data['dvp_fecha_modificacion'] = this.fechaModificacion;
    data['dvp_id_usuario_modificacion'] = this.idUsuarioModificacion;
    return data;
  }
}