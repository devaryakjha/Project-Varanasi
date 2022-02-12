import 'dart:convert';

import 'package:dart_des/dart_des.dart';

extension Cleansing on String? {
  String get sanitize => this == null
      ? ''
      : this!
          .replaceAll('&amp;', '&')
          .replaceAll('http:', 'https:')
          .replaceAll('&quot;', '"')
          .replaceAll('&#039;', "'")
          .replaceAll('<br/>', "\n");

  String get highRes =>
      this == null ? '' : this!.securedUrl.replaceAll('150x150', '500x500');
  String get lowRes => this == null ? '' : this!.replaceAll('150x150', '75x75');
  String get mediumRes =>
      this == null ? '' : this!.securedUrl.replaceAll('150x150', '250x250');
  String get artwork =>
      this == null ? '' : this!.securedUrl.replaceAll('.m4a', '_artwork.jpg');
  String get securedUrl =>
      this == null ? '' : this!.replaceAll('http:', 'https:');
  String get thumbnailToNormal =>
      this == null ? '' : this!.securedUrl.replaceAll('50x50', '150x150');
  String get sanitizeImage =>
      this == null ? '' : this!.securedUrl.replaceAll('50x50_50x50', '150x150');
  String get decryptUrl {
    if (this == null) return '';
    const key = '38346591';
    final desECB = DES(key: key.codeUnits, paddingType: DESPaddingType.PKCS7);
    final decrypted = desECB.decrypt(base64Decode(this!));
    return utf8.decode(decrypted);
  }
}
