import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recording_state.dart';

class RecordingCubit extends Cubit<RecordingState> {
  RecordingCubit() : super(const RecordingInitial());

  void startRecording() {
    emit(const RecordingInProgress(duration: Duration.zero));
  }

  void updateDuration(Duration duration) {
    emit(RecordingInProgress(duration: duration));
  }

  void saveAndApplyEffect(String recordingPath) {
    emit(const RecordingSaved(recordingPath: 'default'));
  }

  void stopRecording() {
    emit(const RecordingStopped());
  }

  void recordingError(String message) {
    emit(RecordingError(message));
  }
}
