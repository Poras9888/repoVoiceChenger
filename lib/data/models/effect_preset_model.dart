import 'package:equatable/equatable.dart';

class EffectPresetModel extends Equatable {
  final String id;
  final String name;
  final String category;
  final double pitchShift;
  final double speed;
  final double reverb;
  final double distortion;
  final bool isUnlocked;

  const EffectPresetModel({
    required this.id,
    required this.name,
    required this.category,
    required this.pitchShift,
    required this.speed,
    required this.reverb,
    required this.distortion,
    required this.isUnlocked,
  });

  EffectPresetModel copyWith({
    String? id,
    String? name,
    String? category,
    double? pitchShift,
    double? speed,
    double? reverb,
    double? distortion,
    bool? isUnlocked,
  }) {
    return EffectPresetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      pitchShift: pitchShift ?? this.pitchShift,
      speed: speed ?? this.speed,
      reverb: reverb ?? this.reverb,
      distortion: distortion ?? this.distortion,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        pitchShift,
        speed,
        reverb,
        distortion,
        isUnlocked,
      ];
}
