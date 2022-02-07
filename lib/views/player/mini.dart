import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/controllers/player_controller.dart';
import 'package:varanasi/widgets/loader.dart';

class MiniPlayer extends GetView<PlayerController> {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Material(
      child: Obx(
        () {
          var song = controller.currentSong;
          return controller.isSongSelected && song != null
              ? InkWell(
                  onTap: controller.showFullScreenPlayer,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: Divider.createBorderSide(context, width: 1.0)),
                    ),
                    height: 70,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: song.artUri.toString(),
                          placeholder: (_, __) => Icon(
                            Icons.music_note_outlined,
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      title: Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        song.displaySubtitle?.isEmpty ?? false
                            ? song.album ?? song.title
                            : song.displaySubtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.button?.copyWith(color: Colors.grey),
                      ),
                      trailing: SizedBox(
                        width: Get.width * 0.3,
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: controller.hasPrev
                                    ? controller.audioHandler.skipToPrevious
                                    : null,
                                icon: const Icon(Icons.skip_previous_outlined),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (controller.isPlaying) {
                                  controller.audioHandler.pause();
                                } else {
                                  controller.audioHandler.play();
                                }
                              },
                              icon: controller.isBuffering
                                  ? const Loader(size: 28)
                                  : Icon(
                                      controller.isPlaying
                                          ? Icons.pause_outlined
                                          : Icons.play_arrow_outlined,
                                    ),
                              iconSize: 36,
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: controller.hasNext
                                    ? controller.audioHandler.skipToNext
                                    : null,
                                icon: const Icon(Icons.skip_next_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
