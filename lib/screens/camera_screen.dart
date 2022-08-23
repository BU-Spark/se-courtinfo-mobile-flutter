import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scdao_mobile/screens/displayphotos_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.camera});
  static const routeName = "camera";

  final CameraDescription camera;
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> _initControllerFuture;
  bool showFocusCircle = false;
  double xTap = 0;
  double yTap = 0;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );

    _initControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final iconSize = queryData.size.width * 0.16;

    Future<void> _onTap(TapUpDetails details) async {
      if (_cameraController.value.isInitialized) {
        showFocusCircle = true;
        xTap = details.localPosition.dx;
        yTap = details.localPosition.dy;

        double fullWidth = queryData.size.width;
        double cameraHeight = fullWidth * _cameraController.value.aspectRatio;
        Offset point = Offset(xTap / fullWidth, yTap / cameraHeight);
        await _cameraController.setFocusPoint(point);

        setState(() {
          Future.delayed(const Duration(seconds: 2)).whenComplete(() {
            setState(() {
              showFocusCircle = false;
            });
          });
        });
      }
    }

    Widget _cameraPreview() {
      return AspectRatio(
          aspectRatio: _cameraController.value.aspectRatio,
          child: GestureDetector(
            onTapUp: (details) => _onTap(details),
            child: Stack(
              children: [
                Container(
                    width: queryData.size.width,
                    child: CameraPreview(_cameraController)),
                if (showFocusCircle)
                  Positioned(
                    top: yTap - 40,
                    left: xTap - 40,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ));
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                child: FutureBuilder<void>(
                  future: _initControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _cameraPreview();
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        padding: const EdgeInsets.all(0),
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: iconSize / 2,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: IconButton(
                        onPressed: _onPressedCapture,
                        padding: const EdgeInsets.all(0),
                        icon: Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: IconButton(
                        onPressed: () => print("photos"),
                        padding: const EdgeInsets.all(0),
                        icon: Icon(
                          Icons.panorama,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onPressedCapture() async {
    try {
      // Ensure that the camera is initialized.
      await _initControllerFuture;
      if (mounted) {
        final image = await _cameraController.takePicture();
        Navigator.pushNamed(
          context,
          DisplayPhotoScreen.routeName,
          arguments: DisplayPhotoArgs(image.path),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
