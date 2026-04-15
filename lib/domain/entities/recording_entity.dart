import 'package:equatable/equatable.dart';

class RecordingEntity extends Equatable {
  final String id;
  final String fileName;
  final String filePath;
  final int duration;
  final String effectName;
  final int createdAt;
  final bool isFavorite;

  const RecordingEntity({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.duration,
    required this.effectName,
    required this.createdAt,
    required this.isFavorite,
  });

  @override
  List<Object?> get props =>
      [id, fileName, filePath, duration, effectName, createdAt, isFavorite];
}
