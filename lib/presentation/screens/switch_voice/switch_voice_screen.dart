import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_dimensions.dart';
import 'switch_voice/switch_voice_cubit.dart';
import 'switch_voice/switch_voice_state.dart';

class SwitchVoiceScreen extends StatefulWidget {
  const SwitchVoiceScreen({super.key});

  @override
  State<SwitchVoiceScreen> createState() => _SwitchVoiceScreenState();
}

class _SwitchVoiceScreenState extends State<SwitchVoiceScreen> {
  String _selectedVoice = 'Normal';
  final List<String> _voices = ['Normal', 'High', 'Low', 'Robotic', 'Warm'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch Voice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a voice type:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimensions.spacing12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _voices.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  title: Text(_voices[index]),
                  value: _voices[index],
                  groupValue: _selectedVoice,
                  onChanged: (value) {
                    setState(() => _selectedVoice = value ?? 'Normal');
                    context
                        .read<SwitchVoiceCubit>()
                        .selectVoice(_selectedVoice);
                  },
                );
              },
            ),
            const SizedBox(height: AppDimensions.spacing24),
            ElevatedButton.icon(
              onPressed: () => context.read<SwitchVoiceCubit>().recordVoice(),
              icon: const Icon(Icons.mic),
              label: const Text('Start Recording'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),
            BlocBuilder<SwitchVoiceCubit, SwitchVoiceState>(
              builder: (context, state) {
                if (state is SwitchVoiceComplete) {
                  return Column(
                    children: [
                      const Text('Voice switched successfully!'),
                      const SizedBox(height: AppDimensions.spacing16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Play'),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spacing8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Save'),
                            ),
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
