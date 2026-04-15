import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'data/database/app_database.dart';
import 'data/repositories/recording_repository_impl.dart';
import 'data/repositories/effect_repository_impl.dart';
import 'domain/usecases/recording_usecases.dart';
import 'domain/usecases/effect_usecases.dart';
import 'audio/audio_processor.dart';
import 'presentation/screens/home/home_bloc.dart';
import 'presentation/screens/recording/recording_cubit.dart';
import 'presentation/screens/add_effect/add_effect_cubit.dart';
import 'presentation/screens/prank_sound/prank_sound_cubit.dart';
import 'presentation/screens/text_to_audio/text_to_audio_cubit.dart';
import 'presentation/screens/reverse_voice/reverse_voice_cubit.dart';
import 'presentation/screens/switch_voice/switch_voice_cubit.dart';
import 'presentation/screens/settings/settings_cubit.dart';
import 'presentation/screens/saved_recordings/saved_recordings_bloc.dart';
import 'core/ads/interstitial_ad_manager.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() {
  $initGetIt();
}

// Manual registration since we're using get_it directly
void setupServiceLocator() {
  // Database
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  // Audio
  getIt.registerSingleton<AudioProcessor>(AudioProcessor());
  getIt.registerSingleton<FlutterTts>(FlutterTts());

  // Repositories
  getIt.registerSingleton<RecordingRepository>(
    RecordingRepositoryImpl(database: getIt<AppDatabase>()),
  );

  getIt.registerSingleton<EffectRepository>(
    EffectRepositoryImpl(
      audioProcessor: getIt<AudioProcessor>(),
      flutterTts: getIt<FlutterTts>(),
    ),
  );

  // Use cases
  getIt.registerSingleton<SaveRecordingUseCase>(
    SaveRecordingUseCase(repository: getIt<RecordingRepository>()),
  );

  getIt.registerSingleton<GetRecordingsUseCase>(
    GetRecordingsUseCase(repository: getIt<RecordingRepository>()),
  );

  getIt.registerSingleton<GetFavoriteRecordingsUseCase>(
    GetFavoriteRecordingsUseCase(repository: getIt<RecordingRepository>()),
  );

  getIt.registerSingleton<DeleteRecordingUseCase>(
    DeleteRecordingUseCase(repository: getIt<RecordingRepository>()),
  );

  getIt.registerSingleton<DeleteAllRecordingsUseCase>(
    DeleteAllRecordingsUseCase(repository: getIt<RecordingRepository>()),
  );

  getIt.registerSingleton<ToggleFavoriteUseCase>(
    ToggleFavoriteUseCase(repository: getIt<RecordingRepository>()),
  );

  getIt.registerSingleton<SearchRecordingsUseCase>(
    SearchRecordingsUseCase(repository: getIt<RecordingRepository>()),
  );

  getIt.registerSingleton<ApplyEffectUseCase>(
    ApplyEffectUseCase(repository: getIt<EffectRepository>()),
  );

  getIt.registerSingleton<ConvertTextToSpeechUseCase>(
    ConvertTextToSpeechUseCase(repository: getIt<EffectRepository>()),
  );

  getIt.registerSingleton<ReverseAudioUseCase>(
    ReverseAudioUseCase(repository: getIt<EffectRepository>()),
  );

  getIt.registerSingleton<GetEffectsByCategoryUseCase>(
    GetEffectsByCategoryUseCase(repository: getIt<EffectRepository>()),
  );

  getIt.registerSingleton<GetAllEffectsUseCase>(
    GetAllEffectsUseCase(repository: getIt<EffectRepository>()),
  );

  // BLoCs and Cubits
  getIt.registerSingleton<HomeBloc>(
    HomeBloc(getAllEffectsUseCase: getIt<GetAllEffectsUseCase>()),
  );

  getIt.registerSingleton<RecordingCubit>(RecordingCubit());

  getIt.registerSingleton<AddEffectCubit>(AddEffectCubit());

  getIt.registerSingleton<PrankSoundCubit>(PrankSoundCubit());

  getIt.registerSingleton<TextToAudioCubit>(TextToAudioCubit());

  getIt.registerSingleton<ReverseVoiceCubit>(ReverseVoiceCubit());

  getIt.registerSingleton<SwitchVoiceCubit>(SwitchVoiceCubit());

  getIt.registerSingleton<SettingsCubit>(SettingsCubit());

  getIt.registerSingleton<SavedRecordingsBloc>(
    SavedRecordingsBloc(
      getRecordingsUseCase: getIt<GetRecordingsUseCase>(),
      deleteRecordingUseCase: getIt<DeleteRecordingUseCase>(),
      toggleFavoriteUseCase: getIt<ToggleFavoriteUseCase>(),
      searchRecordingsUseCase: getIt<SearchRecordingsUseCase>(),
    ),
  );

  // Ads
  getIt.registerSingleton<InterstitialAdManager>(
    InterstitialAdManager(),
  );
}
