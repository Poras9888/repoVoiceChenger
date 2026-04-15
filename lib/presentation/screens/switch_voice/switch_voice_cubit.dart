import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'switch_voice_state.dart';

class SwitchVoiceCubit extends Cubit<SwitchVoiceState> {
  SwitchVoiceCubit() : super(const SwitchVoiceInitial());

  void recordVoice() {
    emit(const SwitchVoiceRecording());
  }

  void selectVoice(String voice) {
    emit(SwitchVoiceVoiceSelected(voice: voice));
  }

  void switchVoice(String audioPath, String voice) {
    emit(SwitchVoiceProcessing(audioPath: audioPath, voice: voice));
  }

  void switchComplete(String outputPath) {
    emit(SwitchVoiceComplete(outputPath: outputPath));
  }

  void switchError(String message) {
    emit(SwitchVoiceError(message));
  }
}
