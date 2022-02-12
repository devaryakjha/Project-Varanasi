import 'dart:convert';

import 'package:dart_des/dart_des.dart';

extension Cleansing on String? {
  RegExp get regex => RegExp(r"\d{1,3}x\d{1,3}", caseSensitive: false);
  RegExp get regex2 =>
      RegExp(r"\d{1,3}x\d{1,3}_\d{1,3}x\d{1,3}", caseSensitive: false);
  String get sanitize => this == null
      ? ''
      : this!
          .replaceAll('&amp;', '&')
          .replaceAll('http:', 'https:')
          .replaceAll('&quot;', '"')
          .replaceAll('&#039;', "'")
          .replaceAll('<br/>', "\n");

  String get highRes => this == null
      ? ''
      : this!.replaceAll(regex, '500x500').replaceAll(regex2, '500x500');
  String get lowRes => this == null
      ? ''
      : this!.replaceAll(regex, '75x75').replaceAll(regex2, '75x75');
  String get mediumRes => this == null
      ? ''
      : this!.replaceAll(regex, '250x250').replaceAll(regex2, '250x250');
  String custom(String res) =>
      this == null ? '' : this!.replaceAll(regex, res).replaceAll(regex2, res);
  String get artwork =>
      this == null ? '' : this!.replaceAll('.m4a', '_artwork.jpg');
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
