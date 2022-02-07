import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:varanasi/gen/assets.gen.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, this.showSearchLoader = false, this.size})
      : super(key: key);
  final bool showSearchLoader;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: showSearchLoader
          ? Lottie.asset(Assets.lottie.searching)
          : SizedBox.square(
              dimension: size,
              child: CircularProgressIndicator(
                backgroundColor: Colors.black.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation(Colors.black),
              ),
            ),
    );
  }
}
