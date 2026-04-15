import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class AudioUtils {
  AudioUtils._();

  /// Convert bytes to 16-bit PCM samples
  static List<double> bytesToSamples(Uint8List bytes) {
    final samples = <double>[];
    for (int i = 0; i < bytes.length - 1; i += 2) {
      final sample = bytes[i] | (bytes[i + 1] << 8);
      final shortSample = (sample > 32767) ? sample - 65536 : sample;
      samples.add(shortSample / 32768.0);
    }
    return samples;
  }

  /// Convert samples to 16-bit PCM bytes
  static Uint8List samplesToBytes(List<double> samples) {
    final bytes = Uint8List(samples.length * 2);
    for (int i = 0; i < samples.length; i++) {
      final sample = (samples[i] * 32767).clamp(-32768, 32767).toInt();
      bytes[i * 2] = sample & 0xFF;
      bytes[i * 2 + 1] = (sample >> 8) & 0xFF;
    }
    return bytes;
  }

  /// Apply soft-clip distortion
  static double applySoftClip(double sample, double amount) {
    if (amount <= 0) return sample;
    final clipped = sample * (1 + amount);
    return clipped.clamp(-1.0, 1.0);
  }

  /// Apply simple low-pass filter (single-pole IIR)
  static List<double> applyLowPassFilter(
    List<double> samples,
    double cutoffNormalized,
  ) {
    if (cutoffNormalized <= 0 || cutoffNormalized >= 1) return samples;
    final output = List<double>.from(samples);
    double y = 0;
    const alpha = 0.3; // Simple fixed alpha for demo
    for (int i = 0; i < output.length; i++) {
      y = output[i] * alpha + y * (1 - alpha);
      output[i] = y;
    }
    return output;
  }

  /// Reverse PCM buffer
  static List<double> reverseSamples(List<double> samples) {
    return samples.reversed.toList();
  }

  /// Format duration in MM:SS:ms
  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    final milliseconds = (duration.inMilliseconds % 1000 ~/ 10)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds:$milliseconds';
  }

  /// Format duration in MM:SS
  static String formatDurationSimple(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
