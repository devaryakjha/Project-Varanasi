import 'package:get/get.dart';
import 'package:varanasi/controllers/app_controller.dart';
import 'package:varanasi/controllers/cache_controller.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/repository/cache_repository.dart';
import 'package:varanasi/repository/song_repository.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(CacheController(CacheRepository()));
    Get.put(SongController(SongRepository()));
  }
}
