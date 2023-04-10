import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:reflective_button/camera_button.dart';

class ReflectiveNeumorphicButton extends StatefulWidget {
  const ReflectiveNeumorphicButton({Key? key, required this.camera})
      : super(key: key);
  final CameraDescription? camera;

  @override
  State<ReflectiveNeumorphicButton> createState() =>
      _ReflectiveNeumorphicButtonState();
}

class _ReflectiveNeumorphicButtonState extends State<ReflectiveNeumorphicButton>
    with TickerProviderStateMixin {
  CameraController? _cameraController;

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  @override
  void initState() {
    if (widget.camera != null) {
      _cameraController = CameraController(
        widget.camera!,
        ResolutionPreset.medium,
      )..initialize().then((value) {
          if (!mounted) return;
          setState(() {});
        });
    }
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(100);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final scaleFactor = _animationController.value;
        return Listener(
          onPointerDown: (_) {
            _animationController.reverse();
          },
          onPointerUp: (_) {
            _animationController.forward();
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0D2750).withOpacity(0.3),
                  offset: const Offset(3, 10) * scaleFactor,
                  blurRadius: 10 * scaleFactor,
                ),
                BoxShadow(
                  color: const Color(0xFF0D2750).withOpacity(0.3),
                  offset: const Offset(-3, 5) * scaleFactor,
                  blurRadius: 10 * scaleFactor,
                ),
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: Colors.white,
                  offset: const Offset(-23, -23) * scaleFactor,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Builder(
              builder: (context) {
                if (_cameraController != null) {
                  return CameraButton(
                    cameraController: _cameraController!,
                  );
                } else {
                  return const Center(
                    child: Text('Camera Unavailable'),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
