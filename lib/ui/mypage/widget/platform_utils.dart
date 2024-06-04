import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class PlatformUtils {
  static Future<bool> isAndroidUnder33() async {
    if (Platform.isAndroid) {
      var deviceInfo = DeviceInfoPlugin();
      var androidInfo = await deviceInfo.androidInfo;
      var sdkVersion = androidInfo.version.sdkInt;

      if (sdkVersion < 33) {
        return true;
      }
    }
    return false;
  }
}