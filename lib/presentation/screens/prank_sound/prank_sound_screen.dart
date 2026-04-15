import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/ads/banner_ad_widget.dart';
import '../widgets/custom_cards.dart';
import 'prank_sound/prank_sound_cubit.dart';
import 'prank_sound/prank_sound_state.dart';

class PrankSoundScreen extends StatefulWidget {
  const PrankSoundScreen({super.key});

  @override
  State<PrankSoundScreen> createState() => _PrankSoundScreenState();
}

class _PrankSoundScreenState extends State<PrankSoundScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  double _volume = 1.0;
  bool _isLooping = false;
  Duration _delay = Duration.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sound Prank'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Container
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.skyBlue,
                    AppColors.lightBlue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-0.3, 0),
                      end: const Offset(-0.3, -0.2),
                    ).animate(_animationController),
                    child: const Text('👻',
                        style: TextStyle(fontSize: 48)),
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0, -0.2),
                    ).animate(_animationController),
                    child: const Text('🔊',
                        style: TextStyle(fontSize: 48)),
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.3, 0),
                      end: const Offset(0.3, -0.2),
                    ).animate(_animationController),
                    child: const Text('😂',
                        style: TextStyle(fontSize: 48)),
                  ),
                ],
              ),
            ),

            // Sound grid
            GridView.builder(
              padding: const EdgeInsets.all(AppDimensions.spacing16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppDimensions.spacing10,
                mainAxisSpacing: AppDimensions.spacing10,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                final categories = [
                  'Funny',
                  'Engine',
                  'Fart',
                  'Sneeze',
                  'Snore',
                  'Breaking',
                  'Dog',
                  'Cat',
                  'Cow',
                  'Lion',
                  'Tiger',
                  'Pig'
                ];
                final emojis = [
                  '😂',
                  '⚙️',
                  '💨',
                  '🤧',
                  '😴',
                  '🍾',
                  '🐕',
                  '🐈',
                  '🐄',
                  '🦁',
                  '🐯',
                  '🐷'
                ];
                return PrankSoundCard(
                  emoji: emojis[index],
                  category: categories[index],
                  onTap: () =>
                      context.read<PrankSoundCubit>().playSound('assets/audio/prank_${categories[index].toLowerCase()}_1.mp3'),
                );
              },
            ),

            // Controls
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spacing16),
              child: Column(
                children: [
                  // Volume slider
                  Row(
                    children: [
                      const Text('Volume'),
                      Expanded(
                        child: Slider(
                          value: _volume,
                          onChanged: (value) {
                            setState(() => _volume = value);
                            context
                                .read<PrankSoundCubit>()
                                .setVolume(value);
                          },
                        ),
                      ),
                    ],
                  ),

                  // Looping switch
                  SwitchListTile(
                    title: const Text('Loop'),
                    value: _isLooping,
                    onChanged: (value) {
                      setState(() => _isLooping = value);
                      context.read<PrankSoundCubit>().setLooping(value);
                    },
                  ),

                  // Delay dropdown
                  DropdownButtonFormField<Duration>(
                    value: _delay,
                    items: const [
                      DropdownMenuItem(value: Duration.zero, child: Text('No Delay')),
                      DropdownMenuItem(value: Duration(seconds: 5), child: Text('5 seconds')),
                      DropdownMenuItem(value: Duration(seconds: 10), child: Text('10 seconds')),
                      DropdownMenuItem(value: Duration(seconds: 30), child: Text('30 seconds')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _delay = value);
                        context.read<PrankSoundCubit>().setDelay(value);
                      }
                    },
                  ),

                  const SizedBox(height: AppDimensions.spacing16),

                  // Hidden mode button
                  ElevatedButton(
                    onPressed: () =>
                        context.read<PrankSoundCubit>().startHiddenMode(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Hidden Mode'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
