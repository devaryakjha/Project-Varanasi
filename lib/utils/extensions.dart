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
