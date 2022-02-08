import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/controllers/app_controller.dart';
import 'package:varanasi/controllers/player_controller.dart';
import 'package:varanasi/routes/routes.dart';

class BaseWidget extends StatefulWidget {
  const BaseWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  PlayerController get controller => Get.find();
  AppController get appController => Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Get.currentRoute == Routes.fullScreenPlayer
          ? widget.child
          : Padding(
              child: widget.child,
              padding: EdgeInsets.only(
                bottom: controller.isSongSelected ? 128 : 60,
              ),
            ),
    );
  }
}
