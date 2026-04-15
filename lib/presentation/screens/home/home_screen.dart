import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/ads/banner_ad_widget.dart';
import '../../audio/effects/all_effects.dart';
import '../widgets/custom_cards.dart';
import 'home/home_bloc.dart';
import 'home/home_event.dart';
import 'home/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeInitializeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Changer'),
        elevation: 0,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Card
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  child: GradientHeroCard(
                    title: 'Prank Sound',
                    subtitle: 'Let the Prank Begin.',
                    emojiList: const ['🎤'],
                    gradientStart: AppColors.skyBlue,
                    gradientEnd: AppColors.lightBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing16,
                  ),
                  child: ElevatedButton(
                    onPressed: () => context.push('/prank-sound'),
                    child: const Text('Start'),
                  ),
                ),

                // Feature Grid
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  child: GridView.count(
                    crossAxisCount: AppDimensions.gridCrossAxisCount2.toInt(),
                    crossAxisSpacing: AppDimensions.spacing10,
                    mainAxisSpacing: AppDimensions.spacing10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FeatureCard(
                        title: 'Record & Change',
                        subtitle: 'Apply effects to your voice',
                        emoji: '🎤',
                        gradientStart: AppColors.orange,
                        gradientEnd: AppColors.darkOrange,
                        onTap: () => context.push('/recording'),
                      ),
                      FeatureCard(
                        title: 'Text To Audio',
                        subtitle: 'Convert text to speech',
                        emoji: '🎧',
                        gradientStart: AppColors.mediumPurple,
                        gradientEnd: AppColors.deepPurple,
                        onTap: () => context.push('/text-to-audio'),
                      ),
                      FeatureCard(
                        title: 'Reverse Voice',
                        subtitle: 'Play voice backwards',
                        emoji: '🔁',
                        gradientStart: AppColors.hotPink,
                        gradientEnd: AppColors.lightCoral,
                        onTap: () => context.push('/reverse-voice'),
                      ),
                      FeatureCard(
                        title: 'Switch Voice',
                        subtitle: 'Change your voice tone',
                        emoji: '🔊',
                        gradientStart: AppColors.red,
                        gradientEnd: AppColors.darkRed,
                        onTap: () => context.push('/switch-voice'),
                      ),
                    ],
                  ),
                ),

                // Voice Effects Row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing16,
                    vertical: AppDimensions.spacing8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Voice Effects',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      GestureDetector(
                        onTap: () => context.push('/add-effect'),
                        child: Text(
                          'See all',
                          style: AppTextStyles.blueLink12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacing16,
                    ),
                    itemCount: const [
                      NormalEffect(),
                      RobotEffect(),
                      MonsterEffect(),
                      CaveEffect(),
                      AlienEffect(),
                    ].length,
                    itemBuilder: (context, index) {
                      final effects = const [
                        NormalEffect(),
                        RobotEffect(),
                        MonsterEffect(),
                        CaveEffect(),
                        AlienEffect(),
                      ];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacing8,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: AppDimensions.avatarCircle / 2,
                              backgroundColor: AppColors.skyBlue,
                              child: Text(
                                effects[index].emoji,
                                style:
                                    const TextStyle(fontSize: 24,),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spacing4),
                            Text(
                              effects[index].name,
                              style:
                                  Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppDimensions.spacing20),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
