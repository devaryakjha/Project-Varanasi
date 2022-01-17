import 'package:get/get.dart';
import 'package:varanasi/enums/cache_type.dart';
import 'package:varanasi/repository/cache_repository.dart';

class CacheController extends GetxController {
  final CacheRepository repository;
  CacheController(this.repository);

  Future saveInitialData(Map<String, dynamic> data) async =>
      repository.saveDataToCache(CacheType.initialData, data);
  dynamic get getInitialData =>
      repository.getDataFromCache(CacheType.initialData);
  bool get hasCachedInitialData =>
      repository.hasCachedData(CacheType.initialData);
}
