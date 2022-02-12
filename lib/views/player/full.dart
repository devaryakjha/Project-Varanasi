import 'package:audio_service/audio_service.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:varanasi/controllers/player_controller.dart';
import 'package:varanasi/widgets/cust_appbar.dart';
import 'package:varanasi/widgets/loader.dart';
import 'package:varanasi/widgets/seek_bar.dart';

class Player extends GetView<PlayerController> {
  const Player({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      MediaItem song = controller.currentSong!;
      final topColor = controller.topColor;
      final bottomColor = controller.bottomColor;
      final textColor = controller.textColor;

      return Scaffold(
        appBar: CustAppBar(
          bgColor: topColor,
          title: 'Now Playing',
          elementColor: textColor,
          onBackPressed: () {
            // controller.showLyrics.value = {};
          },
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              gradient: topColor != null
                  ? LinearGradient(
                      colors: [topColor, bottomColor!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : null,
            ),
            child: Center(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  SizedBox(
                    width: Get.width,
                    height: Get.width - 28,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image:
                            controller.cachedNetworkImageProvider.value != null
                                ? DecorationImage(
                                    image: controller
                                        .cachedNetworkImageProvider.value!,
                                    fit: BoxFit.cover,
                                  )
                                : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListTile(
                    title: SizedBox(
                      height: 30,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, -0.5),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        child: Marquee(
                          velocity: 30,
                          blankSpace: 8,
                          fadingEdgeEndFraction: 0.1,
                          fadingEdgeStartFraction: 0.1,
                          text: song.title,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    color: textColor,
                                  ),
                        ),
                      ),
                    ),
                    subtitle: SizedBox(
                      height: 24,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, -0.5),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        child: Marquee(
                          velocity: 30,
                          blankSpace: 8,
                          fadingEdgeEndFraction: 0.1,
                          fadingEdgeStartFraction: 0.1,
                          text: (song.displaySubtitle == null ||
                                  song.displaySubtitle!.isEmpty)
                              ? song.album ?? song.artist ?? song.title
                              : song.displaySubtitle!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(letterSpacing: 1, color: textColor),
                        ),
                      ),
                    ),
                  ),
                  SeekBar(
                    duration: controller.currentSong!.duration!,
                    position: controller.currentSongPosition,
                    onChangeEnd: controller.handleSeek,
                    color: textColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: controller.toggleShuffleMode,
                          icon: Icon(controller.isShuffleModeEnabled
                              ? Icons.shuffle_on_outlined
                              : Icons.shuffle_outlined),
                          color: textColor,
                          disabledColor: textColor?.withOpacity(0.35),
                        ),
                        IconButton(
                          onPressed: controller.hasPrev
                              ? controller.skipPrevious
                              : null,
                          icon: const Icon(Icons.skip_previous_outlined),
                          iconSize: 48,
                          color: textColor,
                          disabledColor: textColor?.withOpacity(0.35),
                        ),
                        IconButton(
                          onPressed: controller.play,
                          icon: controller.isBuffering
                              ? const Loader()
                              : Icon(
                                  controller.isPlaying
                                      ? Icons.pause_circle_filled_outlined
                                      : Icons.play_circle_fill_outlined,
                                ),
                          iconSize: 72,
                          color: textColor,
                          disabledColor: textColor?.withOpacity(0.35),
                        ),
                        IconButton(
                          onPressed:
                              controller.hasNext ? controller.skipNext : null,
                          icon: const Icon(Icons.skip_next_outlined),
                          iconSize: 48,
                          color: textColor,
                          disabledColor: textColor?.withOpacity(0.35),
                        ),
                        IconButton(
                          onPressed: controller.chanageRepeatMode,
                          icon: Icon(controller.repeatIcon),
                          color: textColor,
                          disabledColor: textColor?.withOpacity(0.35),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 5),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
