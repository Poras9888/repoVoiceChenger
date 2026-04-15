sealed class SavedRecordingsEvent {
  const SavedRecordingsEvent();
}

class LoadRecordingsEvent extends SavedRecordingsEvent {
  const LoadRecordingsEvent();
}

class DeleteRecordingEvent extends SavedRecordingsEvent {
  final String recordingId;

  const DeleteRecordingEvent(this.recordingId);
}

class ToggleFavoriteEvent extends SavedRecordingsEvent {
  final String recordingId;
  final bool isFavorite;

  const ToggleFavoriteEvent(this.recordingId, this.isFavorite);
}

class RenameRecordingEvent extends SavedRecordingsEvent {
  final String recordingId;
  final String newName;

  const RenameRecordingEvent(this.recordingId, this.newName);
}

class SortRecordingsEvent extends SavedRecordingsEvent {
  final String sortType; // 'date', 'duration', 'name'

  const SortRecordingsEvent(this.sortType);
}

class SearchRecordingsEvent extends SavedRecordingsEvent {
  final String query;

  const SearchRecordingsEvent(this.query);
}
