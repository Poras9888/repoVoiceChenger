import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'reverse_voice_state.dart';

class ReverseVoiceCubit extends Cubit<ReverseVoiceState> {
  ReverseVoiceCubit() : super(const ReverseVoiceInitial());

  void recordVoice() {
    emit(const ReverseVoiceRecording());
  }

  void reverseRecording(String audioPath) {
    emit(ReverseVoiceProcessing(audioPath: audioPath));
  }

  void reversalComplete(String outputPath) {
    emit(ReverseVoiceComplete(outputPath: outputPath));
  }

  void reverseError(String message) {
    emit(ReverseVoiceError(message));
  }
}
