import 'package:jiosaavn_wrapper/src-v2/modals/grouped_data.dart';
import 'package:jiosaavn_wrapper/src-v2/modals/modals.dart';

class InitialData {
  final GroupedData newTrending;
  final List<Playlist> topPlaylists;
  final List<Album> newAlbums;
  final GroupedData charts;
  final Map<String, String> title;
  final String greeting;

  const InitialData({
    required this.newTrending,
    required this.topPlaylists,
    required this.newAlbums,
    required this.charts,
    required this.title,
    this.greeting = '',
  });
}
