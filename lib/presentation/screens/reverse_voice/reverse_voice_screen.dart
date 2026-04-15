import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_dimensions.dart';
import '../widgets/waveform_painter.dart';
import 'reverse_voice/reverse_voice_cubit.dart';
import 'reverse_voice/reverse_voice_state.dart';

class ReverseVoiceScreen extends StatefulWidget {
  const ReverseVoiceScreen({super.key});

  @override
  State<ReverseVoiceScreen> createState() => _ReverseVoiceScreenState();
}

class _ReverseVoiceScreenState extends State<ReverseVoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reverse Voice')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Record your voice and we\'ll play it backwards!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: AppDimensions.spacing32),
            ElevatedButton.icon(
              onPressed: () => context.read<ReverseVoiceCubit>().recordVoice(),
              icon: const Icon(Icons.mic),
              label: const Text('Start Recording'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 48),
              ),
            ),
            const SizedBox(height: AppDimensions.spacing20),
            BlocBuilder<ReverseVoiceCubit, ReverseVoiceState>(
              builder: (context, state) {
                if (state is ReverseVoiceComplete) {
                  return Column(
                    children: [
                      const Text('Reversed audio ready!'),
                      const SizedBox(height: AppDimensions.spacing16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Play'),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
