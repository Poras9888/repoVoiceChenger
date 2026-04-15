import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants/ad_constants.dart';
import 'consent_manager.dart';

class InterstitialAdManager {
  static final InterstitialAdManager _instance = InterstitialAdManager._internal();

  factory InterstitialAdManager() {
    return _instance;
  }

  InterstitialAdManager._internal();

  static InterstitialAdManager get instance => _instance;

  InterstitialAd? _ad;
  DateTime? _lastShownAt;
  bool _isLoading = false;

  /// Call once after MobileAds.instance.initialize() returns.
  Future<void> loadAd() async {
    if (_isLoading) return;
    if (!await ConsentManager.canRequestAds()) return;
    _isLoading = true;
    InterstitialAd.load(
      adUnitId: AdConstants.interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _isLoading = false;
          _ad!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _ad = null;
              loadAd(); // Pre-load for next trigger immediately after dismiss.
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('Interstitial show failed: $error');
              ad.dispose();
              _ad = null;
              loadAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial load failed: $error');
          _isLoading = false;
        },
      ),
    );
  }

  /// Call at action completion points (save recording, apply effect, save TTS).
  /// Guards: cooldown check + ad ready + consent granted.
  Future<void> showIfReady(BuildContext context) async {
    if (_ad == null) return;
    if (!await ConsentManager.canRequestAds()) return;
    final now = DateTime.now();
    if (_lastShownAt != null &&
        now.difference(_lastShownAt!) < AdConstants.interstitialCooldown) {
      return; // Cooldown not elapsed — skip silently.
    }
    _lastShownAt = now;
    await _ad!.show();
  }
}
