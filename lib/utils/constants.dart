import 'package:flutter/material.dart';

class ConstantStrings {
  static const String updateMediaItemCustomEvent = 'updateMediaItem';
  static const notificationChanelId = 'com.teamdrt.awesomemusic.channel.audio';
  static const downloadPortName = 'varanasi_download_port';
}

class Keys {
  GlobalKey baseKey = GlobalKey();
}

class Constant {
  static ConstantStrings strings = ConstantStrings();
  static Keys keys = Keys();
}
