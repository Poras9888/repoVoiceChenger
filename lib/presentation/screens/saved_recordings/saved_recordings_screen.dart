import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/ads/banner_ad_widget.dart';
import 'saved_recordings/saved_recordings_bloc.dart';
import 'saved_recordings/saved_recordings_event.dart';
import 'saved_recordings/saved_recordings_state.dart';

class SavedRecordingsScreen extends StatefulWidget {
  const SavedRecordingsScreen({super.key});

  @override
  State<SavedRecordingsScreen> createState() => _SavedRecordingsScreenState();
}

class _SavedRecordingsScreenState extends State<SavedRecordingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SavedRecordingsBloc>().add(const LoadRecordingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Recordings'),
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem(
                child: Text('Sort by Duration'),
              ),
              const PopupMenuItem(
                child: Text('Sort by Name'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<SavedRecordingsBloc, SavedRecordingsState>(
        builder: (context, state) {
          if (state is SavedRecordingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SavedRecordingsEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mic_off, size: 64, color: AppColors.textHint),
                  const SizedBox(height: AppDimensions.spacing16),
                  Text(
                    'No recordings yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppDimensions.spacing8),
                  Text(
                    'Record your voice and apply effects to get started',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            );
          }

          if (state is SavedRecordingsLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.spacing16),
              itemCount: state.recordings.length,
              itemBuilder: (context, index) {
                final recording = state.recordings[index];
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ListView(
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: const Text('Rename'),
                            onTap: () => Navigator.pop(context),
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text('Delete'),
                            onTap: () {
                              context.read<SavedRecordingsBloc>().add(
                                    DeleteRecordingEvent(recording.id),
                                  );
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.share),
                            title: const Text('Share'),
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.graphic_eq,
                          color: AppColors.skyBlue),
                      title: Text(recording.fileName),
                      subtitle: Text(
                          '${recording.effectName} • ${recording.duration}ms'),
                      trailing: IconButton(
                        icon: Icon(
                          recording.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: recording.isFavorite
                              ? AppColors.coral
                              : AppColors.textSecondary,
                        ),
                        onPressed: () {
                          context.read<SavedRecordingsBloc>().add(
                                ToggleFavoriteEvent(
                                  recording.id,
                                  !recording.isFavorite,
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('An error occurred'),
          );
        },
      ),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
