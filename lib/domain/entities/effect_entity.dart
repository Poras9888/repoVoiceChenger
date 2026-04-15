import 'package:equatable/equatable.dart';

class EffectEntity extends Equatable {
  final String id;
  final String name;
  final String emoji;
  final String category;
  final double pitchShift;
  final double speed;
  final double reverb;
  final double distortion;

  const EffectEntity({
    required this.id,
    required this.name,
    required this.emoji,
    required this.category,
    required this.pitchShift,
    required this.speed,
    required this.reverb,
    required this.distortion,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        emoji,
        category,
        pitchShift,
        speed,
        reverb,
        distortion,
      ];
}
