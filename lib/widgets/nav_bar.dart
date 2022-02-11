import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/controllers/app_controller.dart';
import 'package:varanasi/routes/routes.dart';
import 'package:varanasi/views/player/mini.dart';

var navBarOverlayEntry = OverlayEntry(
  builder: (context) {
    if (Get.currentRoute != Routes.fullScreenPlayer) {
      return const CustNavigationBar();
    }
    return const SizedBox.shrink();
  },
);

class CustNavigationBar extends GetView<AppController> {
  const CustNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Get.currentRoute == Routes.fullScreenPlayer
        ? const SizedBox.shrink()
        : Hero(
            tag: 'AppBottomNavigationBar',
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const MiniPlayer(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: Divider.createBorderSide(
                          context,
                          width: 0.5,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    child: BottomNavigationBar(
                      elevation: 2,
                      backgroundColor: Colors.white,
                      currentIndex: controller.currentIndex,
                      selectedItemColor: Colors.black,
                      unselectedItemColor: Colors.grey,
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      onTap: (index) => controller.currentIndex = index,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.music_note_outlined),
                          label: 'Explore',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          label: 'Search',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.playlist_play_rounded),
                          label: 'Playlist',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline),
                          label: 'Account',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
