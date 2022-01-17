import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiosaavn_wrapper/jiosaavn_wrapper_v2.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/enums/instrument_type.dart';
import 'package:varanasi/widgets/cust_appbar.dart';
import 'package:varanasi/widgets/nav_bar.dart';

import 'instrument_details/artist.dart';
import 'instrument_details/playlist.dart';

class InstrumentDetailsPage extends GetView<SongController> {
  const InstrumentDetailsPage({Key? key}) : super(key: key);

  Widget? get detailsPage {
    switch (Get.arguments['type'] as InstrumentType) {
      case InstrumentType.album:
        return AlbumInstrumentDetails(controller, data: Get.arguments['data']);
      case InstrumentType.playlist:
        return PlaylistInstrumentDetails(controller,
            data: Get.arguments['data']);
      case InstrumentType.artist:
        return ArtistInstrumentDetails(controller, data: Get.arguments['data']);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustAppBar(
        title: Get.arguments['data'].title,
        result: Get.arguments['type'],
      ),
      bottomNavigationBar: const CustNavigationBar(),
      body: detailsPage,
    );
  }
}

class SongInstrumentDetails extends StatelessWidget {
  const SongInstrumentDetails(
    this.controller, {
    Key? key,
    required this.data,
  }) : super(key: key);
  final SongController controller;
  final Song data;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Songs'),
    );
  }
}

class AlbumInstrumentDetails extends StatelessWidget {
  const AlbumInstrumentDetails(
    this.controller, {
    Key? key,
    required this.data,
  }) : super(key: key);
  final SongController controller;
  final Album data;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Album'),
    );
  }
}
