import '../utilities/utilities.dart';

class ImageList {
  final String _image;

  ///Defult Constructor for [ImageList]
  ImageList(String image) : _image = image.securedUrl;

  ///Get the list of all images in the following order => low -> medium -> high
  List<String> get imageList => [lRes, mRes, hRes];

  ///The Default version of the image
  String get image => _image;

  ///The 75x75 version of the image
  String get lRes => _image.lowRes;

  ///The 250x250 version of the image
  String get mRes => _image.mediumRes;

  ///The 500x500 version of the image
  String get hRes => _image.highRes;

  ///Get Custom version of the image.
  ///Pass the Resolution in axb format only else It won't work
  String custom(String res) => _image.custom(res);
}
