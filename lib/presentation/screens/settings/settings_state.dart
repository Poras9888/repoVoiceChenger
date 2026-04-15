part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

class SettingsAudioQualityUpdated extends SettingsState {
  final String quality;

  const SettingsAudioQualityUpdated({required this.quality});

  @override
  List<Object?> get props => [quality];
}

class SettingsStorageLocationUpdated extends SettingsState {
  final String location;

  const SettingsStorageLocationUpdated({required this.location});

  @override
  List<Object?> get props => [location];
}

class SettingsDefaultEffectUpdated extends SettingsState {
  final String effectName;

  const SettingsDefaultEffectUpdated({required this.effectName});

  @override
  List<Object?> get props => [effectName];
}

class SettingsBiometricLockUpdated extends SettingsState {
  final bool enabled;

  const SettingsBiometricLockUpdated({required this.enabled});

  @override
  List<Object?> get props => [enabled];
}

class SettingsAdPreferencesOpened extends SettingsState {
  const SettingsAdPreferencesOpened();
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
