import 'package:app_yu_home_front/pages/pre_visualizacion_producto.dart';
import 'package:app_yu_home_front/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_yu_home_front/models/producto_model.dart';
import 'package:app_yu_home_front/models/producto_variacion_model.dart';

class DetalleProductoPage extends StatelessWidget {
  final ProductoModel producto;

  DetalleProductoPage({required this.producto});

  @override
  Widget build(BuildContext context) {
    final List<ProductoVariacionModel> variaciones = producto.variaciones ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto Detallado', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color(0xFF869E00), 
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,),
        drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: NetworkImage('https://picsum.photos/id/${producto.id}/200/300'), width: 400, height: 400,),
            Text(
              producto.descripcion ?? 'Sin descripción',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Variaciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: variaciones.length,
                itemBuilder: (context, index) {
                  final varItem = variaciones[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Color: ${varItem.color} | Talla: ${varItem.talla}',
                      ),
                      subtitle: Text(
                        'Stock: ${varItem.stock}, Precio: \$${varItem.precio?.toStringAsFixed(2)}',
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text("Visualizar en Realidad Aumentada"),
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => PreVisualizacionProducto(),));},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
