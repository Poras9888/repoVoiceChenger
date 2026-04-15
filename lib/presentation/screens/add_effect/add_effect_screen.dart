import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../audio/effects/voice_effect.dart';
import '../widgets/custom_cards.dart';
import 'add_effect/add_effect_cubit.dart';
import 'add_effect/add_effect_state.dart';

class AddEffectScreen extends StatefulWidget {
  const AddEffectScreen({super.key});

  @override
  State<AddEffectScreen> createState() => _AddEffectScreenState();
}

class _AddEffectScreenState extends State<AddEffectScreen> {
  EffectCategory _selectedCategory = EffectCategory.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Effect'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Player bar
          Container(
            color: AppColors.skyBlue,
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.pause, color: AppColors.white),
                  onPressed: () {},
                ),
                const Text(
                  '00:04',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: 0.3,
                    onChanged: (value) {},
                    activeColor: AppColors.white,
                    inactiveColor: AppColors.white.withOpacity(0.3),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_off, color: AppColors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Category filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing12,
            ),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All Effects'),
                  selected: _selectedCategory == EffectCategory.all,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = EffectCategory.all;
                    });
                    context
                        .read<AddEffectCubit>()
                        .filterByCategory(EffectCategory.all);
                  },
                ),
                const SizedBox(width: AppDimensions.spacing8),
                FilterChip(
                  label: const Text('Scary Effects'),
                  selected: _selectedCategory == EffectCategory.scary,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = EffectCategory.scary;
                    });
                    context
                        .read<AddEffectCubit>()
                        .filterByCategory(EffectCategory.scary);
                  },
                ),
                const SizedBox(width: AppDimensions.spacing8),
                FilterChip(
                  label: const Text('Other Effects'),
                  selected: _selectedCategory == EffectCategory.other,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = EffectCategory.other;
                    });
                    context
                        .read<AddEffectCubit>()
                        .filterByCategory(EffectCategory.other);
                  },
                ),
              ],
            ),
          ),

          // Effects grid
          Expanded(
            child: BlocBuilder<AddEffectCubit, AddEffectState>(
              builder: (context, state) {
                return GridView.builder(
                  padding: const EdgeInsets.all(AppDimensions.spacing16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: AppDimensions.spacing10,
                    mainAxisSpacing: AppDimensions.spacing10,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    final effects = [
                      'Normal', 'Robot', 'Monster', 'Cave', 'Alien',
                      'Nervous', 'Death', 'Drunk', 'Underwater', 'Big Robot',
                      'Zombie', 'Hexafluoride', 'Small Alien', 'Telephone',
                      'Helium', 'Giant', 'Chipmunk', 'Ghost', 'Darth Vader',
                      'Reverse'
                    ];
                    final emojis = [
                      '⭕', '🤖', '👹', '🗿', '👽',
                      '😰', '💀', '🥴', '🌊', '🦾',
                      '🧟', '🎈', '🛸', '📞',
                      '🎀', '🗽', '🐿️', '👻', '🪖',
                      '🔁'
                    ];
                    return EffectCard(
                      emoji: emojis[index],
                      name: effects[index],
                      isSelected: state is AddEffectSelected,
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),

          // Apply button
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spacing16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Apply Effect'),
            ),
          ),
        ],
      ),
    );
  }
}
