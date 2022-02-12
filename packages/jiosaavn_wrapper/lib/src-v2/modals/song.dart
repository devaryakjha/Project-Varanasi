import 'package:jiosaavn_wrapper/src-v2/modals/modals.dart';

class Song {
  final String id;
  final String title;
  final String subtitle;
  final ImageList image;
  final String? mediaURL;
  final String? mediaURL360;
  final String? album;
  final String? albumToken;
  final bool has320kbps;
  final Duration duration;
  final bool isMinified;
  Song({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.mediaURL,
    required this.album,
    required this.albumToken,
    required this.has320kbps,
    required this.duration,
  })  : isMinified = mediaURL == null || mediaURL.isEmpty,
        mediaURL360 = has320kbps ? mediaURL?.replaceAll('_96', '_320') : null;
}
