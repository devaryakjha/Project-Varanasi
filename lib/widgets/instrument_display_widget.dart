import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/enums/instrument_type.dart';
import 'package:varanasi/routes/routes.dart';

class InstrumentDisplayGeneric extends GetView<SongController> {
  InstrumentDisplayGeneric({
    Key? key,
    required this.image,
    required this.title,
    required String subtitle,
    required this.type,
    Axis? scrollDirection = Axis.vertical,
  })  : isCircle = type == InstrumentType.artist,
        subtitle = (subtitle.isEmpty || subtitle == 'null')
            ? describeEnum(type).capitalize!
            : subtitle.capitalize!,
        isHorizontal = scrollDirection == Axis.horizontal,
        super(key: key ?? ValueKey(image));

  final String image, title, subtitle;
  final InstrumentType type;
  final bool isCircle;
  final bool isHorizontal;

  onTap() {}

  @override
  Widget build(BuildContext context) {
    return !isHorizontal
        ? GestureDetector(
            onTap: onTap,
            child: SizedBox.fromSize(
              size: Size.square(Get.width * 0.45),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Get.width * 0.4,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: isCircle ? null : BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.bold, letterSpacing: 0.6),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(letterSpacing: 1, color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: 80,
            width: Get.width,
            child: ListTile(
              isThreeLine: true,
              onTap: onTap,
              leading: ClipRRect(
                borderRadius: isCircle
                    ? BorderRadius.circular(999)
                    : BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: Get.width * 0.13,
                  placeholder: (context, error) {
                    return const Center(
                      child: Icon(
                        Icons.music_note_outlined,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
  }
}

class PlayListListingWidget extends InstrumentDisplayGeneric {
  PlayListListingWidget({
    Key? key,
    required this.playlist,
    Axis? scrollDirection,
  }) : super(
          key: key,
          image: playlist.image.mRes,
          title: playlist.title,
          subtitle: (playlist.subtitle.isEmpty || playlist.subtitle == 'null')
              ? '${playlist.songCount} Songs'
              : playlist.subtitle,
          type: InstrumentType.playlist,
          scrollDirection: scrollDirection,
        );
  final Playlist playlist;
  @override
  onTap() {
    Get.toNamed(Routes.instrumentDetails, arguments: {
      "data": playlist,
      "type": InstrumentType.playlist,
    });
    controller.getPlaylistDetails(playlist.id);
  }
}

class ArtistListingWidget extends InstrumentDisplayGeneric {
  ArtistListingWidget({
    Key? key,
    required this.artist,
    Axis? scrollDirection,
  }) : super(
          key: key,
          image: artist.image.mRes,
          title: artist.title,
          subtitle: artist.subtitle,
          type: InstrumentType.artist,
          scrollDirection: scrollDirection,
        );
  final Artist artist;
  @override
  onTap() {
    Get.toNamed(Routes.instrumentDetails, arguments: {
      "data": artist,
      "type": InstrumentType.artist,
    });
    controller.getArtistDetails(artist.token);
  }
}

class AlbumListingWidget extends InstrumentDisplayGeneric {
  AlbumListingWidget({
    Key? key,
    required this.album,
    Axis? scrollDirection,
  }) : super(
          key: key,
          image: album.image.mRes,
          title: album.title,
          subtitle: album.subtitle,
          type: InstrumentType.album,
          scrollDirection: scrollDirection,
        );
  final Album album;
  @override
  onTap() {
    Get.toNamed(Routes.instrumentDetails, arguments: {
      "data": album,
      "type": InstrumentType.album,
    });
  }
}

class SongListingWidget extends InstrumentDisplayGeneric {
  SongListingWidget({
    Key? key,
    required this.song,
    Axis? scrollDirection,
  }) : super(
          key: key,
          image: song.image.mRes,
          title: song.title,
          subtitle: song.subtitle,
          type: InstrumentType.song,
          scrollDirection: scrollDirection,
        );

  final Song song;

  @override
  onTap() {}
}

class CommonListingWidget extends StatelessWidget {
  const CommonListingWidget(
    this.data, {
    Key? key,
    this.scrollDirection,
  }) : super(key: key);
  final dynamic data;
  final Axis? scrollDirection;
  Widget getWidget() {
    switch (data.runtimeType) {
      case Playlist:
        return PlayListListingWidget(
          playlist: data,
          scrollDirection: scrollDirection,
        );
      case Song:
        return SongListingWidget(
          song: data,
          scrollDirection: scrollDirection,
        );
      case Album:
        return AlbumListingWidget(
          album: data,
          scrollDirection: scrollDirection,
        );
      case Artist:
        return ArtistListingWidget(
          artist: data,
          scrollDirection: scrollDirection,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) => getWidget();
}