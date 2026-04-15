import 'package:drift/drift.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'tables/recordings_table.dart';
import 'daos/recording_dao.dart';
import 'daos/effect_preset_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Recordings, EffectPresets], daos: [RecordingDao, EffectPresetDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle schema migrations here if needed
      },
      beforeOpen: (details) async {
        if (details.wasCreated) {
          // Initialize default effect presets
          await _initializeDefaultEffectPresets();
        }
      },
    );
  }

  Future<void> _initializeDefaultEffectPresets() async {
    final defaultPresets = [
      EffectPresetsCompanion(
        id: const Value('normal'),
        name: const Value('Normal'),
        category: const Value('all'),
        pitchShift: const Value(0.0),
        speed: const Value(1.0),
        reverb: const Value(0.0),
        distortion: const Value(0.0),
        isUnlocked: const Value(true),
      ),
      EffectPresetsCompanion(
        id: const Value('robot'),
        name: const Value('Robot'),
        category: const Value('scary'),
        pitchShift: const Value(0.0),
        speed: const Value(1.0),
        reverb: const Value(0.2),
        distortion: const Value(0.5),
        isUnlocked: const Value(true),
      ),
      EffectPresetsCompanion(
        id: const Value('monster'),
        name: const Value('Monster'),
        category: const Value('scary'),
        pitchShift: const Value(-8.0),
        speed: const Value(1.0),
        reverb: const Value(0.1),
        distortion: const Value(0.3),
        isUnlocked: const Value(true),
      ),
    ];

    for (final preset in defaultPresets) {
      await into(effectPresets).insert(preset);
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'voice_changer.db'));
    if (Platform.isIOS) {
      await applyWorkaroundToOpenSqlite3OnOldDevices();
    }
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
