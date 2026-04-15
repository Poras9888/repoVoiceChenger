part of 'reverse_voice_cubit.dart';

class ReverseVoiceState extends Equatable {
  const ReverseVoiceState();

  @override
  List<Object?> get props => [];
}

class ReverseVoiceInitial extends ReverseVoiceState {
  const ReverseVoiceInitial();
}

class ReverseVoiceRecording extends ReverseVoiceState {
  const ReverseVoiceRecording();
}

class ReverseVoiceProcessing extends ReverseVoiceState {
  final String audioPath;

  const ReverseVoiceProcessing({required this.audioPath});

  @override
  List<Object?> get props => [audioPath];
}

class ReverseVoiceComplete extends ReverseVoiceState {
  final String outputPath;

  const ReverseVoiceComplete({required this.outputPath});

  @override
  List<Object?> get props => [outputPath];
}

class ReverseVoiceError extends ReverseVoiceState {
  final String message;

  const ReverseVoiceError(this.message);

  @override
  List<Object?> get props => [message];
}
