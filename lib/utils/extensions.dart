import 'package:audio_service/audio_service.dart';
import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';

extension InitialDataExtension on InitialData {
  dynamic byName(String name, {bool passData = false}) {
    switch (name) {
      case 'new_trending':
        return !passData ? newTrending : newTrending.data;
      case 'top_playlists':
        return topPlaylists;
      case 'new_albums':
        return newAlbums;
      case 'charts':
        return !passData ? charts : charts.data;
      default:
        return greeting;
    }
  }
}

extension ListExtension on Iterable {
  List<T> flat<T>() => expand<T>((i) => i).toList();
}

extension SongExtension on Song {
  MediaItem get mediaItem => MediaItem(
        id: mediaURL ?? id,
        title: title,
        artUri: Uri.parse(image.hRes),
        duration: duration,
        displayTitle: title,
        displaySubtitle: subtitle,
        album: album,
      );
}
