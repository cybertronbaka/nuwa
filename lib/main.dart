import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nuwa_assignment/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();

  runApp(const NuwaAssignmentApp());
}