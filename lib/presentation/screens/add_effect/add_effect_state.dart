part of 'add_effect_cubit.dart';

class AddEffectState extends Equatable {
  const AddEffectState();

  @override
  List<Object?> get props => [];
}

class AddEffectInitial extends AddEffectState {
  const AddEffectInitial();
}

class AddEffectFilteredByCategory extends AddEffectState {
  final EffectCategory category;

  const AddEffectFilteredByCategory({required this.category});

  @override
  List<Object?> get props => [category];
}

class AddEffectSelected extends AddEffectState {
  final VoiceEffect effect;

  const AddEffectSelected({required this.effect});

  @override
  List<Object?> get props => [effect];
}

class AddEffectApplying extends AddEffectState {
  final String audioPath;
  final VoiceEffect effect;

  const AddEffectApplying({required this.audioPath, required this.effect});

  @override
  List<Object?> get props => [audioPath, effect];
}

class AddEffectCompleted extends AddEffectState {
  final String outputPath;

  const AddEffectCompleted({required this.outputPath});

  @override
  List<Object?> get props => [outputPath];
}

class AddEffectError extends AddEffectState {
  final String message;

  const AddEffectError(this.message);

  @override
  List<Object?> get props => [message];
}
