import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:varanasi/enums/fetch_type.dart';

class RxnInitialData extends Rxn<InitialData> {
  RxnInitialData([InitialData? initialData]) : super(initialData);
}

class RxnFetchType extends Rxn<FetchType> {
  RxnFetchType([FetchType? initialData]) : super(initialData);
}

class RxnSearchResult extends Rxn<SearchResult> {
  RxnSearchResult([SearchResult? initialData]) : super(initialData);
}

class RxnArtist extends Rxn<Artist> {
  RxnArtist([Artist? initialData]) : super(initialData);
}

class RxnAlbum extends Rxn<Album> {
  RxnAlbum([Album? initialData]) : super(initialData);
}

class RxnPlaylist extends Rxn<Playlist> {
  RxnPlaylist([Playlist? initialData]) : super(initialData);
}

class RxnSong extends Rxn<Song> {
  RxnSong([Song? initialData]) : super(initialData);
}

class RxListArtist extends RxList<Artist> {
  RxListArtist([List<Artist>? initialData]) : super(initialData ?? []);
}

class RxListAlbum extends RxList<Album> {
  RxListAlbum([List<Album>? initialData]) : super(initialData ?? []);
}

class RxListPlaylist extends RxList<Playlist> {
  RxListPlaylist([List<Playlist>? initialData]) : super(initialData ?? []);
}

class RxListSong extends RxList<Song> {
  RxListSong([List<Song>? initialData]) : super(initialData ?? []);
}

class RxnGroupedArtistData extends Rxn<GroupedArtistData> {
  RxnGroupedArtistData([GroupedArtistData? initialData]) : super(initialData);
}

class RxnMediaItem extends Rxn<MediaItem> {
  RxnMediaItem([MediaItem? initialData]) : super(initialData);
}
