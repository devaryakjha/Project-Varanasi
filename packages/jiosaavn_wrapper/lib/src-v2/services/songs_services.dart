import 'dart:convert';
import 'package:http/http.dart' as http;

import '../src-v2.dart';

class JioSaavnWrapper {
  static final JioSaavnWrapper instance = JioSaavnWrapper._internal();

  JioSaavnWrapper._internal();

  ///Use this method to fetch the Initial data which needs to be displayed at the app startup.
  ///Returns [InitialData] in response.
  Future<List?> fetchInitialData() async {
    try {
      final response = await http.get(ApiEndPoints.initialDataURI);
      final map = Map<String, dynamic>.from(jsonDecode(response.body));
      return [map, PluginFactoryV2.parseInitialData(map)];
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> fetchSearchResult(String query) async {
    try {
      final response = await http.get(ApiEndPoints.searchResultURI(query));
      final map = Map<String, dynamic>.from(jsonDecode(response.body));
      return [map, PluginFactoryV2.parseSearchResult(map)];
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> fetchSearchResultDetailsWithPagination(
    String query, {
    SearchResultType callType = SearchResultType.none,
    int page = 1,
  }) async {
    try {
      final response = await http.get(ApiEndPoints.searchResultURI(
        query,
        callType: Parser.parseCallType(callType),
        page: page,
      ));
      final map = Map<String, dynamic>.from(jsonDecode(response.body));
      return [map, PluginFactoryV2.parseSearchResultDetails(map, callType)];
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> fetchArtistDetails(
    String token, {
    int page = 1,
  }) async {
    try {
      final response = await http.get(ApiEndPoints.artistURI(
        token,
        page: page,
      ));
      final map = Map<String, dynamic>.from(jsonDecode(response.body));
      return [map, PluginFactoryV2.parseArtistData(map)];
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> fetchPlaylistDetails(
    String id, {
    int page = 1,
  }) async {
    try {
      final response = await http.get(ApiEndPoints.playlistURI(
        id,
        page: page,
      ));
      final map = Map<String, dynamic>.from(jsonDecode(response.body));
      return [map, PluginFactoryV2.parsePlaylistData(map)];
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> fetchAlbumDetails(
    String id, {
    int page = 1,
  }) async {
    try {
      final response = await http.get(ApiEndPoints.albumURI(
        id,
        page: page,
      ));
      final map = Map<String, dynamic>.from(jsonDecode(response.body));
      return [map, PluginFactoryV2.parseAlbumData(map)];
    } catch (e) {
      rethrow;
    }
  }

  Future<Song?> fetchSongDetails(String id) async {
    try {
      final response = await http.get(ApiEndPoints.songDetails(id));
      final map = Map<String, dynamic>.from(jsonDecode(response.body));
      return PluginFactoryV2.parseSongData(map[id]);
    } catch (e) {
      rethrow;
    }
  }
}
