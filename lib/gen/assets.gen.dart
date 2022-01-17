/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering

import 'package:flutter/widgets.dart';

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/launcher_icon.png
  AssetGenImage get launcherIcon =>
      const AssetGenImage('assets/logo/launcher_icon.png');
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/downloading.json
  String get downloading => 'assets/lottie/downloading.json';

  /// File path: assets/lottie/search.json
  String get search => 'assets/lottie/search.json';

  /// File path: assets/lottie/searching.json
  String get searching => 'assets/lottie/searching.json';
}

class Assets {
  Assets._();

  static const $AssetsLogoGen logo = $AssetsLogoGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
