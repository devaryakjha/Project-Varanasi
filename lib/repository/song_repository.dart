import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:varanasi/controllers/cache_controller.dart';
import 'package:varanasi/custom/cust_rx.dart';
import 'package:varanasi/enums/fetch_type.dart';

class SongRepository {
  final JioSaavnWrapper _jioSaavnWrapper = JioSaavnWrapper.instance;
  final CacheController _cacheController = Get.find();
  final RxnFetchType fetchType = RxnFetchType();
  final RxInt pageNo = RxInt(1);
  final RxBool hasMorePages = RxBool(true);

  ///Methods and variables related to [InitialData]
  RxnInitialData initialData = RxnInitialData(
    PluginFactoryV2.parseInitialData(
      Get.find<CacheController>().getInitialData,
    ),
  );
  Future<void> getInitialData() async {
    fetchType.value = FetchType.initialData;
    if (_cacheController.hasCachedInitialData) {
      initialData.value =
          PluginFactoryV2.parseInitialData(_cacheController.getInitialData);
    }
    final data = await _jioSaavnWrapper.fetchInitialData();
    if (data != null) {
      _cacheController.saveInitialData(data[0]);
    }
    initialData.value = data?[1];
    fetchType.value = null;
  }

  ///Methods and variables related to [SearchResult]
  String getSearchCallType(SearchResultType type) {
    switch (type) {
      case SearchResultType.album:
        return 'search.getAlbumResults';
      case SearchResultType.artist:
        return 'search.getArtistResults';
      case SearchResultType.playlist:
        return 'search.getPlaylistResults';
      default:
        return 'search.getResults';
    }
  }

  RxnSearchResult searchResult = RxnSearchResult();
  RxListArtist artistSearchResults = RxListArtist();
  RxListAlbum albumSearchResults = RxListAlbum();
  RxListPlaylist playlistSearchResults = RxListPlaylist();
  RxListSong songSearchResults = RxListSong();
  RxnGroupedArtistData groupedArtistData = RxnGroupedArtistData();
  RxnPlaylist playlistData = RxnPlaylist();
  RxnAlbum albumData = RxnAlbum();

  clear() {
    artistSearchResults.clear();
    groupedArtistData.value = null;
    albumSearchResults.clear();
    playlistSearchResults.clear();
    songSearchResults.clear();
    pageNo.value = 1;
    hasMorePages.value = true;
  }

  void setSearchResult(dynamic data, SearchResultType type) {
    switch (type) {
      case SearchResultType.album:
        if (pageNo.value == 1) {
          albumSearchResults.clear();
        }
        albumSearchResults.addAll((data as List).whereType<Album>());

        break;
      case SearchResultType.artist:
        if (pageNo.value == 1) {
          artistSearchResults.clear();
        }
        artistSearchResults.addAll((data as List).whereType<Artist>());

        break;
      case SearchResultType.song:
        if (pageNo.value == 1) {
          songSearchResults.clear();
        }
        songSearchResults.addAll((data as List)
            .whereType<Song>()
            .skipWhile((value) => value.duration.inSeconds == 0));

        break;
      case SearchResultType.playlist:
        if (pageNo.value == 1) {
          playlistSearchResults.clear();
        }
        playlistSearchResults.addAll((data as List).whereType<Playlist>());
        break;
      default:
    }
  }

  Future<void> getSearchResult(String? query) async {
    if (query == null || query.isEmpty) {
      searchResult.value = null;
      return;
    }
    fetchType.value = FetchType.searchResult;
    final data = await _jioSaavnWrapper.fetchSearchResult(query);
    searchResult.value = data?[1];
    fetchType.value = null;
  }

  Future<void> getInstrumentDetails(
      String? query, SearchResultType type) async {
    if (query == null || query.isEmpty) {
      searchResult.value = null;
      return;
    }
    fetchType.value = FetchType.searchResult;
    final data = await _jioSaavnWrapper.fetchSearchResultDetailsWithPagination(
      query,
      page: pageNo.value,
      callType: type,
    );
    setSearchResult(data?[1], type);
    if (data != null && data[1].length == 30) {
      pageNo.value++;
    } else if (data?[1].length < 30) {
      hasMorePages.value = false;
    }
    fetchType.value = null;
  }

  Future<void> getArtistDetails(String token) async {
    fetchType.value = FetchType.groupedArtist;
    debugPrint('Fecthing Artist data for $token');
    final data = await _jioSaavnWrapper.fetchArtistDetails(token);
    groupedArtistData.value = data?[1];
    debugPrint(
        'Completed fetching data for Artist with token $token with result: ${data?[1] != null}');
    fetchType.value = null;
  }

  Future<void> getPlaylistDetails(String id) async {
    fetchType.value = FetchType.playlist;
    debugPrint('Fecthing Playlist data for $id');
    final data = await _jioSaavnWrapper.fetchPlaylistDetails(id);
    playlistData.value = data?[1];
    debugPrint(
        'Completed fetching data for Playlist with id $id with result: ${data?[1] != null}, ${data?[1]?.songs.length}');
    fetchType.value = null;
  }

  Future<void> getAlbumDetails(String id) async {
    fetchType.value = FetchType.album;
    debugPrint('Fecthing Album data for $id');
    final data = await _jioSaavnWrapper.fetchAlbumDetails(id);
    albumData.value = data?[1];
    debugPrint(
        'Completed fetching data for Album with id $id with result: ${data?[1] != null}, ${data?[1]}');
    fetchType.value = null;
  }
}
