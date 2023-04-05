import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ReflectiveButton extends StatefulWidget {
  const ReflectiveButton({Key? key, required this.camera}) : super(key: key);
  final CameraDescription camera;

  @override
  State<ReflectiveButton> createState() => _ReflectiveButtonState();
}

class _ReflectiveButtonState extends State<ReflectiveButton>
    with TickerProviderStateMixin {
  late final CameraController _cameraController = CameraController(
    widget.camera,
    ResolutionPreset.medium,
  );

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  @override
  void initState() {
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cameraController.dispose();
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
            child: SizedBox(
              height: 100,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Transform.scale(
                  scale: 1,
                  child: CameraPreview(
                    _cameraController,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2.2,
                        sigmaY: 2.2,
                        tileMode: TileMode.mirror,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 3,
                          ),
                          borderRadius: borderRadius,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white.withOpacity(0.6),
                              Colors.transparent,
                              Colors.white.withOpacity(0.6),
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Button',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
