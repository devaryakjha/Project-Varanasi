import 'package:flutter/foundation.dart';
import '../src.dart';
import 'artist.dart';

class Song {
  final String id;
  final String albumId;
  final String album;
  final String label;
  final String title;
  final String subtitle;
  final String lowResImage;
  final String mediumResImage;
  final String highResImage;
  final Uri imageURI;
  final int playCount;
  final int year;
  final String permaURL;
  final bool hasLyrics;
  final String? lyrics;
  final String copyRightText;
  final String mediaURL;
  final String? previewMediaURL;
  final Duration duration;
  final DateTime releaseDate;
  final List<Artist> allArtists;

  List<Artist> get primaryArtist =>
      allArtists.where((artist) => artist.role == ArtistRole.primary).toList();

  List<Artist> get featuredArtist =>
      allArtists.where((artist) => artist.role == ArtistRole.fetaured).toList();

  List<Artist> get artist =>
      allArtists.where((artist) => artist.role == ArtistRole.artist).toList();

  const Song({
    required this.id,
    required this.albumId,
    required this.album,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.lowResImage,
    required this.mediumResImage,
    required this.highResImage,
    required this.imageURI,
    required this.playCount,
    required this.year,
    required this.permaURL,
    required this.hasLyrics,
    this.lyrics,
    required this.copyRightText,
    required this.mediaURL,
    this.previewMediaURL,
    required this.duration,
    required this.releaseDate,
    required this.allArtists,
  });

  Song copyWith({
    String? id,
    String? albumId,
    String? album,
    String? label,
    String? title,
    String? subtitle,
    String? lowResImage,
    String? mediumResImage,
    String? highResImage,
    Uri? imageURI,
    int? playCount,
    int? year,
    String? permaURL,
    bool? hasLyrics,
    String? lyrics,
    String? copyRightText,
    String? mediaURL,
    String? previewMediaURL,
    Duration? duration,
    DateTime? releaseDate,
    List<Artist>? allArtists,
  }) {
    return Song(
      id: id ?? this.id,
      albumId: albumId ?? this.albumId,
      album: album ?? this.album,
      label: label ?? this.label,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lowResImage: lowResImage ?? this.lowResImage,
      mediumResImage: mediumResImage ?? this.mediumResImage,
      highResImage: highResImage ?? this.highResImage,
      imageURI: imageURI ?? this.imageURI,
      playCount: playCount ?? this.playCount,
      year: year ?? this.year,
      permaURL: permaURL ?? this.permaURL,
      hasLyrics: hasLyrics ?? this.hasLyrics,
      lyrics: lyrics ?? this.lyrics,
      copyRightText: copyRightText ?? this.copyRightText,
      mediaURL: mediaURL ?? this.mediaURL,
      previewMediaURL: previewMediaURL ?? this.previewMediaURL,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      allArtists: allArtists ?? this.allArtists,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': highResImage,
        'mediaUrl': mediaURL,
        'title': title,
        'subtitle': subtitle,
        'description': subtitle,
        'duration': duration.inSeconds,
      };

  @override
  String toString() {
    return 'Song(id: $id, albumId: $albumId, album: $album, label: $label, title: $title, subtitle: $subtitle, lowResImage: $lowResImage, mediumResImage: $mediumResImage, highResImage: $highResImage, imageURI: $imageURI, playCount: $playCount, year: $year, permaURL: $permaURL, hasLyrics: $hasLyrics, lyrics: $lyrics, copyRightText: $copyRightText, mediaURL: $mediaURL, previewMediaURL: $previewMediaURL, duration: $duration, releaseDate: $releaseDate, allArtists: $allArtists)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Song &&
        other.id == id &&
        other.albumId == albumId &&
        other.album == album &&
        other.label == label &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.lowResImage == lowResImage &&
        other.mediumResImage == mediumResImage &&
        other.highResImage == highResImage &&
        other.imageURI == imageURI &&
        other.playCount == playCount &&
        other.year == year &&
        other.permaURL == permaURL &&
        other.hasLyrics == hasLyrics &&
        other.lyrics == lyrics &&
        other.copyRightText == copyRightText &&
        other.mediaURL == mediaURL &&
        other.previewMediaURL == previewMediaURL &&
        other.duration == duration &&
        other.releaseDate == releaseDate &&
        listEquals(other.allArtists, allArtists);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        albumId.hashCode ^
        album.hashCode ^
        label.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        lowResImage.hashCode ^
        mediumResImage.hashCode ^
        highResImage.hashCode ^
        imageURI.hashCode ^
        playCount.hashCode ^
        year.hashCode ^
        permaURL.hashCode ^
        hasLyrics.hashCode ^
        lyrics.hashCode ^
        copyRightText.hashCode ^
        mediaURL.hashCode ^
        previewMediaURL.hashCode ^
        duration.hashCode ^
        releaseDate.hashCode ^
        allArtists.hashCode;
  }
}

class MinimalSong {
  final String id;
  final String albumId;
  final String album;
  final String label;
  final String title;
  final String subtitle;
  final String lowResImage;
  final String mediumResImage;
  final String highResImage;
  final Uri imageURI;
  final int playCount;
  final int year;
  final String permaURL;
  final List<Artist> allArtists;

  const MinimalSong({
    required this.id,
    required this.albumId,
    required this.album,
    required this.label,
    required this.title,
    required this.subtitle,
    required this.lowResImage,
    required this.mediumResImage,
    required this.highResImage,
    required this.imageURI,
    required this.playCount,
    required this.year,
    required this.permaURL,
    required this.allArtists,
  });
}
