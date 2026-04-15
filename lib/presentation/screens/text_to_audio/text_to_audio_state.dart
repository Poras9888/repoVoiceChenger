part of 'text_to_audio_cubit.dart';

class TextToAudioState extends Equatable {
  const TextToAudioState();

  @override
  List<Object?> get props => [];
}

class TextToAudioInitial extends TextToAudioState {
  const TextToAudioInitial();
}

class TextToAudioTextUpdated extends TextToAudioState {
  final String text;
  final int charCount;

  const TextToAudioTextUpdated({required this.text, required this.charCount});

  @override
  List<Object?> get props => [text, charCount];
}

class TextToAudioSpeedUpdated extends TextToAudioState {
  final double speed;

  const TextToAudioSpeedUpdated({required this.speed});

  @override
  List<Object?> get props => [speed];
}

class TextToAudioPitchUpdated extends TextToAudioState {
  final double pitch;

  const TextToAudioPitchUpdated({required this.pitch});

  @override
  List<Object?> get props => [pitch];
}

class TextToAudioLanguageUpdated extends TextToAudioState {
  final String language;

  const TextToAudioLanguageUpdated({required this.language});

  @override
  List<Object?> get props => [language];
}

class TextToAudioConverting extends TextToAudioState {
  final String text;
  final String language;
  final double speed;
  final double pitch;

  const TextToAudioConverting({
    required this.text,
    required this.language,
    required this.speed,
    required this.pitch,
  });

  @override
  List<Object?> get props => [text, language, speed, pitch];
}

class TextToAudioConverted extends TextToAudioState {
  final String audioPath;

  const TextToAudioConverted({required this.audioPath});

  @override
  List<Object?> get props => [audioPath];
}

class TextToAudioSaved extends TextToAudioState {
  final String audioPath;

  const TextToAudioSaved({required this.audioPath});

  @override
  List<Object?> get props => [audioPath];
}

class TextToAudioPlaying extends TextToAudioState {
  const TextToAudioPlaying();
}

class TextToAudioError extends TextToAudioState {
  final String message;

  const TextToAudioError(this.message);

  @override
  List<Object?> get props => [message];
}
