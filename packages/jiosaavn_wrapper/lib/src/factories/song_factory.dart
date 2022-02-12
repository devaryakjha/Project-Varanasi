import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache/flutter_cache.dart' as cache;

import '../src.dart';

class PluginFactory {
  static SearchResult createSearchResult(Map<String, dynamic> map) {
    return SearchResult(
      artists: PluginFactory.createArtistSearchResult(map['artists']['data']),
      albums: PluginFactory.createAlbumSearchResult(map['albums']['data']),
      songs: PluginFactory.createSongSearchResult(map['songs']['data']),
      playlists:
          PluginFactory.createPlaylistSearchResult(map['playlists']['data']),
      topQuery: PluginFactory.createTopSearchResult(map['topquery']['data']),
    );
  }

  static TopSearchResult createTrendingSearchResult(List<dynamic> data) {
    return TopSearchResult(PluginFactory.createTopSearchResult(data));
  }

  static List<ArtistSearchResult> createArtistSearchResult(List map) {
    return [
      ...map.map((artist) {
        return ArtistSearchResult(
          id: artist['id'],
          title: artist['title'],
          description: artist['description'] ?? '',
          type: SearchResultType.artist,
          image: artist['image'].toString().sanitizeImage.thumbnailToNormal,
          permaURL: artist['perma_url'] ?? artist['url'],
        );
      })
    ];
  }

  static List<AlbumSearchResult> createAlbumSearchResult(List map) {
    return [
      ...map.map((album) {
        return AlbumSearchResult(
          id: album['id'],
          title: album['title'],
          subtitle: album['subtitle'] ?? '',
          description: album['description'] ?? '',
          type: SearchResultType.album,
          image: album['image'].toString().sanitizeImage.thumbnailToNormal,
          permaURL: album['perma_url'] ?? album['url'],
          pIds: album['more_info']['song_pids'] ?? '',
          year: int.parse(album['more_info']['year'] ?? '2021'),
        );
      })
    ];
  }

  static List<SongSearchResult> createSongSearchResult(List map) {
    return [
      ...map.map((song) {
        return SongSearchResult(
          id: song['id'],
          title: song['title'],
          subtitle: song['subtitle'] ?? '',
          description: song['description'] ?? '',
          type: SearchResultType.song,
          image: song['image'].toString().sanitizeImage.thumbnailToNormal,
          permaURL: song['perma_url'] ?? song['url'],
          album: song['more_info']['album'] ?? '',
          primaryArtists: song['more_info']['primary_artists'] ?? '',
          singers: song['more_info']['singers'] ?? '',
          previewMediaURL: song['more_info']['vlink'] ?? '',
        );
      })
    ];
  }

  static List<PlaylistSearchResult> createPlaylistSearchResult(List map) {
    return [
      ...map.map((playlist) {
        return PlaylistSearchResult(
          id: playlist['id'],
          title: playlist['title'],
          subtitle: playlist['subtitle'] ?? '',
          type: SearchResultType.playlist,
          image: playlist['image'].toString().sanitizeImage.thumbnailToNormal,
          permaURL: playlist['perma_url'] ?? playlist['url'],
          description: playlist['description'] ?? '',
        );
      })
    ];
  }

  static List createTopSearchResult(List map) {
    return [
      ...map.map((topresult) {
        final type = SearchResultType.values.firstWhere(
            (element) => describeEnum(element) == topresult['type']);
        switch (type) {
          case SearchResultType.album:
            return PluginFactory.createAlbumSearchResult([topresult]).first;
          case SearchResultType.artist:
            return PluginFactory.createArtistSearchResult([topresult]).first;
          case SearchResultType.playlist:
            return PluginFactory.createPlaylistSearchResult([topresult]).first;
          default:
            return PluginFactory.createSongSearchResult([topresult]).first;
        }
      })
    ];
  }

