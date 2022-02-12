import '../src.dart';
import 'song.dart';

class Playlist {
  String id;
  String title;
  String subtitle;
  String description;
  String permaURL;
  String image;
  int totalSongs;
  int followers;
  List<Song> songs;
  List<Artist>? artist;

  Playlist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.permaURL,
    required this.image,
    required this.totalSongs,
    required this.songs,
    required this.followers,
    this.artist,
  });

  Playlist copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? permaURL,
    String? image,
    int? totalSongs,
    int? followers,
    List<Song>? songs,
    List<Artist>? artist,
  }) {
    return Playlist(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      permaURL: permaURL ?? this.permaURL,
      image: image ?? this.image,
      totalSongs: totalSongs ?? this.totalSongs,
      followers: followers ?? this.followers,
      songs: songs ?? this.songs,
      artist: artist ?? this.artist,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'perma_url': permaURL,
      };
  String get highResImage => image.highRes;
  String get mediumResImage => image.mediumRes;
  String get lowResImage => image.lowRes;
  String get token => permaURL.split('/').last;
}

class DedicatedArtistPlaylist {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String permaURL;
  final int songCount;

  DedicatedArtistPlaylist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.permaURL,
    required this.songCount,
  });
}

class FeaturedArtistPlaylist extends DedicatedArtistPlaylist {
  FeaturedArtistPlaylist({
    required String id,
    required String title,
    required String subtitle,
    required String image,
    required String permaURL,
    required int songCount,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          image: image,
          permaURL: permaURL,
          songCount: songCount,
        );
}

class GeneralPlaylist<T, T2> {
  String id;
  String title;
  String subtitle;
  String description;
  String permaURL;
  T2 image;
  int totalSongs;
  List<T> songs;

  GeneralPlaylist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.permaURL,
    required this.image,
    required this.totalSongs,
    required this.songs,
  });

  GeneralPlaylist copyWith<T, T2>({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? permaURL,
    T2? image,
    int? totalSongs,
    int? followers,
    List<T>? songs,
  }) {
    return GeneralPlaylist(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      permaURL: permaURL ?? this.permaURL,
      image: image ?? this.image,
      totalSongs: totalSongs ?? this.totalSongs,
      songs: songs ?? this.songs,
    );
  }
}
