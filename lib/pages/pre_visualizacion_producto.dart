import 'package:app_yu_home_front/models/cliente_model.dart';
import 'package:app_yu_home_front/models/venta_model.dart';
import 'package:app_yu_home_front/pages/detalle_producto_page.dart';
import 'package:app_yu_home_front/repository/clientes_repository.dart';
import 'package:app_yu_home_front/repository/usuario_repository.dart';
import 'package:app_yu_home_front/repository/ventas_repository.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PreVisualizacionProducto extends StatefulWidget {
  const PreVisualizacionProducto({Key? key}) : super(key: key);

  @override
  State<PreVisualizacionProducto> createState() => _PreVisualizacionProducto();
}

class _PreVisualizacionProducto extends State<PreVisualizacionProducto> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras![0], // Usa la cámara trasera
      ResolutionPreset.medium,
    );

    await _controller!.initialize();
    setState(() {
      _isInitialized = true;
    });
  }

  // Future<void> crearVenta()async{
  //   VentasRepository ventasRepository = new VentasRepository();
  //   UserRepository usuarioRepository = new UserRepository();
  //   ClientesRepository clientesRepository = new ClientesRepository();
  //   int idClienteLocal = await usuarioRepository.obtenerIdClienteLocal();
  //   VentaModel venta = await ventasRepository.obtenerVentaByCliente(id);
    
  //   if(venta==null){
  //     int idUsuarioLocal = await usuarioRepository.obtenerIdUsuariolocal();
  //     ClienteModel cliente = await clientesRepository.obtenerClienteByUsuario(idUsuarioLocal);
  //     VentaModel newVenta = new VentaModel();
  //     newVenta.idCliente = idClienteLocal;
  //     newVenta.direccion = cliente.direccion!;
  //     newVenta.idTipoPago = 1;
  //     newVenta.estado="INC";

  //     VentaModel newVentaCreada = await ventasRepository.crearVenta(newVenta);
  //     if(newVentaCreada !=null){
  //       DetalleVentasModel detalle = new DetalleVentasModel();
  //       detalle.idVenta = newVentaCreada.id!;
  //       detalle.idProducto = 1;
  //       await ventasRepository.crearDetalleVenta(detalle);
  //     }
  //     }

  // }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Previsualizacion de producto')),
      body:Center(
        child: Column(
          children: [
           Row( 
            children: [
             IconButton(onPressed:(){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Articulo guardado.')),
              );
             }, icon: Icon(Icons.shopping_cart,)),
             SizedBox(width: 10,),
             IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,)),
           ]),
             _isInitialized
          ? CameraPreview(_controller!)
          : const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.camera),
      //   onPressed: () async {
      //     if (!_controller!.value.isTakingPicture) {
      //       final image = await _controller!.takePicture();
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Foto guardada: ${image.path}')),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
