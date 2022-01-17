import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:varanasi/common/initial_bindings.dart';
import 'package:varanasi/routes/pages.dart';
import 'package:varanasi/routes/routes.dart';

class Varanasi extends StatelessWidget {
  const Varanasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      getPages: pages,
      initialRoute: Routes.home,
    );
  }
}
