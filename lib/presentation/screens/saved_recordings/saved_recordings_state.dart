import 'package:equatable/equatable.dart';
import '../../../domain/entities/recording_entity.dart';

sealed class SavedRecordingsState extends Equatable {
  const SavedRecordingsState();

  @override
  List<Object?> get props => [];
}

class SavedRecordingsInitial extends SavedRecordingsState {
  const SavedRecordingsInitial();
}

class SavedRecordingsLoading extends SavedRecordingsState {
  const SavedRecordingsLoading();
}

class SavedRecordingsLoaded extends SavedRecordingsState {
  final List<RecordingEntity> recordings;

  const SavedRecordingsLoaded(this.recordings);

  @override
  List<Object?> get props => [recordings];
}

class SavedRecordingsEmpty extends SavedRecordingsState {
  const SavedRecordingsEmpty();
}

class SavedRecordingsError extends SavedRecordingsState {
  final String message;

  const SavedRecordingsError(this.message);

  @override
  List<Object?> get props => [message];
}

class SavedRecordingDeleted extends SavedRecordingsState {
  final List<RecordingEntity> recordings;

  const SavedRecordingDeleted(this.recordings);

  @override
  List<Object?> get props => [recordings];
}

class SavedRecordingFavoriteToggled extends SavedRecordingsState {
  final List<RecordingEntity> recordings;

  const SavedRecordingFavoriteToggled(this.recordings);

  @override
  List<Object?> get props => [recordings];
}

class SavedRecordingsSearched extends SavedRecordingsState {
  final List<RecordingEntity> results;

  const SavedRecordingsSearched(this.results);

  @override
  List<Object?> get props => [results];
}
import 'package:equatable/equatable.dart';
import '../../../domain/entities/recording_entity.dart';

sealed class SavedRecordingsState extends Equatable {
  const SavedRecordingsState();

  @override
  List<Object?> get props => [];
}

class SavedRecordingsInitial extends SavedRecordingsState {
  const SavedRecordingsInitial();
}

class SavedRecordingsLoading extends SavedRecordingsState {
  const SavedRecordingsLoading();
}

class SavedRecordingsLoaded extends SavedRecordingsState {
  final List<RecordingEntity> recordings;

  const SavedRecordingsLoaded(this.recordings);

  @override
  List<Object?> get props => [recordings];
}

class SavedRecordingsEmpty extends SavedRecordingsState {
  const SavedRecordingsEmpty();
}

class SavedRecordingsError extends SavedRecordingsState {
  final String message;

  const SavedRecordingsError(this.message);

  @override
  List<Object?> get props => [message];
}

class SavedRecordingDeleted extends SavedRecordingsState {
  final List<RecordingEntity> recordings;

  const SavedRecordingDeleted(this.recordings);

  @override
  List<Object?> get props => [recordings];
}

class SavedRecordingFavoriteToggled extends SavedRecordingsState {
  final List<RecordingEntity> recordings;

  const SavedRecordingFavoriteToggled(this.recordings);

  @override
  List<Object?> get props => [recordings];
}

class SavedRecordingsSearched extends SavedRecordingsState {
  final List<RecordingEntity> results;

  const SavedRecordingsSearched(this.results);

  @override
  List<Object?> get props => [results];
}
