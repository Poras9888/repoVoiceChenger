import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../../domain/entities/recording_entity.dart';
import '../../domain/usecases/recording_usecases.dart';
import '../database/app_database.dart';
import '../database/tables/recordings_table.dart';
import '../models/recording_model.dart';
import '../../core/utils/file_utils.dart';

class RecordingRepositoryImpl implements RecordingRepository {
  final AppDatabase database;

  RecordingRepositoryImpl({required this.database});

  @override
  Future<String> saveRecording({
    required String fileName,
    required String filePath,
    required int duration,
    required String effectName,
  }) async {
    final id = const Uuid().v4();
    final companion = RecordingsCompanion(
      id: drift.Value(id),
      fileName: drift.Value(fileName),
      filePath: drift.Value(filePath),
      duration: drift.Value(duration),
      effectName: drift.Value(effectName),
      createdAt: drift.Value(DateTime.now().millisecondsSinceEpoch),
      isFavorite: const drift.Value(false),
    );

    await database.recordingDao.insertRecording(companion);
    return id;
  }

  @override
  Future<List<RecordingEntity>> getRecordings() async {
    final recordings = await database.recordingDao.getAllRecordings();
    return recordings.map(_toEntity).toList();
  }

  @override
  Future<List<RecordingEntity>> getFavoriteRecordings() async {
    final recordings = await database.recordingDao.getRecordingsByFavorite(true);
    return recordings.map(_toEntity).toList();
  }

  @override
  Future<RecordingEntity?> getRecordingById(String id) async {
    final recording = await database.recordingDao.getRecordingById(id);
    return recording != null ? _toEntity(recording) : null;
  }

  @override
  Future<void> deleteRecording(String id) async {
    final recording = await database.recordingDao.getRecordingById(id);
    if (recording != null) {
      await FileUtils.deleteFile(recording.filePath);
      await database.recordingDao.deleteRecording(id);
    }
  }

  @override
  Future<void> deleteAllRecordings() async {
    final recordings = await database.recordingDao.getAllRecordings();
    for (final recording in recordings) {
      await FileUtils.deleteFile(recording.filePath);
    }
    await database.recordingDao.deleteAllRecordings();
  }

  @override
  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await database.recordingDao.toggleFavorite(id, isFavorite);
  }

  @override
  Future<List<RecordingEntity>> searchRecordings(String query) async {
    final recordings = await database.recordingDao.searchRecordingsByName(query);
    return recordings.map(_toEntity).toList();
  }

  @override
  Future<void> renameRecording(String id, String newName) async {
    final recording = await database.recordingDao.getRecordingById(id);
    if (recording != null) {
      final updated = recording.copyWith(fileName: newName);
      await database.recordingDao.updateRecording(
        RecordingsCompanion(
          id: drift.Value(updated.id),
          fileName: drift.Value(updated.fileName),
          filePath: drift.Value(updated.filePath),
          duration: drift.Value(updated.duration),
          effectName: drift.Value(updated.effectName),
          createdAt: drift.Value(updated.createdAt),
          isFavorite: drift.Value(updated.isFavorite),
        ),
      );
    }
  }

  RecordingEntity _toEntity(RecordingData data) {
    return RecordingEntity(
      id: data.id,
      fileName: data.fileName,
      filePath: data.filePath,
      duration: data.duration,
      effectName: data.effectName,
      createdAt: data.createdAt,
      isFavorite: data.isFavorite,
    );
  }
}
