import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:traductor/result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _future = _requestCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    stopCamera();
    textRecognizer.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff8CAC7E),
        appBar: AppBar(
          title: const Text(
            'Traductor',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xfffA1E783),
          leading: null,
        ),
        drawer: Drawer(
          backgroundColor: Color(0xfff8CAC7E),
          child: ListView(
            children: [
              ListTile(
                title: Text("Historial"),
                onTap: () {
                  Navigator.pushNamed(context, "/history");
                },
              ),
              ListTile(
                title: Text("Traductor"),
                onTap: () {
                  // Navegar a la página de traductor
                },
              ),
              ListTile(
                title: Text("Cerrar sesión"),
                onTap: () {
                  Navigator.pushNamed(context, "/");
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  if (_isGranted)
                    FutureBuilder<List<CameraDescription>>(
                      future: availableCameras(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _initCameraController(snapshot.data!);

                          return Center(
                              child: CameraPreview(_cameraController!));
                        } else {
                          return const LinearProgressIndicator();
                        }
                      },
                    ),
                  Container(
                    child: _isGranted
                        ? Column(
                            children: [
                              Expanded(child: Container()),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: MaterialButton(
                                  color: Color(0xffA1E783),
                                  onPressed: _scan,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: const Text(
                                    "Escanear",
                                    style: TextStyle(fontSize: 40),
                                  ),
                                ),
                              )
                            ],
                          )
                        : const Center(
                            child: Text("Camera of"),
                          ),
                  ),
                ],
              );
            }));
  }

  Future<void> _requestCamera() async {
    final status = await Permission.camera.request();
    _isGranted = status == PermissionStatus.granted;
  }

  void startCamera() {
    if (_cameraController != null) {
      _selectedCamera(_cameraController!.description);
    }
  }

  void stopCamera() {
    if (_cameraController != null) {
      _cameraController!.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    CameraDescription? camera;

    for (var i = 0; 1 < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _selectedCamera(camera);
    }
  }

  Future<void> _selectedCamera(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);

    await _cameraController!.initialize();

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  Future<void> _scan() async {
    if (_cameraController == null) return;

    final navigator = Navigator.of(context);

    try {
      final picture = await _cameraController!.takePicture();

      final file = File(picture.path);

      final inputImage = InputImage.fromFile(file);

      final recognizedText = await textRecognizer.processImage(inputImage);

      await navigator.push(MaterialPageRoute(
        builder: (context) => ResultPage(text: recognizedText.text),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
