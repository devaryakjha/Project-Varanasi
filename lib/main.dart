import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('downloads');
  await Hive.openBox('cache');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
  runApp(const Varanasi());
}
