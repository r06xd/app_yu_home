import 'package:app_yu_home_front/pages/catalogo_page.dart';
import 'package:app_yu_home_front/pages/home.dart';
import 'package:app_yu_home_front/pages/login.dart';
import 'package:app_yu_home_front/pages/perfil.dart';
import 'package:app_yu_home_front/pages/seguimiento_compra.dart';
import 'package:app_yu_home_front/pages/ventas.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF869E00)),
            child: Text('Menú', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 20 ),textAlign: TextAlign.center,),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CatalogoPage(),));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.shopping_cart),
          //   title: Text('Compras'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => CatalogoPage(),));
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.payments_outlined),
            title: Text('Pagar'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VentasPage(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('Ubicacion Pedido'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SeguimientoCompra(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Salir'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Login(),));
            },
          ),
        ],
      ),
    );
  }
}
