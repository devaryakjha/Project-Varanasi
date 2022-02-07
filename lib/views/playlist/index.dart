import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:varanasi/controllers/player_controller.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);
  PlayerController get controller => Get.find();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: controller.showFullScreenPlayer,
        child: const Text('Open Player'),
      ),
    );
  }
}
