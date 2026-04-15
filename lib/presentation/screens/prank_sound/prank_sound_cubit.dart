import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'prank_sound_state.dart';

class PrankSoundCubit extends Cubit<PrankSoundState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  double _volume = 1.0;
  bool _isLooping = false;
  Duration _delay = Duration.zero;

  PrankSoundCubit() : super(const PrankSoundInitial());

  Future<void> playSound(String assetPath) async {
    emit(const PrankSoundPlaying());
    try {
      await audioPlayer.setAsset(assetPath);
      await audioPlayer.play();
    } catch (e) {
      emit(PrankSoundError(e.toString()));
    }
  }

  Future<void> stopSound() async {
    await audioPlayer.stop();
    emit(const PrankSoundStopped());
  }

  Future<void> setVolume(double volume) async {
    _volume = volume;
    await audioPlayer.setVolume(volume);
    emit(PrankSoundVolumeChanged(volume));
  }

  Future<void> setLooping(bool loop) async {
    _isLooping = loop;
    await audioPlayer.setLoopMode(loop ? LoopMode.one : LoopMode.off);
    emit(PrankSoundLoopingChanged(loop));
  }

  void setDelay(Duration delay) {
    _delay = delay;
    emit(PrankSoundDelayChanged(delay));
  }

  Future<void> startHiddenMode() async {
    emit(const PrankSoundHiddenMode());
  }

  @override
  Future<void> close() async {
    await audioPlayer.dispose();
    return super.close();
  }
}
