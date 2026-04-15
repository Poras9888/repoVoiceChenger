import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../audio/effects/voice_effect.dart';

part 'add_effect_state.dart';

class AddEffectCubit extends Cubit<AddEffectState> {
  AddEffectCubit() : super(const AddEffectInitial());

  void filterByCategory(EffectCategory category) {
    emit(AddEffectFilteredByCategory(category: category));
  }

  void selectEffect(VoiceEffect effect) {
    emit(AddEffectSelected(effect: effect));
  }

  void applyEffect(String audioPath, VoiceEffect effect) {
    emit(AddEffectApplying(audioPath: audioPath, effect: effect));
  }

  void effectApplied(String outputPath) {
    emit(AddEffectCompleted(outputPath: outputPath));
  }

  void effectError(String message) {
    emit(AddEffectError(message));
  }
}
