import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsInitial());

  void setAudioQuality(String quality) {
    emit(SettingsAudioQualityUpdated(quality: quality));
  }

  void setStorageLocation(String location) {
    emit(SettingsStorageLocationUpdated(location: location));
  }

  void setDefaultEffect(String effectName) {
    emit(SettingsDefaultEffectUpdated(effectName: effectName));
  }

  void setBiometricLock(bool enabled) {
    emit(SettingsBiometricLockUpdated(enabled: enabled));
  }

  void openAdPreferences() {
    emit(const SettingsAdPreferencesOpened());
  }

  void settingsError(String message) {
    emit(SettingsError(message));
  }
}
