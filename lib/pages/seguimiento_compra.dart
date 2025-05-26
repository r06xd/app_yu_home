import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SeguimientoCompra extends StatefulWidget {
  const SeguimientoCompra({super.key});

  @override
  State<SeguimientoCompra> createState() => __SeguimientoCompra();
}

class __SeguimientoCompra extends State<SeguimientoCompra> {
  GoogleMapController? mapController;
  LatLng _center = const LatLng(-2.170998, -79.922359); // Ejemplo: Guayaquil
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final locData = await location.getLocation();
    setState(() {
      _center = LatLng(locData.latitude!, locData.longitude!);
    });

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_center, 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa')),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
