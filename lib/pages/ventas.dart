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
  @override
  void initState() {
    super.initState();
    _productosFuture = obtenerDetalleVenta(1);
  }

  VentasRepository ventasRepository = VentasRepository();
  ProductosRepository productosRepository = ProductosRepository();
  UserRepository usuarioRepository = UserRepository();

  late Future<List<ProductoModel>> _productosFuture;

  Future<List<ProductoModel>> obtenerDetalleVenta(int idVenta) async {
    final List<ProductoModel> productos = [];
    int idCliente = await usuarioRepository.obtenerIdClienteLocal();
    final venta = await ventasRepository.obtenerVentaByCliente(idCliente);

    if (venta.detalles != null) {
      for (var item in venta.detalles!) {
        ProductoModel producto = await productosRepository.obtenerProductoById(item.idProducto!);
        productos.add(producto);
      }
    }

    return productos;
  }

  

  @override
  Widget build(BuildContext context) {
    final Color verdeOliva = const Color(0xFF6B7B3B);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Pagar', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF869E00),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder<List<ProductoModel>>(
        future: _productosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar productos: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos para mostrar'));
          }

          final productos = snapshot.data!;
          final double total = productos.fold(
            0.0,
            (sum, item) => sum +
                ((item.variaciones != null && item.variaciones!.isNotEmpty)
                    ? item.variaciones!.first.precio ?? 0.0
                    : 0.0),
          );

          return Column(
            children: [
              // Lista de productos
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.image, size: 48, color: Color.fromARGB(185, 185, 184, 184)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              producto.nombre ?? '',
                              style: TextStyle(color: verdeOliva, fontSize: 16),
                            ),
                          ),
                          Text(
                            '\$${(producto.variaciones != null && producto.variaciones!.isNotEmpty) 
                                  ? producto.variaciones!.first.precio?.toStringAsFixed(2) 
                                  : '0.00'}',
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
                    Text('\$${total.toStringAsFixed(2)}', style: TextStyle(color: verdeOliva, fontSize: 18, fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
          );
        },
      ),
    );
  }
}

