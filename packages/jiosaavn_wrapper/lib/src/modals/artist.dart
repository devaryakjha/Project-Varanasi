import '../src.dart';

class Artist {
  final String id;
  final String name;
  final ArtistRole role;
  final String image;
  final String permaURL;
  final int? priority;

  String get token => permaURL.split('/').last;

  const Artist({
    required this.id,
    required this.name,
    required this.role,
    required this.image,
    required this.permaURL,
    this.priority = -1,
  });

  Artist copyWith({
    String? id,
    String? name,
    String? image,
    String? permaURL,
    ArtistRole? role,
    int? priority,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      permaURL: permaURL ?? this.permaURL,
      role: role ?? this.role,
      priority: priority ?? this.priority,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Artist &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.permaURL == permaURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ image.hashCode ^ permaURL.hashCode;
  }

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, image: $image, permaURL: $permaURL)';
  }
}

class ArtistDetails {
  final String id;
  final String name;
  final String image;
  final String? bio;
  final String fb;
  final String twitter;
  final String wiki;
  final List<Song> topSongs;
  final List<Playlist> topAlbums;
  final List<DedicatedArtistPlaylist> dedicatedPlaylists;
  final List<FeaturedArtistPlaylist> featuredIn;
  final List<MinimalSong> singles;
  final List<MinimalSong> latestRelease;
  final List<Artist> similarArtists;
  final DateTime? dob;
  final SearchResultType type;
  final bool isVerified;
  final int? followerCount;
  final int? fanCount;

  ArtistDetails({
    required this.id,
    required this.name,
    required this.image,
    this.fb = '',
    this.twitter = '',
    this.wiki = '',
    required this.topSongs,
    required this.topAlbums,
    required this.dedicatedPlaylists,
    required this.featuredIn,
    required this.singles,
    required this.latestRelease,
    required this.similarArtists,
    this.dob,
    this.bio,
    this.type = SearchResultType.album,
    this.isVerified = false,
    this.followerCount,
    this.fanCount,
  });

  String get highResImage => image.highRes;
  String get mediumResImage => image.mediumRes;
  String get lowResImage => image.lowRes;
}
