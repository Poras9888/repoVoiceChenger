import 'package:flutter_tts/flutter_tts.dart';
import '../../audio/effects/all_effects.dart';
import '../../audio/effects/voice_effect.dart';
import '../../audio/audio_processor.dart';
import '../../domain/usecases/effect_usecases.dart';
import '../../core/utils/file_utils.dart';

class EffectRepositoryImpl implements EffectRepository {
  final AudioProcessor audioProcessor;
  final FlutterTts flutterTts;

  EffectRepositoryImpl({
    required this.audioProcessor,
    required this.flutterTts,
  });

  final List<VoiceEffect> _allEffects = const [
    NormalEffect(),
    RobotEffect(),
    MonsterEffect(),
    CaveEffect(),
    AlienEffect(),
    NervousEffect(),
    DeathEffect(),
    DrunkEffect(),
    UnderwaterEffect(),
    BigRobotEffect(),
    ZombieEffect(),
    HexafluorideEffect(),
    SmallAlienEffect(),
    TelephoneEffect(),
    HeliumEffect(),
    GiantEffect(),
    ChipmunkEffect(),
    GhostEffect(),
    DarthVaderEffect(),
    ReverseEffect(),
  ];

  @override
  Future<String> applyEffect(String audioPath, VoiceEffect effect) async {
    return await effect.process(audioPath);
  }

  @override
  Future<String> convertTextToSpeech(
    String text, {
    required String language,
    required double speed,
    required double pitch,
  }) async {
    try {
      await flutterTts.setLanguage(language);
      await flutterTts.setSpeechRate(speed);
      await flutterTts.setPitch(pitch);

      final outputPath = await FileUtils.getTemporaryDirectory();
      final filename = FileUtils.generateRecordingFilename(prefix: 'tts');
      final fullPath = '${outputPath.path}/$filename';

      // For TTS, we'll use the default synthesis
      // In production, you'd implement platform-specific TTS to file
      await flutterTts.synthesizeToFile(text, fullPath);

      return fullPath;
    } catch (e) {
      throw Exception('TTS conversion failed: $e');
    }
  }

  @override
  Future<String> reverseAudio(String audioPath) async {
    return await audioProcessor.reverseAudio(audioPath);
  }

  @override
  Future<List<VoiceEffect>> getEffectsByCategory(EffectCategory category) async {
    return _allEffects
        .where((effect) => category == EffectCategory.all || effect.category == category)
        .toList();
  }

  @override
  Future<List<VoiceEffect>> getAllEffects() async {
    return _allEffects;
  }
}
