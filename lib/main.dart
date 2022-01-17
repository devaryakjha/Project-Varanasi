import 'package:flutter/material.dart';
import 'package:varanasi/utils/startup.dart';
import 'app.dart';

Future<void> main() async {
  await StartupUtils.setup();
  runApp(const Varanasi());
}
