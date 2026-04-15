import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/app_dimensions.dart';
import 'text_to_audio/text_to_audio_cubit.dart';
import 'text_to_audio/text_to_audio_state.dart';

class TextToAudioScreen extends StatefulWidget {
  const TextToAudioScreen({super.key});

  @override
  State<TextToAudioScreen> createState() => _TextToAudioScreenState();
}

class _TextToAudioScreenState extends State<TextToAudioScreen> {
  String _selectedLanguage = 'English';
  double _speed = 1.0;
  double _pitch = 0.0;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text to Audio')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language selector
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        'English',
                        'Spanish',
                        'French',
                        'German',
                        'Italian'
                      ]
                          .map((lang) => ListTile(
                                title: Text(lang),
                                onTap: () {
                                  setState(() => _selectedLanguage = lang);
                                  context
                                      .read<TextToAudioCubit>()
                                      .updateLanguage(lang);
                                  Navigator.pop(context);
                                },
                              ))
                          .toList(),
                    ),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_selectedLanguage),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),

            // Text input
            TextField(
              controller: _textController,
              maxLength: 200,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Type something...',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                counterText: '${_textController.text.length}/200',
              ),
              onChanged: (value) {
                setState(() {});
                context.read<TextToAudioCubit>().updateText(value);
              },
            ),
            const SizedBox(height: AppDimensions.spacing16),

            // Speed control
            Row(
              children: [
                const Text('Speed'),
                Expanded(
                  child: Slider(
                    value: _speed,
                    min: 0.5,
                    max: 2.0,
                    divisions: 15,
                    label: _speed.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() => _speed = value);
                      context.read<TextToAudioCubit>().updateSpeed(value);
                    },
                  ),
                ),
                Text(_speed.toStringAsFixed(1)),
              ],
            ),

            // Pitch control
            Row(
              children: [
                const Text('Pitch'),
                Expanded(
                  child: Slider(
                    value: _pitch,
                    min: -5,
                    max: 5,
                    divisions: 10,
                    label: _pitch.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() => _pitch = value);
                      context.read<TextToAudioCubit>().updatePitch(value);
                    },
                  ),
                ),
                Text(_pitch.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: AppDimensions.spacing20),

            // Convert button
            ElevatedButton.icon(
              onPressed: () {
                context.read<TextToAudioCubit>().convertStart(
                      _textController.text,
                      _selectedLanguage,
                      _speed,
                      _pitch,
                    );
              },
              icon: const Icon(Icons.mic),
              label: const Text('Convert to Speech'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: AppDimensions.spacing16),

            // Action buttons
            BlocBuilder<TextToAudioCubit, TextToAudioState>(
              builder: (context, state) {
                if (state is TextToAudioConverted) {
                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              context.read<TextToAudioCubit>().playPreview(),
                          child: const Text('Play'),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacing8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context
                                .read<TextToAudioCubit>()
                                .saveToLibrary(state.audioPath);
                          },
                          child: const Text('Save'),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacing8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Share.shareFiles([state.audioPath]),
                          child: const Text('Share'),
                        ),
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
