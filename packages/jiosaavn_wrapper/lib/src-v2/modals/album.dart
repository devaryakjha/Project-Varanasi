import 'package:jiosaavn_wrapper/src-v2/modals/modals.dart';

class Album {
  final String id;
  final String title;
  final String subtitle;
  final String token;
  final ImageList image;
  final int songCount;
  final DateTime? releaseDate;
  final List<Song>? songs;

  Album({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.token,
    required this.image,
    this.songCount = 0,
    this.releaseDate,
    this.songs,
  });
}
