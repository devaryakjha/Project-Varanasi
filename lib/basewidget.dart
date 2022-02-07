import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/controllers/player_controller.dart';
import 'package:varanasi/routes/routes.dart';

class BaseWidget extends GetView<PlayerController> {
  const BaseWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        child: child,
        padding: EdgeInsets.only(
          bottom: Get.currentRoute != Routes.fullScreenPlayer
              ? 0
              : controller.isSongSelected
                  ? 128
                  : 60,
        ),
      ),
    );
  }
}