  static Future<Playlist> createPlayList(Map<String, dynamic> map) async {
    final moreInfo = map['more_info'] as Map<String, dynamic>?;
    List<Song> songs = [];
    if (map['list'] is List) {
      for (var song in map['list']) {
        songs.add(await PluginFactory.createSong(song));
      }
    }
    List<Artist> allArtists = [];
    if (moreInfo?['artistMap'] != null) {
      (moreInfo!['artistMap'] as Map<String, dynamic>).forEach((key, value) {
        for (var item in value) {
          allArtists.add(PluginFactory.createArtist(item));
        }
      });
    }
    return Playlist(
      id: map['id'] ?? '0',
      title: (map['title'] as String).sanitize,
      subtitle: (map['subtitle'] as String).sanitize,
      description: (map['header_desc'] as String).sanitize,
      permaURL: map['perma_url'] ?? map['url'],
      image: map['image'].toString().sanitizeImage.thumbnailToNormal,
      totalSongs: int.parse(map['list_count']),
      followers: int.parse(moreInfo?['follower_count'] ?? '0'),
      songs: songs,
      artist: allArtists,
    );
  }

  static Future<Song> createSong(Map<String, dynamic> map) async {
    final moreInfo = map['more_info'] as Map<String, dynamic>;
    List<Artist> allArtists = [];
    (moreInfo['artistMap'] as Map<String, dynamic>).forEach((key, value) {
      for (var item in value) {
        allArtists.add(PluginFactory.createArtist(item));
      }
    });
    bool hasLyrics = moreInfo['has_lyrics'].toString() == 'true';
    return Song(
      id: map['id'],
      albumId: moreInfo['album_id'],
      album: moreInfo['album'],
      label: moreInfo['label'],
      title: (map['title'] as String).sanitize,
      subtitle: (map['subtitle'] as String).sanitize,
      lowResImage: (map['image'] as String).lowRes,
      mediumResImage: (map['image'] as String).mediumRes,
      highResImage: (map['image'] as String).highRes,
      imageURI: Uri.parse((map['image'] as String).highRes),
      playCount: int.tryParse(map['play_count'] ?? '0') ?? 0,
      year: int.parse(map['year'] ?? '2021'),
      permaURL: map['perma_url'] ?? map['url'],
      hasLyrics: hasLyrics,
      copyRightText: (moreInfo['copyright_text'] as String).sanitize,
      mediaURL: (moreInfo['encrypted_media_url'] as String).decryptUrl,
      duration: Duration(seconds: int.parse(moreInfo['duration'])),
      releaseDate: moreInfo['release_date'] == null
          ? DateTime(2021)
          : DateFormat('yy-mm-dd').parse(moreInfo['release_date']),
      previewMediaURL: moreInfo['vlink'],
      allArtists: allArtists,
      lyrics: hasLyrics ? await PluginFactory.getLyrics(map['id']) : null,
    );
  }

  static Artist createArtist(Map<String, dynamic> map) {
    return Artist(
      id: (map['id'] as String).sanitize,
      name: ((map['name'] ?? map['title']) as String).sanitize,
      role: PluginFactory.getArtistRole(map['role'] ?? map['type']),
      image: map['image'].toString().sanitizeImage.thumbnailToNormal,
      permaURL: map['perma_url'] ?? map['url'],
      priority: map['position'],
    );
  }

  static ArtistRole getArtistRole(String role) {
    switch (role) {
      case 'primary_artists':
        return ArtistRole.primary;
      case 'featured_artists':
        return ArtistRole.fetaured;
      default:
        return ArtistRole.artist;
    }
  }

  static Future<String> getLyrics(String songId) async {
    return await cache.remember(
      'lyrics$songId',
      () async => jsonDecode(await http.get(
        Uri.parse(lyriclURL(songId)),
        headers: {"Accept": "application/json"},
      ).then((value) => value.body.split('-->')[1]))['lyrics']
          .toString()
          .replaceAll('<br>', '\n')
          .sanitize,
    );
  }

  static Future<ArtistDetails> createArtistDetails(
      Map<String, dynamic> map) async {
    List<Song> topSongs = [];
    if (map['topSongs'] is List) {
      for (var item in map['topSongs']) {
        topSongs.add(await PluginFactory.createSong(item));
      }
    }
    List<Playlist> topAlbums = [];
    if (map['topAlbums'] is List) {
      for (var item in map['topAlbums']) {
        topAlbums.add(await PluginFactory.createPlayList(item));
      }
    }
    return ArtistDetails(
      id: map['id'] ?? '0',
      name: map['name'],
      image: map['image'].toString().sanitizeImage.thumbnailToNormal,
      topSongs: topSongs,
      topAlbums: topAlbums,
      dedicatedPlaylists: [],
      featuredIn: [],
      singles: [],
      latestRelease: [],
      similarArtists: [],
    );
  }
}
