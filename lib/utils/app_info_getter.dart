import 'package:package_info_plus/package_info_plus.dart';

/// A utility class for retrieving application information such as version.
class AppInfoGetter {
  AppInfoGetter._();

  static Future<String> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}