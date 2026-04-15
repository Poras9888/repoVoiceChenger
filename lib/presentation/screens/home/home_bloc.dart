import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../audio/effects/all_effects.dart';
import '../../../audio/effects/voice_effect.dart';
import '../../../domain/usecases/effect_usecases.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllEffectsUseCase getAllEffectsUseCase;

  List<VoiceEffect> allEffects = [];

  HomeBloc({required this.getAllEffectsUseCase}) : super(const HomeInitial()) {
    on<HomeInitializeEvent>(_onInitialize);
    on<HomeRefreshEvent>(_onRefresh);
  }

  Future<void> _onInitialize(HomeInitializeEvent event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      allEffects = await getAllEffectsUseCase();
      emit(const HomeLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefresh(HomeRefreshEvent event, Emitter<HomeState> emit) async {
    try {
      allEffects = await getAllEffectsUseCase();
      emit(const HomeLoaded());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
