import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/enums/instrument_type.dart';
import 'package:varanasi/routes/routes.dart';
import 'package:varanasi/widgets/cust_appbar.dart';

import '../../../controllers/app_controller.dart';
import 'instrument_details/album.dart';
import 'instrument_details/artist.dart';
import 'instrument_details/playlist.dart';

// ignore: must_be_immutable
class InstrumentDetailsPage extends GetView<SongController> {
  const InstrumentDetailsPage({Key? key}) : super(key: key);
  AppController get appController => Get.find();
  dynamic get data => appController.arguments()?['data'];
  dynamic get type => appController.arguments()?['type'];
  Widget? get detailsPage {
    switch (type) {
      case InstrumentType.album:
        return AlbumInstrumentDetails(data: data);
      case InstrumentType.playlist:
        return PlaylistInstrumentDetails(controller, data: data);
      case InstrumentType.artist:
        return ArtistInstrumentDetails(controller, data: data);
      default:
        return null;
    }
  }

  Widget? get fab {
    switch (type) {
      case InstrumentType.artist:
        return IconButton(
          tooltip: 'About Artist',
          onPressed: (() => Get.find<AppController>()
              .toNamed(Routes.artistInfo, arguments: data)),
          icon: const Icon(
            Icons.info_outline_rounded,
            size: 24,
            color: Colors.black,
          ),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustAppBar(
        title: data?.title,
        result: type,
        action: fab,
      ),
      body: detailsPage ?? const SizedBox.shrink(),
    );
  }
}
