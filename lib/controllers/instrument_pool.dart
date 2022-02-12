import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';
import 'package:varanasi/enums/instrument_type.dart';

class InstrumentPool extends GetxController {
  Map<String, Playlist> cachedPlaylists = {};
  Map<String, Album> cachedAlbums = {};
  Map<String, Song> cachedSongs = {};
  Map<String, GroupedArtistData> cachedArtists = {};

  void cacheData(dynamic data, InstrumentType type) {
    switch (type) {
      case InstrumentType.album:
        cachedAlbums[data.token] = data;
        break;
      case InstrumentType.playlist:
        cachedPlaylists[data.id] = data;
        break;
      case InstrumentType.artist:
        cachedArtists[data.id] = data;
        break;
      default:
        cachedSongs[data.id] = data;
        break;
    }
  }

  bool hasCachedData(String key, InstrumentType type) {
    switch (type) {
      case InstrumentType.album:
        return cachedAlbums.containsKey(key);
      case InstrumentType.playlist:
        return cachedPlaylists.containsKey(key);
      case InstrumentType.artist:
        return cachedArtists.containsKey(key);
      default:
        return cachedSongs.containsKey(key);
    }
  }

  T _getCachedData<T>(String key, InstrumentType type) {
    switch (type) {
      case InstrumentType.album:
        return cachedAlbums[key]! as T;
      case InstrumentType.playlist:
        return cachedPlaylists[key]! as T;
      case InstrumentType.artist:
        return cachedArtists[key]! as T;
      default:
        return cachedSongs[key] as T;
    }
  }

  T getCachedDataWithoutType<T>(String key) {
    var index =
        InstrumentType.values.indexWhere((type) => hasCachedData(key, type));
    return _getCachedData(key, InstrumentType.values[index]);
  }

  Playlist getCahcedPLaylist(String id) =>
      _getCachedData(id, InstrumentType.playlist);
  Song getCahcedSong(String id) => _getCachedData(id, InstrumentType.song);
  Album getCahcedAlbum(String id) => _getCachedData(id, InstrumentType.album);
  GroupedArtistData getCahcedArtist(String id) =>
      _getCachedData(id, InstrumentType.album);
}
