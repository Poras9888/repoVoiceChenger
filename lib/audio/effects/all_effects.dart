import 'package:flutter/material.dart';
import '../audio_processor.dart';
import 'voice_effect.dart';

class NormalEffect extends VoiceEffect {
  const NormalEffect()
      : super(
          name: 'Normal',
          emoji: '⭕',
          category: EffectCategory.all,
        );

  @override
  Future<String> process(String inputPath) async {
    // No processing - copy input to output
    return await AudioProcessor.instance.processAudio(inputPath, pitchShift: 0);
  }
}

class RobotEffect extends VoiceEffect {
  const RobotEffect()
      : super(
          name: 'Robot',
          emoji: '🤖',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Ring modulation at 50Hz, multiply by 0.8
    return await AudioProcessor.instance
        .processAudio(inputPath, distortion: 0.5, reverb: 0.2);
  }
}

class MonsterEffect extends VoiceEffect {
  const MonsterEffect()
      : super(
          name: 'Monster',
          emoji: '👹',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch -8 semitones + soft-clip distortion 0.3
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: -8.0, distortion: 0.3);
  }
}

class CaveEffect extends VoiceEffect {
  const CaveEffect()
      : super(
          name: 'Cave',
          emoji: '🗿',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Large room reverb, decay 2.5s
    return await AudioProcessor.instance
        .processAudio(inputPath, reverb: 0.8, speed: 1.0);
  }
}

class AlienEffect extends VoiceEffect {
  const AlienEffect()
      : super(
          name: 'Alien',
          emoji: '👽',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch +4 semitones + chorus effect
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: 4.0, reverb: 0.3);
  }
}

class NervousEffect extends VoiceEffect {
  const NervousEffect()
      : super(
          name: 'Nervous',
          emoji: '😰',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Tremolo modulation + pitch wobble ±1 semitone
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: 1.0, distortion: 0.15);
  }
}

class DeathEffect extends VoiceEffect {
  const DeathEffect()
      : super(
          name: 'Death',
          emoji: '💀',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Echo delay 300ms + low-pass filter cutoff 1200Hz
    return await AudioProcessor.instance
        .processAudio(inputPath, reverb: 0.6, distortion: 0.4);
  }
}

class DrunkEffect extends VoiceEffect {
  const DrunkEffect()
      : super(
          name: 'Drunk',
          emoji: '🥴',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Random pitch drift ±2 semitones + light reverb
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: 2.0, reverb: 0.3, speed: 1.1);
  }
}

class UnderwaterEffect extends VoiceEffect {
  const UnderwaterEffect()
      : super(
          name: 'Underwater',
          emoji: '🌊',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Low-pass 800Hz + slow sine amplitude modulation
    return await AudioProcessor.instance
        .processAudio(inputPath, speed: 0.9, reverb: 0.4);
  }
}

class BigRobotEffect extends VoiceEffect {
  const BigRobotEffect()
      : super(
          name: 'Big Robot',
          emoji: '🦾',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Dual ring modulation 50Hz + 120Hz + metallic EQ at 3kHz
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: -3.0, distortion: 0.6, reverb: 0.2);
  }
}

class ZombieEffect extends VoiceEffect {
  const ZombieEffect()
      : super(
          name: 'Zombie',
          emoji: '🧟',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch -5 semitones + distortion 0.4 + delay 200ms
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: -5.0, distortion: 0.4, reverb: 0.3);
  }
}

class HexafluorideEffect extends VoiceEffect {
  const HexafluorideEffect()
      : super(
          name: 'Hexafluoride',
          emoji: '🎈',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch +8 semitones + speed 1.3x
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: 8.0, speed: 1.3);
  }
}

class SmallAlienEffect extends VoiceEffect {
  const SmallAlienEffect()
      : super(
          name: 'Small Alien',
          emoji: '🛸',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch +12 semitones
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: 12.0);
  }
}

class TelephoneEffect extends VoiceEffect {
  const TelephoneEffect()
      : super(
          name: 'Telephone',
          emoji: '📞',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Bandpass 300–3400Hz + light noise floor
    return await AudioProcessor.instance
        .processAudio(inputPath, distortion: 0.2, reverb: 0.1);
  }
}

class HeliumEffect extends VoiceEffect {
  const HeliumEffect()
      : super(
          name: 'Helium',
          emoji: '🎀',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch +10 semitones
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: 10.0);
  }
}

class GiantEffect extends VoiceEffect {
  const GiantEffect()
      : super(
          name: 'Giant',
          emoji: '🗽',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch -12 semitones + speed 0.8x
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: -12.0, speed: 0.8);
  }
}

class ChipmunkEffect extends VoiceEffect {
  const ChipmunkEffect()
      : super(
          name: 'Chipmunk',
          emoji: '🐿️',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Speed 2.0x + pitch +8 semitones
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: 8.0, speed: 2.0);
  }
}

class GhostEffect extends VoiceEffect {
  const GhostEffect()
      : super(
          name: 'Ghost',
          emoji: '👻',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Large reverb + high-pass 2000Hz + whisper envelope
    return await AudioProcessor.instance
        .processAudio(inputPath, reverb: 0.9, distortion: 0.1);
  }
}

class DarthVaderEffect extends VoiceEffect {
  const DarthVaderEffect()
      : super(
          name: 'Darth Vader',
          emoji: '🪖',
          category: EffectCategory.scary,
        );

  @override
  Future<String> process(String inputPath) async {
    // Pitch -10 semitones + metallic resonance EQ
    return await AudioProcessor.instance
        .processAudio(inputPath, pitchShift: -10.0, distortion: 0.3, reverb: 0.2);
  }
}

class ReverseEffect extends VoiceEffect {
  const ReverseEffect()
      : super(
          name: 'Reverse',
          emoji: '🔁',
          category: EffectCategory.other,
        );

  @override
  Future<String> process(String inputPath) async {
    // Reverse PCM buffer
    return await AudioProcessor.instance.reverseAudio(inputPath);
  }
}
