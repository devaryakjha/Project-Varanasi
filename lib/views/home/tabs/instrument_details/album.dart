import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/widgets/instrument_display_widget.dart';
import 'package:varanasi/widgets/item_list.dart';
import 'package:varanasi/widgets/loader.dart';

class AlbumInstrumentDetails extends GetView<SongController> {
  const AlbumInstrumentDetails({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Album data;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: controller.isFetchingAlbumDetails
            ? const Loader()
            : controller.albumDetails == null
                ? const SizedBox.shrink()
                : buildVerticalItemsList(
                    context,
                    controller.albumDetails!.songs ?? [],
                    'Songs',
                    (d) => CommonListingWidget(
                      d,
                      scrollDirection: Axis.horizontal,
                      parentId: data.token,
                    ),
                  ),
      ),
    );
  }
}
