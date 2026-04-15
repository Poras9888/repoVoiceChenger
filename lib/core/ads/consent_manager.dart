import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentManager {
  ConsentManager._();

  /// Call once from main() after WidgetsFlutterBinding.ensureInitialized().
  static Future<void> gatherConsent(BuildContext context) async {
    final params = ConsentRequestParameters();

    // Uncomment to test GDPR dialog outside the EEA in debug builds:
    // params.consentDebugSettings = ConsentDebugSettings(
    //   debugGeography: DebugGeography.debugGeographyEea,
    //   testIdentifiers: ['YOUR_HASHED_DEVICE_ID'],
    // );

    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          await _loadAndShowForm(context);
        }
        // Always attempt init regardless of form availability;
        // SDK checks canRequestAds() internally.
        await _initAdMobIfAllowed();
      },
      (FormError error) async {
        // Log but do not crash — non-EEA users should still receive ads.
        debugPrint('UMP consent error ${error.errorCode}: ${error.message}');
        await _initAdMobIfAllowed();
      },
    );
  }

  static Future<void> _loadAndShowForm(BuildContext context) async {
    await ConsentForm.loadAndShowConsentFormIfRequired(
      context,
      (FormError? formError) {
        if (formError != null) {
          debugPrint('Consent form error ${formError.errorCode}: ${formError.message}');
        }
      },
    );
  }

  static Future<void> _initAdMobIfAllowed() async {
    if (await ConsentInformation.instance.canRequestAds()) {
      await MobileAds.instance.initialize();
    }
  }

  /// Opens the Privacy Options form. Call from Settings → "Ad Preferences".
  /// Only show this ListTile when status == PrivacyOptionsRequirementStatus.required.
  static Future<void> showPrivacyOptionsForm(BuildContext context) async {
    final status =
        await ConsentInformation.instance.getPrivacyOptionsRequirementStatus();
    if (status == PrivacyOptionsRequirementStatus.required) {
      await ConsentForm.showPrivacyOptionsForm(context, (FormError? formError) {
        if (formError != null) {
          debugPrint('Privacy options form error: ${formError.message}');
        }
      });
    }
  }

  /// Convenience helper queried by BannerAdWidget and InterstitialAdManager.
  static Future<bool> canRequestAds() async =>
      ConsentInformation.instance.canRequestAds();
}
