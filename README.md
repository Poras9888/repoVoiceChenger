# Voice Changer & Sound Effects Recorder

A complete Flutter application for recording voice, applying effects, and creating prank sounds.

## 🚀 Quick Start

```bash
flutter pub get
flutter pub run build_runner build
flutter run
```

## 📦 Stack

- **Architecture**: Clean Architecture + BLoC
- **State**:  flutter_bloc + Cubit
- **Navigation**: GoRouter
- **DI**: get_it
- **Database**: drift (SQLite)
- **Audio**: record + just_audio + flutter_tts
- **Ads**: google_mobile_ads (AdMob with UMP consent)

## 🎙️ Features

✅ Voice recording at 44100Hz  
✅ 20 voice effects (Robot, Monster, Alien, Ghost, etc.)  
✅ Text-to-speech with speed/pitch control  
✅ 30+ prank sounds and animal sounds  
✅ Reverse voice effect  
✅ Local database with favorites  
✅ AdMob banner + interstitial ads  
✅ GDPR/CCPA consent flow  
✅ Biometric lock for recordings  

## 📱 Screens

1. Home - Feature grid + voice effects
2. Recording - Real-time waveform
3. Add Effect - 20 effects with filtering
4. Prank Sound - 30+ sounds with controls
5. Text to Audio - TTS with language selection
6. Reverse Voice - Voice reversal
7. Switch Voice - Voice tone selection
8. Saved Recordings - Database management
9. Settings - Audio quality, biometric, links

## 🎨 UI

- Material Design 3
- Playful emoji-centric design
- Colors: Sky Blue, Coral, Purple
- Custom painters for waveforms
- Smooth animations throughout

## 📂 Project Structure

```
lib/
├── main.dart
├── app.dart
├── injection.dart
├── core/
│   ├── constants/
│   ├── theme/
│   ├── router/
│   ├── ads/
│   └── utils/
├── data/
│   ├── database/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── usecases/
├── audio/
│   ├── effects/ (20 effects)
│   └── audio_processor.dart
└── presentation/
    ├── screens/ (9 screens)
    └── widgets/
```

## 🔑 Key Files

- `lib/injection.dart` - Dependency injection setup
- `lib/core/router/app_router.dart` - Navigation routes
- `lib/core/ads/consent_manager.dart` - GDPR/CCPA consent
- `lib/audio/effects/all_effects.dart` - All 20 voice effects
- `lib/data/database/app_database.dart` - Drift setup

## 📋 Configuration

### Before Release
1. Update Ad Unit IDs in `ad_constants.dart`
2. Set real app IDs in Android/iOS platforms
3. Create privacy policy URL
4. Test on real devices

### Test Ad IDs (Development)
Already configured in code - safe to use during testing.

## 🎯 Supported Platforms

- Android 24+ (API 24)
- iOS 13+

## 💡 Notes

- All audio processing on-device
- No external server calls for recordings
- Biometric auth via local_auth
- Drift for efficient local storage
- Clean Architecture for maintainability