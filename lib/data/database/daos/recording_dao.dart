import 'package:drift/drift.dart';
import '../tables/recordings_table.dart';

part 'recording_dao.g.dart';

@DriftAccessor(tables: [Recordings])
class RecordingDao extends DatabaseAccessor<Recordings> {
  RecordingDao(super.db);

  Future<List<RecordingData>> getAllRecordings() => select(recordings).get();

  Future<List<RecordingData>> getRecordingsByFavorite(bool isFavorite) =>
      (select(recordings)..where((r) => r.isFavorite.equals(isFavorite)))
          .get();

  Future<RecordingData?> getRecordingById(String id) =>
      (select(recordings)..where((r) => r.id.equals(id))).getSingleOrNull();

  Future<int> insertRecording(RecordingsCompanion recording) =>
      into(recordings).insert(recording);

  Future<bool> updateRecording(RecordingsCompanion recording) =>
      update(recordings).replace(recording);

  Future<bool> deleteRecording(String id) =>
      (delete(recordings)..where((r) => r.id.equals(id))).go();

  Future<int> deleteAllRecordings() => delete(recordings).go();

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    final recording = await getRecordingById(id);
    if (recording != null) {
      await update(recordings).replace(
        recording.copyWith(isFavorite: isFavorite),
      );
    }
  }

  Future<List<RecordingData>> searchRecordingsByName(String query) =>
      (select(recordings)..where((r) => r.fileName.like('%$query%'))).get();
}
