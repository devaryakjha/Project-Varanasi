import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../src-v2.dart';

class Parser {
  static parse(dynamic map, {SearchResultType? type}) {
    switch (type == null ? map['type'] : describeEnum(type)) {
      case 'album':
        return _parseAlbum(map);
      case 'song':
        return _parseSong(map);
      case 'playlist':
        return _parsePlaylist(map);
      case 'artist':
        return _parseArtist(map);
      default:
        return null;
    }
  }

  static rectifyMap(dynamic map) {
    return jsonDecode(jsonEncode(map));
  }

  static parseCallType(SearchResultType type) => _getSearchCallType(type);

  static String _getSearchCallType(SearchResultType type) {
    switch (type) {
      case SearchResultType.album:
        return 'search.getAlbumResults';
      case SearchResultType.artist:
        return 'search.getArtistResults';
      case SearchResultType.playlist:
        return 'search.getPlaylistResults';
      case SearchResultType.song:
        return 'search.getResults';
      default:
        return 'autocomplete.get';
    }
  }

  static Artist _parseArtist(dynamic map) {
    final String url = map['url'] ??
        map['perma_url'] ??
        map['more_info']['perma_url'] ??
        map['more_info']['url'] ??
        '';
    return Artist(
      id: map['id'],
      title: (map['title'] ?? map['name']).toString().sanitize,
      subtitle: (map['subtitle'] ?? map['description'] ?? 'artist')
          .toString()
          .sanitize,
      token: url.split('/').last,
      image: ImageList(map['image'] ?? map['imageUrl']),
    );
  }

  static Playlist _parsePlaylist(dynamic map) {
    final String url = map['url'] ??
        map['perma_url'] ??
        map['more_info']['perma_url'] ??
        map['more_info']['url'] ??
        '';
    return Playlist(
      id: map['id'] ?? map['listid'],
      title: (map['title'] ?? map['listname']).toString().sanitize,
      subtitle: map['subtitle'].toString().sanitize,
      image: ImageList(map['image'] ?? map['imageUrl']),
      songCount: int.parse(
        map?['more_info']?['song_count']?.toString() ??
            map?['count']?.toString() ??
            '0',
      ),
      token: url.split('/').last,
      songs: (map['songs'] as List?)?.map(_parseSong)?.toList(),
    );
  }

  static Album _parseAlbum(dynamic map) {
    final String url = map['url'] ??
        map['perma_url'] ??
        map['more_info']['perma_url'] ??
        map['more_info']['url'] ??
        '';
    return Album(
      id: map['id'] ?? map['albumid'],
      title: (map['title'] ?? map['album']).toString().sanitize,
      subtitle: map['subtitle'].toString().sanitize,
      image: ImageList(map['image'] ?? map['imageUrl']),
      token: url.split('/').last,
      releaseDate: map?['more_info']?['release_date'] != null
          ? DateTime.tryParse(map['more_info']['release_date'])
          : null,
      songCount: int.tryParse(
              (map?['more_info']?['song_count'] ?? map?['numSongs'] ?? '0')
                  .toString()) ??
          0,
      songs: map['songs'] != null
          ? List.from(map['songs']).map(_parseSong).toList()
          : null,
    );
  }

  static Song _parseSong(dynamic map) {
    bool hasMoreInfo = map?['more_info'] != null;
    bool has320kbps =
        (!hasMoreInfo ? (map?['320kbps']) : map?['more_info']?['320kbps']) ==
            "true";
    String duration =
        (!hasMoreInfo ? (map?['duration']) : map?['more_info']?['duration']) ??
            '0';
    String? mediaURL = !hasMoreInfo
        ? (map?['encrypted_media_url']?.toString().decryptUrl)
        : map['more_info']?['encrypted_media_url']?.toString().decryptUrl;
    return Song(
      id: map['id'],
      title: (map['title'] ?? map['song']).toString().sanitize,
      subtitle: (map['subtitle'] ?? map['singers']).toString().sanitize,
      image: ImageList(map['image'] ?? map['imageUrl']),
      mediaURL: mediaURL,
      album: map?['more_info']?['album'] ?? 'none',
      albumToken: map?['more_info']?['album_url']?.split('/').last,
      has320kbps: has320kbps,
      duration: Duration(seconds: int.tryParse(duration) ?? 0),
    );
  }
}
