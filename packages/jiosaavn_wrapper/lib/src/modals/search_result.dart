class SearchResult {
  final List<AlbumSearchResult> albums;
  final List<SongSearchResult> songs;
  final List<PlaylistSearchResult> playlists;
  final List<ArtistSearchResult> artists;
  final List topQuery;

  List<SongSearchResult> get topQuerySongs =>
      [...topQuery.whereType<SongSearchResult>()];

  List<AlbumSearchResult> get topQueryAlbums =>
      [...topQuery.whereType<AlbumSearchResult>()];

  List<PlaylistSearchResult> get topQueryPlaylist =>
      [...topQuery.whereType<PlaylistSearchResult>()];

  List<ArtistSearchResult> get topQueryArtists =>
      [...topQuery.whereType<ArtistSearchResult>()];

  const SearchResult({
    required this.albums,
    required this.songs,
    required this.playlists,
    required this.topQuery,
    required this.artists,
  });
}

class TopSearchResult {
  final List topQuery;

  List<SongSearchResult> get songs =>
      [...topQuery.whereType<SongSearchResult>()];

  List<AlbumSearchResult> get albums =>
      [...topQuery.whereType<AlbumSearchResult>()];

  List<PlaylistSearchResult> get playlist =>
      [...topQuery.whereType<PlaylistSearchResult>()];

  List<ArtistSearchResult> get artists =>
      [...topQuery.whereType<ArtistSearchResult>()];

  TopSearchResult(this.topQuery);
}

class ArtistSearchResult {
  final String id;
  final String title;
  final String description;
  final SearchResultType type;
  final String image;
  final String permaURL;

  String get token => permaURL.split('/').last;

  const ArtistSearchResult({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.image,
    required this.permaURL,
  });
}

class PlaylistSearchResult {
  final String id;
  final String title;
  final String subtitle;
  final SearchResultType type;
  final String image;
  final String permaURL;
  final String description;

  const PlaylistSearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.image,
    required this.permaURL,
    required this.description,
  });
}

class SongSearchResult {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final SearchResultType type;
  final String image;
  final String permaURL;
  final String album;
  final String primaryArtists;
  final String singers;
  final String previewMediaURL;

  const SongSearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.type,
    required this.image,
    required this.permaURL,
    required this.album,
    required this.primaryArtists,
    required this.singers,
    required this.previewMediaURL,
  });
}

class AlbumSearchResult {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final SearchResultType type;
  final String image;
  final String permaURL;
  final String pIds;
  final int year;

  const AlbumSearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.type,
    required this.image,
    required this.permaURL,
    required this.pIds,
    required this.year,
  });

  String get token => permaURL.split('/').last;
}

enum SearchResultType {
  artist,
  playlist,
  song,
  album,
}
