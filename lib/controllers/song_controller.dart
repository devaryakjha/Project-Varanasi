import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:varanasi/enums/fetch_type.dart';
import 'package:varanasi/repository/song_repository.dart';

class SongController extends GetxController {
  final SongRepository repository;
  SongController(this.repository);

  InitialData? get initialData => repository.initialData.value;
  bool get isFetchingInitialData =>
      repository.fetchType.value == FetchType.initialData;

  String? get searchQuery => searchController.text;
  SearchResult? get searchResult => repository.searchResult.value;
  bool get hasSearchResult => searchResult != null;
  bool get hasMorePaginationData => repository.hasMorePages.value;
  TextEditingController searchController = TextEditingController();
  bool get isFetchingSearchResult =>
      repository.fetchType.value == FetchType.searchResult;
  Future<void> fetchSearchResult() => repository.getSearchResult(searchQuery);
  Future<void> fetchArtistDetails() =>
      repository.getInstrumentDetails(searchQuery, SearchResultType.artist);
  Future<void> fetchAlbumDetails() =>
      repository.getInstrumentDetails(searchQuery, SearchResultType.album);
  Future<void> fetchSongDetails() =>
      repository.getInstrumentDetails(searchQuery, SearchResultType.song);
  Future<void> fetchPlaylistDetails() =>
      repository.getInstrumentDetails(searchQuery, SearchResultType.playlist);
  List getsearchResultsValue(SearchResultType? type) {
    switch (type) {
      case SearchResultType.album:
        return repository.albumSearchResults;
      case SearchResultType.artist:
        return repository.artistSearchResults;
      case SearchResultType.song:
        return repository.songSearchResults;
      case SearchResultType.playlist:
        return repository.playlistSearchResults;
      default:
        return [];
    }
  }

  GroupedArtistData? get groupedArtistData =>
      repository.groupedArtistData.value;
  Playlist? get playlisytDetails => repository.playlistData.value;
  Future getArtistDetails(String token) => repository.getArtistDetails(token);
  Future getPlaylistDetails(String token) =>
      repository.getPlaylistDetails(token);

  bool get isFecthingArtistDetails =>
      repository.fetchType.value == FetchType.groupedArtist;
  bool get isFetchingPlaylistDetails =>
      repository.fetchType.value == FetchType.playlist;

  clear() => repository.clear();

  nextPage(SearchResultType type) {
    switch (type) {
      case SearchResultType.album:
        fetchAlbumDetails();
        break;
      case SearchResultType.artist:
        fetchArtistDetails();
        break;
      case SearchResultType.song:
        fetchSongDetails();
        break;
      case SearchResultType.playlist:
        fetchPlaylistDetails();
        break;
      default:
    }
  }

  @override
  void onInit() {
    super.onInit();
    repository.getInitialData();
    searchController.addListener(fetchSearchResult);
  }
}
