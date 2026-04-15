import 'package:drift/drift.dart';
import '../tables/recordings_table.dart';

part 'effect_preset_dao.g.dart';

@DriftAccessor(tables: [EffectPresets])
class EffectPresetDao extends DatabaseAccessor<EffectPresets> {
  EffectPresetDao(super.db);

  Future<List<EffectPresetsData>> getAllEffectPresets() =>
      select(effectPresets).get();

  Future<List<EffectPresetsData>> getEffectPresetsByCategory(String category) =>
      (select(effectPresets)..where((e) => e.category.equals(category)))
          .get();

  Future<EffectPresetsData?> getEffectPresetById(String id) =>
      (select(effectPresets)..where((e) => e.id.equals(id)))
          .getSingleOrNull();

  Future<EffectPresetsData?> getEffectPresetByName(String name) =>
      (select(effectPresets)..where((e) => e.name.equals(name)))
          .getSingleOrNull();

  Future<int> insertEffectPreset(EffectPresetsCompanion preset) =>
      into(effectPresets).insert(preset);

  Future<bool> updateEffectPreset(EffectPresetsCompanion preset) =>
      update(effectPresets).replace(preset);

  Future<bool> deleteEffectPreset(String id) =>
      (delete(effectPresets)..where((e) => e.id.equals(id))).go();

  Future<int> deleteAllEffectPresets() => delete(effectPresets).go();

  Future<void> toggleUnlock(String id, bool isUnlocked) async {
    final preset = await getEffectPresetById(id);
    if (preset != null) {
      await update(effectPresets).replace(
        preset.copyWith(isUnlocked: isUnlocked),
      );
    }
  }
}
