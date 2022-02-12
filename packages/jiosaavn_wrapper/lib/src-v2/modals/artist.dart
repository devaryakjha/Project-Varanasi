import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';

class Artist {
  final String id;
  final String title;
  final String subtitle;
  final String token;
  final ImageList image;

  Artist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.token,
    required this.image,
  });
}
