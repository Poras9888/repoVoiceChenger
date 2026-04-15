class AppConstants {
  AppConstants._();

  // Audio configuration
  static const int sampleRate = 44100;
  static const int bitDepth = 16;
  static const int maxTtsChars = 200;

  // Database
  static const String databaseName = 'voice_changer.db';

  // Paths
  static const String recordingsDirectoryName = 'recordings';
  static const String temporaryDirectoryName = 'temp';

  // Recording
  static const int maxRecordingDurationMs = 3600000; // 1 hour in milliseconds
  static const String defaultAudioFormat = '.m4a';

  // UI
  static const int gridCrossAxisCount = 3;
  static const int gridCrossAxisCount2 = 2;
  static const int effectCategoryFilterCount = 3; // All, Scary, Other
}
