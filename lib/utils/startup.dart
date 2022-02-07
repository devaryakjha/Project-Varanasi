import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StartupUtils {
  static setup({
    Iterable<Future>? futures,
    List<DeviceOrientation>? orientations,
  }) async {
    orientations ??= [DeviceOrientation.portraitUp];
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(orientations);
    setSystemUi();
    await Hive.initFlutter();
    await Future.wait([
      FlutterDownloader.initialize(),
      Hive.openBox('downloads'),
      Hive.openBox('cache'),
      ...(futures ?? []),
    ]);
  }

  static setSystemUi() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
      ),
    );
  }
}
