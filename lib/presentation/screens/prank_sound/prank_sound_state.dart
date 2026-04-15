part of 'prank_sound_cubit.dart';

class PrankSoundState extends Equatable {
  const PrankSoundState();

  @override
  List<Object?> get props => [];
}

class PrankSoundInitial extends PrankSoundState {
  const PrankSoundInitial();
}

class PrankSoundPlaying extends PrankSoundState {
  const PrankSoundPlaying();
}

class PrankSoundStopped extends PrankSoundState {
  const PrankSoundStopped();
}

class PrankSoundVolumeChanged extends PrankSoundState {
  final double volume;

  const PrankSoundVolumeChanged(this.volume);

  @override
  List<Object?> get props => [volume];
}

class PrankSoundLoopingChanged extends PrankSoundState {
  final bool isLooping;

  const PrankSoundLoopingChanged(this.isLooping);

  @override
  List<Object?> get props => [isLooping];
}

class PrankSoundDelayChanged extends PrankSoundState {
  final Duration delay;

  const PrankSoundDelayChanged(this.delay);

  @override
  List<Object?> get props => [delay];
}

class PrankSoundHiddenMode extends PrankSoundState {
  const PrankSoundHiddenMode();
}

class PrankSoundError extends PrankSoundState {
  final String message;

  const PrankSoundError(this.message);

  @override
  List<Object?> get props => [message];
}
