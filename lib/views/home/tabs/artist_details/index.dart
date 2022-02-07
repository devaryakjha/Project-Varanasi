import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiosaavn_wrapper/src-v2/src-v2.dart';
import 'package:get/get.dart';
import 'package:varanasi/controllers/app_controller.dart';
import 'package:varanasi/controllers/song_controller.dart';
import 'package:varanasi/utils/startup.dart';

class ArtistDetails extends GetView<SongController> {
  const ArtistDetails({Key? key}) : super(key: key);
  AppController get appController => Get.find();
  GroupedArtistData? get data => controller.groupedArtistData;
  List get bio => data != null ? json.decode(data?.bio ?? '') : null;
  Widget getTitle(String t, context) {
    return Container(
      color: Colors.blueGrey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        t,
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: Colors.white),
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data != null
          ? CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    onPressed: () {
                      Get.back(result: {'data': appController.arguments()});
                      StartupUtils.setSystemUi();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(data!.title),
                    background: CachedNetworkImage(
                      imageUrl: data!.image.hRes,
                      fit: BoxFit.cover,
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      dynamic d = bio[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getTitle(
                              d['title'].toString().isEmpty
                                  ? data!.title
                                  : d['title'],
                              context,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(d['text']),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: bio.length,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
