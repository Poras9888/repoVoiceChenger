import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class EffectCard extends StatefulWidget {
  final String emoji;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const EffectCard({
    super.key,
    required this.emoji,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<EffectCard> createState() => _EffectCardState();
}

class _EffectCardState extends State<EffectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(EffectCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _scaleController.forward();
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _scaleController.reverse();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.05)
            .animate(_scaleController),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusMedium),
            side: BorderSide(
              color: widget.isSelected ? AppColors.skyBlue : Colors.transparent,
              width: 2,
            ),
          ),
          elevation: widget.isSelected ? 4 : 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: AppDimensions.spacing8),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing4),
                child: Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final Color gradientStart;
  final Color gradientEnd;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradientStart,
    required this.gradientEnd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          ),
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.spacing4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(emoji, style: const TextStyle(fontSize: 28)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrankSoundCard extends StatelessWidget {
  final String emoji;
  final String category;
  final VoidCallback onTap;

  const PrankSoundCard({
    super.key,
    required this.emoji,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              category,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class RecordingListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPlay;
  final VoidCallback onLongPress;

  const RecordingListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPlay,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: ListTile(
          leading: Icon(Icons.graphic_eq, color: AppColors.skyBlue),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: onPlay,
          ),
        ),
      ),
    );
  }
}

class GradientHeroCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> emojiList;
  final Color gradientStart;
  final Color gradientEnd;

  const GradientHeroCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emojiList,
    required this.gradientStart,
    required this.gradientEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: const Alignment(0, 0),
          end: const Alignment(1, 1),
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      padding: const EdgeInsets.all(AppDimensions.spacing20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.white.withOpacity(0.75),
                    ),
              ),
            ],
          ),
          Positioned(
            right: AppDimensions.spacing20,
            top: AppDimensions.spacing20,
            child: Text(
              emojiList.isNotEmpty ? emojiList[0] : '🎤',
              style: const TextStyle(fontSize: AppDimensions.iconHero),
            ),
          ),
        ],
      ),
    );
  }
}
