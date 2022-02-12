import '../src-v2.dart';

///[PluginFactoryV2]: Use this class to parse the response data from various endpoints and get the resultant modal class
class PluginFactoryV2 {
  static List<String> _allowedTypes = ['song', 'playlist', 'album'];

  ///Use this method to parse response data from API endpoint and return [InitialData]
  static InitialData? parseInitialData(map) {
    if (map == null) return null;
    final parsedData = GroupedData((map['new_trending'] as List)
        .takeWhile((value) => _allowedTypes.contains(value['type']))
        .map(Parser.parse)
        .toList());
    final charts = GroupedData((map['charts'] as List)
        .takeWhile((value) => _allowedTypes.contains(value['type']))
        .map(Parser.parse)
        .toList());
    final topPlaylist = (map['top_playlists'] as List)
        .takeWhile((value) => _allowedTypes.contains(value['type']))
        .map(Parser.parse)
        .whereType<Playlist>()
        .toList();
    final newAlbums = (map['new_albums'] as List)
        .takeWhile((value) => _allowedTypes.contains(value['type']))
        .map(Parser.parse)
        .whereType<Album>()
        .toList();

    final Map<String, String> title =
        Map<String, dynamic>.from(Parser.rectifyMap(map['modules']))
            .map((k, v) => MapEntry(k, v['title'] as String));
    return InitialData(
      newTrending: parsedData,
      topPlaylists: topPlaylist,
      newAlbums: newAlbums,
      charts: charts,
      title: title,
      greeting: map['greeting'],
    );
  }

  static SearchResult? parseSearchResult(Map<String, dynamic> map) {
    final values = map.values.toList();
    values.sort((a, b) => a['position'].compareTo(b['position']));
    var finalData = [];
    for (var value in values) {
      var data = value['data'] as List;
      data = data.map(Parser.parse).toList();
      finalData.addAll(data);
    }
    return SearchResult(GroupedData(finalData));
  }

  static List parseSearchResultDetails(
    Map<String, dynamic> map,
    SearchResultType type,
  ) =>
      (map['results'] as List).map((d) => Parser.parse(d, type: type)).toList();

  static GroupedArtistData parseArtistData(map) {
    return GroupedArtistData(
      id: map['artistId'],
      title: map['name'],
      subtitle: map['subtitle'],
      image: ImageList(map['image']),
      verified: map['isVerified'],
      followers: int.parse(map['follower_count'].toString()),
      bio: map['bio'],
      dob: DateTime.tryParse(map['dob']),
      links: SocialMediaLinks(
        fb: map['fb'],
        twitter: map['twitter'],
        wiki: map['wiki'],
      ),
      topSongs: (map['topSongs']['songs'] as List)
          .map((a) => Parser.parse(a, type: SearchResultType.song))
          .whereType<Song>()
          .toList(),
      topAlbums: (map['topAlbums']['albums'] as List)
          .map((a) => Parser.parse(a, type: SearchResultType.album))
          .whereType<Album>()
          .toList(),
    );
  }

  static Playlist parsePlaylistData(map) =>
      Parser.parse(map, type: SearchResultType.playlist);

  static Album parseAlbumData(map) =>
      Parser.parse(map, type: SearchResultType.album);
}
