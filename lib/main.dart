import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app.dart';
import 'injection.dart';
import 'core/ads/consent_manager.dart';
import 'core/ads/interstitial_ad_manager.dart';
import 'presentation/screens/home/home_bloc.dart';
import 'presentation/screens/recording/recording_cubit.dart';
import 'presentation/screens/add_effect/add_effect_cubit.dart';
import 'presentation/screens/prank_sound/prank_sound_cubit.dart';
import 'presentation/screens/text_to_audio/text_to_audio_cubit.dart';
import 'presentation/screens/reverse_voice/reverse_voice_cubit.dart';
import 'presentation/screens/switch_voice/switch_voice_cubit.dart';
import 'presentation/screens/settings/settings_cubit.dart';
import 'presentation/screens/saved_recordings/saved_recordings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup DI
  setupServiceLocator();

  // Initialize MobileAds (for AdMob)
  MobileAds.instance.initialize();

  runApp(
    MyApp(
      navigatorKey: GlobalKey<NavigatorState>(),
    ),
  );
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Gather consent on first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConsentManager.gatherConsent(context);
      // Load interstitial ads
      getIt<InterstitialAdManager>().loadAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => getIt<HomeBloc>()),
        BlocProvider<RecordingCubit>(create: (_) => getIt<RecordingCubit>()),
        BlocProvider<AddEffectCubit>(create: (_) => getIt<AddEffectCubit>()),
        BlocProvider<PrankSoundCubit>(create: (_) => getIt<PrankSoundCubit>()),
        BlocProvider<TextToAudioCubit>(create: (_) => getIt<TextToAudioCubit>()),
        BlocProvider<ReverseVoiceCubit>(create: (_) => getIt<ReverseVoiceCubit>()),
        BlocProvider<SwitchVoiceCubit>(create: (_) => getIt<SwitchVoiceCubit>()),
        BlocProvider<SettingsCubit>(create: (_) => getIt<SettingsCubit>()),
        BlocProvider<SavedRecordingsBloc>(
          create: (_) => getIt<SavedRecordingsBloc>(),
        ),
      ],
      child: App(navigatorKey: widget.navigatorKey),
    );
  }
}
