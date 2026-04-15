part of 'recording_cubit.dart';

class RecordingState extends Equatable {
  const RecordingState();

  @override
  List<Object?> get props => [];
}

class RecordingInitial extends RecordingState {
  const RecordingInitial();
}

class RecordingInProgress extends RecordingState {
  final Duration duration;

  const RecordingInProgress({required this.duration});

  @override
  List<Object?> get props => [duration];
}

class RecordingStopped extends RecordingState {
  const RecordingStopped();
}

class RecordingSaved extends RecordingState {
  final String recordingPath;

  const RecordingSaved({required this.recordingPath});

  @override
  List<Object?> get props => [recordingPath];
}

class RecordingError extends RecordingState {
  final String message;

  const RecordingError(this.message);

  @override
  List<Object?> get props => [message];
}
