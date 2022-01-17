import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi/enums/cache_type.dart';

class CacheRepository {
  final Box _cacheBox = Hive.box('cache');

  ///Caches data into storage for usage when user is offline
  Future saveDataToCache(CacheType key, Map<String, dynamic> data) async =>
      await _cacheBox.put(describeEnum(key), data);

  ///Returns boolean verifying if the passed [key] exists in cached data
  bool hasCachedData(CacheType key) => _cacheBox.containsKey(describeEnum(key));

  ///Get value from
  dynamic getDataFromCache(CacheType key) =>
      _cacheBox.get(describeEnum(key), defaultValue: null);
}
