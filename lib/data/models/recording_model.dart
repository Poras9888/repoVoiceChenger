import 'package:equatable/equatable.dart';

class RecordingModel extends Equatable {
  final String id;
  final String fileName;
  final String filePath;
  final int duration;
  final String effectName;
  final int createdAt;
  final bool isFavorite;

  const RecordingModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.duration,
    required this.effectName,
    required this.createdAt,
    required this.isFavorite,
  });

  RecordingModel copyWith({
    String? id,
    String? fileName,
    String? filePath,
    int? duration,
    String? effectName,
    int? createdAt,
    bool? isFavorite,
  }) {
    return RecordingModel(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      duration: duration ?? this.duration,
      effectName: effectName ?? this.effectName,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props =>
      [id, fileName, filePath, duration, effectName, createdAt, isFavorite];
}
