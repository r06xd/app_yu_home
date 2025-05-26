import 'package:app_yu_home_front/pages/pre_visualizacion_producto.dart';
import 'package:app_yu_home_front/pages/seguimiento_compra.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PreVisualizacionProducto(),)), child: const Text('Camara'),),
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SeguimientoCompra(),)), child: const Text('Mapa'),),
          ],),
      ),
    );
  }
}