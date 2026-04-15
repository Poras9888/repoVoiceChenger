import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/recording/recording_screen.dart';
import '../../presentation/screens/add_effect/add_effect_screen.dart';
import '../../presentation/screens/prank_sound/prank_sound_screen.dart';
import '../../presentation/screens/text_to_audio/text_to_audio_screen.dart';
import '../../presentation/screens/reverse_voice/reverse_voice_screen.dart';
import '../../presentation/screens/switch_voice/switch_voice_screen.dart';
import '../../presentation/screens/saved_recordings/saved_recordings_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/recording',
        builder: (context, state) => const RecordingScreen(),
      ),
      GoRoute(
        path: '/add-effect',
        builder: (context, state) => const AddEffectScreen(),
        extra: state.extra as Map<String, dynamic>?,
      ),
      GoRoute(
        path: '/prank-sound',
        builder: (context, state) => const PrankSoundScreen(),
      ),
      GoRoute(
        path: '/text-to-audio',
        builder: (context, state) => const TextToAudioScreen(),
      ),
      GoRoute(
        path: '/reverse-voice',
        builder: (context, state) => const ReverseVoiceScreen(),
      ),
      GoRoute(
        path: '/switch-voice',
        builder: (context, state) => const SwitchVoiceScreen(),
      ),
      GoRoute(
        path: '/saved-recordings',
        builder: (context, state) => const SavedRecordingsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/recording/recording_screen.dart';
import '../../presentation/screens/add_effect/add_effect_screen.dart';
import '../../presentation/screens/prank_sound/prank_sound_screen.dart';
import '../../presentation/screens/text_to_audio/text_to_audio_screen.dart';
import '../../presentation/screens/reverse_voice/reverse_voice_screen.dart';
import '../../presentation/screens/switch_voice/switch_voice_screen.dart';
import '../../presentation/screens/saved_recordings/saved_recordings_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/recording',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return RecordingScreen(extra: extra);
      },
    ),
    GoRoute(
      path: '/add-effect',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return AddEffectScreen(extra: extra);
      },
    ),
    GoRoute(
      path: '/prank-sound',
      builder: (context, state) => const PrankSoundScreen(),
    ),
    GoRoute(
      path: '/text-to-audio',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return TextToAudioScreen(extra: extra);
      },
    ),
    GoRoute(
      path: '/reverse-voice',
      builder: (context, state) => const ReverseVoiceScreen(),
    ),
    GoRoute(
      path: '/switch-voice',
      builder: (context, state) => const SwitchVoiceScreen(),
    ),
    GoRoute(
      path: '/saved-recordings',
      builder: (context, state) => const SavedRecordingsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
