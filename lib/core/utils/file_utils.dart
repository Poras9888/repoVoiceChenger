import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';

class FileUtils {
  FileUtils._();

  /// Get the recordings directory (creates if needed)
  static Future<Directory> getRecordingsDirectory() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final recordingsDir =
        Directory('${appDocDir.path}/${AppConstants.recordingsDirectoryName}');
    if (!await recordingsDir.exists()) {
      await recordingsDir.create(recursive: true);
    }
    return recordingsDir;
  }

  /// Get the temporary directory (creates if needed)
  static Future<Directory> getTemporaryDirectory() async {
    final tempDir = await getTemporaryDirectory();
    final voiceChangerTempDir = Directory('${tempDir.path}/${AppConstants.temporaryDirectoryName}');
    if (!await voiceChangerTempDir.exists()) {
      await voiceChangerTempDir.create(recursive: true);
    }
    return voiceChangerTempDir;
  }

  /// Generate a unique filename for a recording
  static String generateRecordingFilename({String prefix = 'recording'}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$prefix\_$timestamp${AppConstants.defaultAudioFormat}';
  }

  /// Get file size in MB
  static Future<double> getFileSizeInMb(String filePath) async {
    final file = File(filePath);
    final size = await file.length();
    return size / (1024 * 1024);
  }

  /// Delete a file
  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Clear all files in a directory
  static Future<void> clearDirectory(Directory directory) async {
    if (await directory.exists()) {
      directory.listSync().forEach((entity) {
        if (entity is File) {
          entity.deleteSync();
        }
      });
    }
  }

  /// Check if file exists
  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  /// Get all recordings
  static Future<List<File>> getAllRecordings() async {
    final dir = await getRecordingsDirectory();
    final files = dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith(AppConstants.defaultAudioFormat))
        .toList();
    files.sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
    return files;
  }

  /// Rename a file
  static Future<String> renameFile(String oldPath, String newName) async {
    final file = File(oldPath);
    final dir = file.parent;
    final newPath = '${dir.path}/$newName';
    try {
      final renamedFile = await file.rename(newPath);
      return renamedFile.path;
    } catch (e) {
      return oldPath;
    }
  }
}
