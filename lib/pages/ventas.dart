import 'package:app_yu_home_front/models/producto_model.dart';
import 'package:app_yu_home_front/repository/productos_repository.dart';
import 'package:app_yu_home_front/repository/usuario_repository.dart';
import 'package:app_yu_home_front/repository/ventas_repository.dart';
import 'package:app_yu_home_front/widgets/drawer.dart';
import 'package:flutter/material.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({super.key});

  @override
  State<VentasPage> createState() => _VentasPage();
}

class _VentasPage extends State<VentasPage> {
  VentasRepository ventasRepository = VentasRepository();
  ProductosRepository productosRepository = ProductosRepository();
  UserRepository usuarioRepository = UserRepository();
  final List<ProductoModel> productos = [
    // {
    //   'nombre': 'Nombre Producto',
    //   'precio': 10,
    //   'imagen': Icons.image, // Usar NetworkImage o AssetImage si tienes imágenes reales
    // },
    // {
    //   'nombre': 'Nombre Producto',
    //   'precio': 10,
    //   'imagen': Icons.image,
    // },
    // {
    //   'nombre': 'Nombre Producto',
    //   'precio': 10,
    //   'imagen': Icons.image,
    // },
  ];

  Future<void> obtenerDetalleVenta(int idVenta) async {
    int idCliente = await usuarioRepository.obtenerIdClienteLocal();
    final venta = await ventasRepository.obtenerVentaByCliente(idCliente);
    venta.detalles?.forEach((item) async {
      productos.add(await productosRepository.obtenerProductoById(item.idProducto!));
    });
  } 

  @override
  Widget build(BuildContext context){
    final Color verdeOliva = Color(0xFF6B7B3B);
    final double total = productos.fold(0, (sum, item) => sum + item.variaciones![0].precio!);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pagar', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color(0xFF869E00), 
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,),
        drawer: const CustomDrawer(),
      body: Column(
        children: [
          // Lista de productos
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.image, size: 48, color: Colors.black54),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          producto.nombre.toString(),
                          style: TextStyle(color: verdeOliva, fontSize: 16),
                        ),
                      ),
                      Text(
                        '\$${ producto.variaciones![0].precio!}',
                        style: TextStyle(color: verdeOliva, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Total
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(color: verdeOliva, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$${total.toStringAsFixed(0)}', style: TextStyle(color: verdeOliva, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // Botón Pagar
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.grey.shade400,
                elevation: 8,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Pagar',
                style: TextStyle(color: verdeOliva, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
