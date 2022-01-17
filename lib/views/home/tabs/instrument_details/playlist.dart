import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/widgets/instrument_display_widget.dart';
import 'package:varanasi/widgets/item_list.dart';
import 'package:varanasi/widgets/loader.dart';

class PlaylistInstrumentDetails extends StatelessWidget {
  const PlaylistInstrumentDetails(
    this.controller, {
    Key? key,
    required this.data,
  }) : super(key: key);
  final SongController controller;
  final Playlist data;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: controller.isFetchingPlaylistDetails
            ? const Loader()
            : controller.playlisytDetails == null
                ? const SizedBox.shrink()
                : buildVerticalItemsList(
                    context,
                    controller.playlisytDetails!.songs,
                    'Songs',
                    (d) => CommonListingWidget(
                      d,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
      ),
    );
  }
}
