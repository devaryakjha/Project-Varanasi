import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';

class Playlist {
  ///A unique Identifier for this Object
  final String id;

  ///Title of the playlist
  final String title;

  /// Subtitle of the playlist
  final String subtitle;

  /// List of images in different resolutions
  final ImageList image;

  ///Number of songs present in this playlist
  final int songCount;

  ///Token of the playlist to be used for fetching playlist detailed information from the Api
  final String token;

  final List<Song> songs;

  ///Generates a Playlist Object
  Playlist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.songCount,
    required this.token,
    List<Song>? songs,
  }) : this.songs = songs ?? [];

  Playlist copyWith({
    String? id,
    String? title,
    String? subtitle,
    ImageList? image,
    int? songCount,
    String? token,
    List<Song>? songs,
  }) {
    return Playlist(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      image: image ?? this.image,
      songCount: songCount ?? this.songCount,
      token: token ?? this.token,
      songs: songs ?? this.songs,
    );
  }
}
