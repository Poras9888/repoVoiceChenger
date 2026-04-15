import '../entities/recording_entity.dart';

abstract class RecordingRepository {
  Future<String> saveRecording({
    required String fileName,
    required String filePath,
    required int duration,
    required String effectName,
  });

  Future<List<RecordingEntity>> getRecordings();
  Future<List<RecordingEntity>> getFavoriteRecordings();
  Future<RecordingEntity?> getRecordingById(String id);
  Future<void> deleteRecording(String id);
  Future<void> deleteAllRecordings();
  Future<void> toggleFavorite(String id, bool isFavorite);
  Future<List<RecordingEntity>> searchRecordings(String query);
  Future<void> renameRecording(String id, String newName);
}

class SaveRecordingUseCase {
  final RecordingRepository repository;

  SaveRecordingUseCase({required this.repository});

  Future<String> call({
    required String fileName,
    required String filePath,
    required int duration,
    required String effectName,
  }) {
    return repository.saveRecording(
      fileName: fileName,
      filePath: filePath,
      duration: duration,
      effectName: effectName,
    );
  }
}

class GetRecordingsUseCase {
  final RecordingRepository repository;

  GetRecordingsUseCase({required this.repository});

  Future<List<RecordingEntity>> call() {
    return repository.getRecordings();
  }
}

class GetFavoriteRecordingsUseCase {
  final RecordingRepository repository;

  GetFavoriteRecordingsUseCase({required this.repository});

  Future<List<RecordingEntity>> call() {
    return repository.getFavoriteRecordings();
  }
}

class DeleteRecordingUseCase {
  final RecordingRepository repository;

  DeleteRecordingUseCase({required this.repository});

  Future<void> call(String id) {
    return repository.deleteRecording(id);
  }
}

class DeleteAllRecordingsUseCase {
  final RecordingRepository repository;

  DeleteAllRecordingsUseCase({required this.repository});

  Future<void> call() {
    return repository.deleteAllRecordings();
  }
}

class ToggleFavoriteUseCase {
  final RecordingRepository repository;

  ToggleFavoriteUseCase({required this.repository});

  Future<void> call(String id, bool isFavorite) {
    return repository.toggleFavorite(id, isFavorite);
  }
}

class SearchRecordingsUseCase {
  final RecordingRepository repository;

  SearchRecordingsUseCase({required this.repository});

  Future<List<RecordingEntity>> call(String query) {
    return repository.searchRecordings(query);
  }
}
