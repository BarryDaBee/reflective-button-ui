import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:reflective_button/reflective_neumorphic_button.dart';

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
    return const MaterialApp(
      title: 'Reflective Button Demo',
      debugShowCheckedModeBanner: false,
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
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(1),
      body: Center(
        /// Psss! Here buddy!
        /// .asMap()[index] prevents this line from throwing RangeError
        /// in case there is no value at the index provided
        ///
        child: ReflectiveNeumorphicButton(camera: _cameras.asMap()[1]),
      ),
    );
  }
}
