import '../entities/effect_entity.dart';
import '../../audio/effects/voice_effect.dart';

abstract class EffectRepository {
  Future<String> applyEffect(String audioPath, VoiceEffect effect);
  Future<String> convertTextToSpeech(
    String text, {
    required String language,
    required double speed,
    required double pitch,
  });
  Future<String> reverseAudio(String audioPath);
  Future<List<VoiceEffect>> getEffectsByCategory(EffectCategory category);
  Future<List<VoiceEffect>> getAllEffects();
}

class ApplyEffectUseCase {
  final EffectRepository repository;

  ApplyEffectUseCase({required this.repository});

  Future<String> call(String audioPath, VoiceEffect effect) {
    return repository.applyEffect(audioPath, effect);
  }
}

class ConvertTextToSpeechUseCase {
  final EffectRepository repository;

  ConvertTextToSpeechUseCase({required this.repository});

  Future<String> call(
    String text, {
    required String language,
    required double speed,
    required double pitch,
  }) {
    return repository.convertTextToSpeech(
      text,
      language: language,
      speed: speed,
      pitch: pitch,
    );
  }
}

class ReverseAudioUseCase {
  final EffectRepository repository;

  ReverseAudioUseCase({required this.repository});

  Future<String> call(String audioPath) {
    return repository.reverseAudio(audioPath);
  }
}

class GetEffectsByCategoryUseCase {
  final EffectRepository repository;

  GetEffectsByCategoryUseCase({required this.repository});

  Future<List<VoiceEffect>> call(EffectCategory category) {
    return repository.getEffectsByCategory(category);
  }
}

class GetAllEffectsUseCase {
  final EffectRepository repository;

  GetAllEffectsUseCase({required this.repository});

  Future<List<VoiceEffect>> call() {
    return repository.getAllEffects();
  }
}
