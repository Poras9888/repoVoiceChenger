import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/recording_usecases.dart';
import 'saved_recordings_event.dart';
import 'saved_recordings_state.dart';

class SavedRecordingsBloc
    extends Bloc<SavedRecordingsEvent, SavedRecordingsState> {
  final GetRecordingsUseCase getRecordingsUseCase;
  final DeleteRecordingUseCase deleteRecordingUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final SearchRecordingsUseCase searchRecordingsUseCase;

  SavedRecordingsBloc({
    required this.getRecordingsUseCase,
    required this.deleteRecordingUseCase,
    required this.toggleFavoriteUseCase,
    required this.searchRecordingsUseCase,
  }) : super(const SavedRecordingsInitial()) {
    on<LoadRecordingsEvent>(_onLoadRecordings);
    on<DeleteRecordingEvent>(_onDeleteRecording);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<SearchRecordingsEvent>(_onSearchRecordings);
  }

  Future<void> _onLoadRecordings(
    LoadRecordingsEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    emit(const SavedRecordingsLoading());
    try {
      final recordings = await getRecordingsUseCase();
      if (recordings.isEmpty) {
        emit(const SavedRecordingsEmpty());
      } else {
        emit(SavedRecordingsLoaded(recordings));
      }
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }

  Future<void> _onDeleteRecording(
    DeleteRecordingEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    try {
      await deleteRecordingUseCase(event.recordingId);
      final recordings = await getRecordingsUseCase();
      if (recordings.isEmpty) {
        emit(const SavedRecordingsEmpty());
      } else {
        emit(SavedRecordingDeleted(recordings));
      }
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    try {
      await toggleFavoriteUseCase(event.recordingId, event.isFavorite);
      final recordings = await getRecordingsUseCase();
      emit(SavedRecordingFavoriteToggled(recordings));
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }

  Future<void> _onSearchRecordings(
    SearchRecordingsEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    try {
      final results = await searchRecordingsUseCase(event.query);
      emit(SavedRecordingsSearched(results));
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/recording_entity.dart';
import '../../../domain/usecases/recording_usecases.dart';
import 'saved_recordings_event.dart';
import 'saved_recordings_state.dart';

class SavedRecordingsBloc extends Bloc<SavedRecordingsEvent, SavedRecordingsState> {
  final GetRecordingsUseCase getRecordingsUseCase;
  final DeleteRecordingUseCase deleteRecordingUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final SearchRecordingsUseCase searchRecordingsUseCase;

  List<RecordingEntity> _allRecordings = [];

  SavedRecordingsBloc({
    required this.getRecordingsUseCase,
    required this.deleteRecordingUseCase,
    required this.toggleFavoriteUseCase,
    required this.searchRecordingsUseCase,
  }) : super(const SavedRecordingsInitial()) {
    on<LoadRecordingsEvent>(_onLoadRecordings);
    on<DeleteRecordingEvent>(_onDeleteRecording);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<SortRecordingsEvent>(_onSortRecordings);
    on<SearchRecordingsEvent>(_onSearchRecordings);
  }

  Future<void> _onLoadRecordings(
    LoadRecordingsEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    emit(const SavedRecordingsLoading());
    try {
      _allRecordings = await getRecordingsUseCase();
      if (_allRecordings.isEmpty) {
        emit(const SavedRecordingsEmpty());
      } else {
        emit(SavedRecordingsLoaded(_allRecordings));
      }
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }

  Future<void> _onDeleteRecording(
    DeleteRecordingEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    try {
      await deleteRecordingUseCase(event.recordingId);
      _allRecordings.removeWhere((r) => r.id == event.recordingId);
      if (_allRecordings.isEmpty) {
        emit(const SavedRecordingsEmpty());
      } else {
        emit(SavedRecordingDeleted(_allRecordings));
      }
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    try {
      await toggleFavoriteUseCase(event.recordingId, event.isFavorite);
      _allRecordings = _allRecordings
          .map((r) => r.id == event.recordingId ? r.copyWith(isFavorite: event.isFavorite) : r)
          .toList();
      emit(SavedRecordingFavoriteToggled(_allRecordings));
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }

  Future<void> _onSortRecordings(
    SortRecordingsEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    try {
      final sorted = List<RecordingEntity>.from(_allRecordings);
      switch (event.sortType) {
        case 'date':
          sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case 'duration':
          sorted.sort((a, b) => b.duration.compareTo(a.duration));
          break;
        case 'name':
          sorted.sort((a, b) => a.fileName.compareTo(b.fileName));
          break;
      }
      emit(SavedRecordingsLoaded(sorted));
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }

  Future<void> _onSearchRecordings(
    SearchRecordingsEvent event,
    Emitter<SavedRecordingsState> emit,
  ) async {
    try {
      final results = await searchRecordingsUseCase(event.query);
      if (results.isEmpty) {
        emit(const SavedRecordingsEmpty());
      } else {
        emit(SavedRecordingsSearched(results));
      }
    } catch (e) {
      emit(SavedRecordingsError(e.toString()));
    }
  }
}
