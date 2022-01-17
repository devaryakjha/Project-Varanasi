import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/widgets/instrument_display_widget.dart';
import 'package:varanasi/widgets/item_list.dart';
import 'package:varanasi/widgets/loader.dart';
import 'package:varanasi/utils/extensions.dart';

class DiscoverPage extends GetView<SongController> {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isFetchingInitialData
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'new_trending',
                  'top_playlists',
                  'new_albums',
                  'charts'
                ]
                    .map((title) => buildItemsList(
                          context,
                          controller.initialData!.byName(title, passData: true),
                          controller.initialData!.title[title]!,
                          (i) => CommonListingWidget(i),
                        ))
                    .flat(),
              ),
            ),
    );
  }
}
