import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/basewidget.dart';
import 'package:varanasi/common/initial_bindings.dart';
import 'package:varanasi/routes/pages.dart';
import 'package:varanasi/routes/routes.dart';
import 'package:varanasi/utils/constants.dart';
import 'package:varanasi/widgets/nav_bar.dart';
import 'package:varanasi/widgets/theme.dart';

class Varanasi extends StatelessWidget {
  const Varanasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      getPages: pages,
      initialRoute: Routes.home,
      theme: theme,
      routingCallback: (route) {
        debugPrint(route?.current);
        navBarOverlayEntry.markNeedsBuild();
        if (route?.current == Routes.fullScreenPlayer) {
          Constant.keys.baseKey.currentState?.setState(() {});
        }
      },
      builder: (ctx, child) => Stack(
        children: [
          BaseWidget(child: child!, key: Constant.keys.baseKey),
          Overlay(
            initialEntries: [
              navBarOverlayEntry,
            ],
          ),
        ],
      ),
    );
  }
}
