import 'package:equatable/equatable.dart';

enum EffectCategory { all, scary, other }

abstract class VoiceEffect extends Equatable {
  final String name;
  final String emoji;
  final EffectCategory category;

  const VoiceEffect({
    required this.name,
    required this.emoji,
    required this.category,
  });

  /// Process audio file and return output file path
  Future<String> process(String inputPath);

  @override
  List<Object?> get props => [name, emoji, category];
}
