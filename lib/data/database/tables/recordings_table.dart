import 'package:drift/drift.dart';

class Recordings extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  IntColumn get duration => integer()(); // milliseconds
  TextColumn get effectName => text()();
  IntColumn get createdAt =>
      integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class EffectPresets extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text()();
  TextColumn get category => text()(); // scary / funny / other
  RealColumn get pitchShift => real()(); // semitones
  RealColumn get speed => real()(); // 0.5–2.0
  RealColumn get reverb => real()(); // 0.0–1.0
  RealColumn get distortion => real()(); // 0.0–1.0
  BoolColumn get isUnlocked =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
