import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:varanasi/enums/fetch_type.dart';
import 'package:varanasi/enums/instrument_type.dart';
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
  Future<Song?> getSongDetails(String id) => repository.getSongDetails(id);
  List getsearchResultsValue(dynamic type) {
    if (type is Map) {
      type = type['type'];
    }
    if (type is SearchResultType) {
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
    } else if (type is InstrumentType) {
      switch (type) {
        case InstrumentType.album:
          return repository.albumSearchResults;
        case InstrumentType.artist:
          return repository.artistSearchResults;
        case InstrumentType.song:
          return repository.songSearchResults;
        case InstrumentType.playlist:
          return repository.playlistSearchResults;
        default:
          return [];
      }
    }
    return [];
  }

  GroupedArtistData? get groupedArtistData =>
      repository.groupedArtistData.value;
  Playlist? get playlisytDetails => repository.playlistData.value;
  Album? get albumDetails => repository.albumData.value;
  Future getArtistDetails(String token) => repository.getArtistDetails(token);
  Future getAlbumDetails(String token) => repository.getAlbumDetails(token);

  Future getPlaylistDetails(String token) =>
      repository.getPlaylistDetails(token);

  bool get isFecthingArtistDetails =>
      repository.fetchType.value == FetchType.groupedArtist;
  bool get isFetchingPlaylistDetails =>
      repository.fetchType.value == FetchType.playlist;
  bool get isFetchingAlbumDetails =>
      repository.fetchType.value == FetchType.album;

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

  List<Song> getSongList(dynamic modal) {
    switch (modal.runtimeType) {
      case GroupedArtistData:
        return (modal as GroupedArtistData).topSongs;
      case Album:
        return (modal as Album).songs ?? [];
      case Playlist:
        return (modal as Playlist).songs;
      default:
        return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    repository.getInitialData();
    searchController.addListener(fetchSearchResult);
  }
}
