import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'text_to_audio_state.dart';

class TextToAudioCubit extends Cubit<TextToAudioState> {
  TextToAudioCubit() : super(const TextToAudioInitial());

  void updateText(String text) {
    emit(TextToAudioTextUpdated(text: text, charCount: text.length));
  }

  void updateSpeed(double speed) {
    emit(TextToAudioSpeedUpdated(speed: speed));
  }

  void updatePitch(double pitch) {
    emit(TextToAudioPitchUpdated(pitch: pitch));
  }

  void updateLanguage(String language) {
    emit(TextToAudioLanguageUpdated(language: language));
  }

  void convertStart(String text, String language, double speed, double pitch) {
    emit(TextToAudioConverting(
      text: text,
      language: language,
      speed: speed,
      pitch: pitch,
    ));
  }

  void conversionSuccess(String audioPath) {
    emit(TextToAudioConverted(audioPath: audioPath));
  }

  void saveToLibrary(String audioPath) {
    emit(TextToAudioSaved(audioPath: audioPath));
  }

  void playPreview() {
    emit(const TextToAudioPlaying());
  }

  void conversionError(String message) {
    emit(TextToAudioError(message));
  }
}
