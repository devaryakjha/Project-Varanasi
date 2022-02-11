import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:lottie/lottie.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/gen/assets.gen.dart';
import 'package:varanasi/routes/routes.dart';
import 'package:varanasi/widgets/instrument_display_widget.dart';
import 'package:varanasi/widgets/item_list.dart';
import 'package:varanasi/widgets/loader.dart';

import '../../../controllers/app_controller.dart';

class SearchPage extends GetView<SongController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: CupertinoSearchTextField(
                controller: controller.searchController,
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!controller.isFetchingSearchResult &&
                          !controller.hasSearchResult)
                        Center(child: Lottie.asset(Assets.lottie.search)),
                      if (controller.isFetchingSearchResult)
                        const Loader(showSearchLoader: true),
                      if (!controller.isFetchingSearchResult &&
                          controller.hasSearchResult) ...[
                        ...buildItemsList(
                          context,
                          controller.searchResult!.data.artists,
                          'Artists',
                          (d) => CommonListingWidget(d),
                          onSeeAllPressed: () {
                            Get.find<AppController>().toNamed(
                              Routes.searchResultPage,
                              arguments: SearchResultType.artist,
                            );
                            controller.fetchArtistDetails();
                          },
                        ),
                        ...buildItemsList(
                          context,
                          controller.searchResult!.data.songs,
                          'Songs',
                          (d) => CommonListingWidget(d, parentId: ''),
                          onSeeAllPressed: () {
                            Get.find<AppController>().toNamed(
                              Routes.searchResultPage,
                              arguments: SearchResultType.song,
                            );
                            controller.fetchSongDetails();
                          },
                        ),
                        ...buildItemsList(
                          context,
                          controller.searchResult!.data.albums,
                          'Albums',
                          (d) => CommonListingWidget(d),
                          onSeeAllPressed: () {
                            Get.find<AppController>().toNamed(
                              Routes.searchResultPage,
                              arguments: SearchResultType.album,
                            );
                            controller.fetchAlbumDetails();
                          },
                        ),
                        ...buildItemsList(
                          context,
                          controller.searchResult!.data.playlits,
                          'Playlists',
                          (d) => CommonListingWidget(d),
                          onSeeAllPressed: () {
                            Get.find<AppController>().toNamed(
                              Routes.searchResultPage,
                              arguments: SearchResultType.playlist,
                            );
                            controller.fetchPlaylistDetails();
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
