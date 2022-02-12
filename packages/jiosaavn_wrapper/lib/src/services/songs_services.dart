import 'dart:convert';

import 'package:flutter_cache/flutter_cache.dart' as cache;
import 'package:http/http.dart' as http;

import '../src.dart';

class JioSaavnWrapper {
  static final JioSaavnWrapper instance = JioSaavnWrapper._internal();

  JioSaavnWrapper._internal();

  Future<Playlist> fetchTopSongs({int? expiredAt = 86400, int? n = 30}) async {
    try {
      var response =
          await http.get(Uri.parse(topSongsURL.replaceFirst('&n=30', '&n=$n')));
      var map = Map<String, dynamic>.from(jsonDecode(response.body));
      return await PluginFactory.createPlayList(map);
    } catch (e) {
      throw e;
    }
  }

  Future<Song> fetchSongDetails({required String songId}) async {
    try {
      String songUrl = songDetailURL + songId;
      var map = await cache.remember(
        'songDetails_$songId',
        () async => Map<String, dynamic>.from(json.decode(await http
            .get(Uri.parse(songUrl), headers: {
          "Accept": "application/json"
        }).then((value) => value.body.split("-->")[1]))[songId]),
        86400,
      );
      return await PluginFactory.createSong(map);
    } catch (e) {
      throw e;
    }
  }

  Future<SearchResult> fetchSearchResults({required String searchQuery}) async {
    try {
      var response = await http.get(Uri.parse(searchUrl(searchQuery)),
          headers: {"Accept": "application/json"});
      var map = json.decode(response.body);
      return PluginFactory.createSearchResult(map);
    } catch (e) {
      throw e;
    }
  }

  Future<TopSearchResult> fetchTrendingSearchResult() async {
    try {
      var response = await http.get(
        Uri.parse(trendingSearchURL),
        headers: {"Accept": "application/json"},
      );
      final map = List<Map<String, dynamic>>.from(json.decode(response.body));
      return PluginFactory.createTrendingSearchResult(map);
    } catch (e) {
      throw e;
    }
  }

  Future<Playlist> fetchAlbumDetails(String token) async {
    try {
      final map = await cache.remember('albumResult_$token', () async {
        var response = await http.get(
          Uri.parse(albumsDetails(token)),
          headers: {"Accept": "application/json"},
        );
        return Map<String, dynamic>.from(json.decode(response.body));
      });
      return PluginFactory.createPlayList(map);
    } catch (e) {
      throw e;
    }
  }

  Future<ArtistDetails> fetchArtistDetails(String token) async {
    try {
      final map = await cache.remember('artistResult_$token', () async {
        var response = await http.get(
          Uri.parse(artistDetails(token)),
          headers: {"Accept": "application/json"},
        );
        return Map<String, dynamic>.from(json.decode(response.body));
      });
      return PluginFactory.createArtistDetails(map);
    } catch (e) {
      throw e;
    }
  }
}
