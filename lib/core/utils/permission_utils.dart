import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  PermissionUtils._();

  /// Request microphone permission
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Check if microphone permission is granted
  static Future<bool> isMicrophonePermissionGranted() async {
    final status = await Permission.microphone.status;
    return status.isGranted;
  }

  /// Request storage permission (Android only)
  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  /// Check if storage permission is granted (Android only)
  static Future<bool> isStoragePermissionGranted() async {
    final status = await Permission.storage.status;
    return status.isGranted;
  }

  /// Request biometric permission
  static Future<bool> requestBiometricPermission() async {
    final status = await Permission.biometric.request();
    return status.isGranted;
  }

  /// Check if biometric is available
  static Future<bool> isBiometricAvailable() async {
    final canCheckBiometrics = await Permission.biometric.status.isGranted;
    return canCheckBiometrics;
  }

  /// Open app settings
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Check multiple permissions at once
  static Future<Map<Permission, PermissionStatus>> checkMultiple(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }
}
