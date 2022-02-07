import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';
import 'package:just_audio/just_audio.dart';

import 'package:varanasi/common/audio_handler.dart';
import 'package:varanasi/controllers/app_controller.dart';
import 'package:varanasi/custom/cust_rx.dart';
import 'package:varanasi/routes/routes.dart';
import 'package:varanasi/utils/constants.dart';
import 'package:varanasi/utils/extensions.dart';

class PlayerController extends GetxController {
  late AudioHandler audioHandler;
  AudioPlayer audioPlayer = AudioPlayer();
  RxnMediaItem currSong = RxnMediaItem();
  RxBool playingStream = RxBool(false);
  Rx<PlaybackEvent> playBackStream = Rx(PlaybackEvent());
  RxList<MediaItem> queueStream = RxList();

  MediaItem? get currentSong => currSong.value;
  bool get isSongSelected => currentSong != null;
  bool get isPlaying => playingStream.value;
  bool get isBuffering =>
      playBackStream.value.processingState == ProcessingState.buffering;
  bool get hasNext => audioPlayer.hasNext;
  bool get hasPrev => audioPlayer.hasPrevious;

  @override
  Future<void> onReady() async {
    super.onReady();
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: ConstantStrings.notificationChanelId,
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );
    await audioHandler.prepare();
    playingStream.bindStream(audioPlayer.playingStream);
    playBackStream.bindStream(audioPlayer.playbackEventStream);
    queueStream.bindStream(audioHandler.queue);
  }

  void showFullScreenPlayer() =>
      Get.find<AppController>().toNamed(Routes.fullScreenPlayer);

  void selectSong(Song song) async {
    bool isSelected = this.currentSong?.id == song.mediaURL;
    var currentSong = song.mediaItem;
    bool alreadyAdded = queueStream.any((e) => e.id == currentSong.id);
    if (!alreadyAdded) {
      await audioHandler.addQueueItem(currentSong);
    }
    if (!isSelected) {
      playFromId(currentSong.id);
      currSong.value = currentSong;
    } else {
      isPlaying ? audioHandler.pause() : audioHandler.play();
    }
  }

  void playFromId(String id) => audioHandler.playFromMediaId(id);
}
