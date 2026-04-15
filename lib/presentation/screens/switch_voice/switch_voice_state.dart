part of 'switch_voice_cubit.dart';

class SwitchVoiceState extends Equatable {
  const SwitchVoiceState();

  @override
  List<Object?> get props => [];
}

class SwitchVoiceInitial extends SwitchVoiceState {
  const SwitchVoiceInitial();
}

class SwitchVoiceRecording extends SwitchVoiceState {
  const SwitchVoiceRecording();
}

class SwitchVoiceVoiceSelected extends SwitchVoiceState {
  final String voice;

  const SwitchVoiceVoiceSelected({required this.voice});

  @override
  List<Object?> get props => [voice];
}

class SwitchVoiceProcessing extends SwitchVoiceState {
  final String audioPath;
  final String voice;

  const SwitchVoiceProcessing({required this.audioPath, required this.voice});

  @override
  List<Object?> get props => [audioPath, voice];
}

class SwitchVoiceComplete extends SwitchVoiceState {
  final String outputPath;

  const SwitchVoiceComplete({required this.outputPath});

  @override
  List<Object?> get props => [outputPath];
}

class SwitchVoiceError extends SwitchVoiceState {
  final String message;

  const SwitchVoiceError(this.message);

  @override
  List<Object?> get props => [message];
}
