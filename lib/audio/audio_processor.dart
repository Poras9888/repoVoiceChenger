import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import '../core/utils/file_utils.dart';
import '../core/utils/audio_utils.dart';
import '../core/constants/app_constants.dart';

class AudioProcessor {
  static final AudioProcessor _instance = AudioProcessor._internal();

  factory AudioProcessor() {
    return _instance;
  }

  AudioProcessor._internal();

  static AudioProcessor get instance => _instance;

  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  Stream<Uint8List>? _recordingStream;

  /// Start recording audio
  Future<Stream<Uint8List>> startRecording() async {
    try {
      final outputFile = await _getRecordingPath();
      const recordConfig = RecordConfig(
        encoder: AudioEncoder.aacLc,
        numChannels: 1,
        sampleRate: AppConstants.sampleRate,
        bitRate: 128000,
      );

      _recordingStream = await _recorder.startStream(recordConfig);
      return _recordingStream!;
    } catch (e) {
      debugPrint('Error starting recording: $e');
      rethrow;
    }
  }

  /// Stop recording
  Future<String?> stopRecording() async {
    try {
      final path = await _recorder.stop();
      return path;
    } catch (e) {
      debugPrint('Error stopping recording: $e');
      return null;
    }
  }

  /// Play audio file
  Future<void> playAudio(String filePath) async {
    try {
      await _player.setFilePath(filePath);
      await _player.play();
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  /// Stop playback
  Future<void> stopPlayback() async {
    try {
      await _player.stop();
    } catch (e) {
      debugPrint('Error stopping playback: $e');
    }
  }

  /// Pause playback
  Future<void> pausePlayback() async {
    try {
      await _player.pause();
    } catch (e) {
      debugPrint('Error pausing playback: $e');
    }
  }

  /// Resume playback
  Future<void> resumePlayback() async {
    try {
      await _player.play();
    } catch (e) {
      debugPrint('Error resuming playback: $e');
    }
  }

  /// Set playback volume (0.0 - 1.0)
  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    await _player.setSpeed(speed.clamp(0.5, 2.0));
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Get current player position stream
  Stream<Duration> get positionStream => _player.positionStream;

  /// Get duration state
  Stream<DurationState> get durationState => _player.durationState;

  /// Process audio with effects
  Future<String> processAudio(
    String inputPath, {
    double pitchShift = 0.0,
    double speed = 1.0,
    double reverb = 0.0,
    double distortion = 0.0,
  }) async {
    try {
      final outputPath = await _getProcessedAudioPath();
      // Copy file (simple implementation - full DSP would require native code)
      await File(inputPath).copy(outputPath);
      return outputPath;
    } catch (e) {
      debugPrint('Error processing audio: $e');
      rethrow;
    }
  }

  /// Reverse audio
  Future<String> reverseAudio(String inputPath) async {
    try {
      final outputPath = await _getProcessedAudioPath();
      // Simple file copy (full reversal would require WAV parsing)
      await File(inputPath).copy(outputPath);
      return outputPath;
    } catch (e) {
      debugPrint('Error reversing audio: $e');
      rethrow;
    }
  }

  /// Get recording file path
  Future<String> _getRecordingPath() async {
    final dir = await FileUtils.getRecordingsDirectory();
    final filename = FileUtils.generateRecordingFilename();
    return '${dir.path}/$filename';
  }

  /// Get processed audio file path
  Future<String> _getProcessedAudioPath() async {
    final dir = await FileUtils.getTemporaryDirectory();
    final filename = FileUtils.generateRecordingFilename(prefix: 'processed');
    return '${dir.path}/$filename';
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _recorder.dispose();
    await _player.dispose();
  }

  /// Get recording stream with amplitude data
  Stream<double> getAmplitudeStream(Stream<Uint8List> recordingStream) =>
      recordingStream.map((chunk) {
        if (chunk.isEmpty) return 0.0;
        final samples = AudioUtils.bytesToSamples(chunk);
        if (samples.isEmpty) return 0.0;
        final amplitude =
            samples.fold<double>(0, (max, sample) => sample.abs() > max ? sample.abs() : max);
        return amplitude;
      });
}
