import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/widgets/instrument_display_widget.dart';
import 'package:varanasi/widgets/item_list.dart';
import 'package:varanasi/widgets/loader.dart';

class ArtistInstrumentDetails extends StatelessWidget {
  const ArtistInstrumentDetails(
    this.controller, {
    Key? key,
    required this.data,
  }) : super(key: key);
  final SongController controller;
  final Artist data;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Center(
          child: controller.isFecthingArtistDetails
              ? const Loader()
              : controller.groupedArtistData == null
                  ? const SizedBox.shrink()
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...buildItemsList(
                            context,
                            controller.groupedArtistData!.topAlbums,
                            'Top Albums',
                            (d) => CommonListingWidget(d),
                          ),
                          ...buildItemsList(
                            context,
                            controller.groupedArtistData!.topSongs,
                            'Top Songs',
                            (d) => CommonListingWidget(d),
                          ),
                        ],
                      ),
                    ),
        ));
  }
}
