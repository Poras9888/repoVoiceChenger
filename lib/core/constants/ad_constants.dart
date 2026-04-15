import 'dart:io';

class AdConstants {
  AdConstants._();

  // Replace with real Ad Unit IDs before submitting to stores.
  // Test IDs are used below — they are safe to use during development.

  static const String _bannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const String _bannerIos = 'ca-app-pub-3940256099942544/2934735716';
  static const String _interstitialAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const String _interstitialIos = 'ca-app-pub-3940256099942544/4411468910';

  static String get bannerId => Platform.isAndroid ? _bannerAndroid : _bannerIos;

  static String get interstitialId =>
      Platform.isAndroid ? _interstitialAndroid : _interstitialIos;

  // Minimum time between two interstitial impressions (Google best practice).
  static const Duration interstitialCooldown = Duration(minutes: 3);
}
