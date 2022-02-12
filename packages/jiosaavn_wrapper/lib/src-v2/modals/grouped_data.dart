import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';

class GroupedData {
  GroupedData(List<dynamic> data) : _data = data;
  List<dynamic> _data;

  List<Playlist> get playlits => _data.whereType<Playlist>().toList();
  List<Album> get albums => _data.whereType<Album>().toList();
  List<Song> get songs => _data.whereType<Song>().toList();
  List<Artist> get artists => _data.whereType<Artist>().toList();
  List<dynamic> get data => _data.where((element) => element != null).toList();
}

class GroupedArtistData {
  final String id;
  final String title;
  final String subtitle;
  final ImageList image;
  final bool verified;
  final int followers;
  final String bio;
  final DateTime? dob;
  final SocialMediaLinks links;
  final List<Song> topSongs;
  final List<Album> topAlbums;

  GroupedArtistData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.verified,
    required this.followers,
    required this.bio,
    required this.dob,
    required this.links,
    required this.topSongs,
    required this.topAlbums,
  });
}

class SocialMediaLinks {
  final String fb;
  final String twitter;
  final String wiki;

  SocialMediaLinks({
    required this.fb,
    required this.twitter,
    required this.wiki,
  });
}
