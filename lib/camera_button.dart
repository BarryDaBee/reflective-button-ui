import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({Key? key, required this.cameraController})
      : super(key: key);
  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CameraPreview(
          cameraController,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
              tileMode: TileMode.mirror,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.transparent,
                    Colors.white.withOpacity(0.5),
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
    );
  }
}
