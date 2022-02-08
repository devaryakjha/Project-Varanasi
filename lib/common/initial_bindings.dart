import 'package:get/get.dart';
import 'package:varanasi/controllers/index.dart';
import 'package:varanasi/repository/index.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(CacheController(CacheRepository()));
    Get.put(SongController(SongRepository()));
    Get.put(PlayerController());
    Get.put(InstrumentPool());
  }
}
