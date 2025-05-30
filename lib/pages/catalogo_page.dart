import 'package:app_yu_home_front/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_yu_home_front/models/producto_model.dart';
import 'package:app_yu_home_front/repository/productos_repository.dart';
import 'detalle_producto_page.dart';

class CatalogoPage extends StatefulWidget {
  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  final ProductosRepository _productosRepository = ProductosRepository();
  late Future<List<ProductoModel>> _productos;

  @override
  void initState() {
    super.initState();
    _productos = _productosRepository.obtenerProducto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogos de Productos', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color(0xFF869E00), 
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,),
        drawer: const CustomDrawer(),
      body: FutureBuilder<List<ProductoModel>>(
        future: _productos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));

          final productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return ListTile(
                leading: Image(
                  image:  NetworkImage('https://picsum.photos/id/${index + 1}/200/300'),
                  width: 40,
                  height: 40,
                  ),
                // Icon(
                //   Icons.image,
                //   size: 40,
                // ), // Puedes usar NetworkImage si tienes URL de imagen
                title: Text(producto.nombre ?? 'Sin nombre'),
                subtitle: Text(producto.descripcion ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalleProductoPage(producto: producto),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
