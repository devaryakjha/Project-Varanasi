import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:varanasi/controllers/app_controller.dart';
import 'package:varanasi/views/home/tabs/discover_screen.dart';
import 'package:varanasi/views/home/tabs/search_screen.dart';
import 'package:varanasi/widgets/nav_bar.dart';

class HomeScreen extends GetView<AppController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: const CustNavigationBar(),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (index) => controller.currentIndex = index,
          children: [
            const DiscoverPage(),
            const SearchPage(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
