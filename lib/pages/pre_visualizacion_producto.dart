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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Previsualizacion de producto')),
      body: _isInitialized
          ? CameraPreview(_controller!)
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          if (!_controller!.value.isTakingPicture) {
            final image = await _controller!.takePicture();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Foto guardada: ${image.path}')),
            );
          }
        },
      ),
    );
  }
}
