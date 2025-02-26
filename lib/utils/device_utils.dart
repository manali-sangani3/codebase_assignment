import 'package:device_info_plus/device_info_plus.dart';

enum BuildMode { kDebug, kProfile, kRelease }

class DeviceUtils {
  static BuildMode currentBuildMode() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.kRelease;
    }
    var result = BuildMode.kProfile;

    //Little trick, since assert only runs on DEBUG mode
    assert(() {
      result = BuildMode.kDebug;
      return true;
    }());
    return result;
  }

  static Future<AndroidDeviceInfo> androidDeviceInfo() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    return plugin.androidInfo;
  }

  static Future<IosDeviceInfo> iosDeviceInfo() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    return plugin.iosInfo;
  }
}
