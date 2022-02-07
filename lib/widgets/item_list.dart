import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:varanasi/widgets/loader.dart';

List<Widget> buildItemsList(
  BuildContext context,
  List<dynamic> list,
  String? title,
  Widget Function(dynamic data) builder, {
  GestureTapCallback? onSeeAllPressed,
}) =>
    list.isEmpty
        ? const [SizedBox.shrink()]
        : [
            if (title != null && title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.black,
                          ),
                    ),
                    if (onSeeAllPressed != null)
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade200),
                        ),
                        onPressed: onSeeAllPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See All',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.4,
                                        color: Colors.black,
                                      ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.black,
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            SizedBox(
              height: Get.width * 0.6,
              child: ListView.separated(
                separatorBuilder: (_, index) => const SizedBox(width: 24),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 24)
                        : index == list.length - 1
                            ? const EdgeInsets.only(right: 24)
                            : EdgeInsets.zero,
                    child: builder(list[index]),
                  );
                },
              ),
            ),
          ];

Widget buildVerticalItemsList(
  BuildContext context,
  List<dynamic> list,
  String? title,
  Widget Function(dynamic data) builder, {
  GestureTapCallback? onSeeAllPressed,
  GestureTapCallback? onLoadMorePressed,
  bool isPaginated = false,
  bool showPaginationLoader = false,
  bool sliver = false,
}) {
  return list.isEmpty
      ? const SizedBox.shrink()
      : Scrollbar(
          isAlwaysShown: true,
          child: ListView.separated(
            separatorBuilder: (_, index) => const SizedBox(height: 4),
            itemCount: !isPaginated ? list.length : list.length + 1,
            itemBuilder: (_, index) {
              return !isPaginated
                  ? builder(list[index])
                  : index == list.length
                      ? showPaginationLoader
                          ? const Loader()
                          : TextButton(
                              onPressed: onLoadMorePressed,
                              child: const Text('Load More'),
                            )
                      : builder(list[index]);
            },
          ),
        );
}
