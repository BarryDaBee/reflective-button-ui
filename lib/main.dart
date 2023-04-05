import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:reflective_button/reflective_button.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const ReflectiveUIApp());
}

class ReflectiveUIApp extends StatelessWidget {
  const ReflectiveUIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Reflective UI Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white.withOpacity(1),
      child: Center(
        child: ReflectiveButton(camera: _cameras[1]),
      ),
    );
  }
}
