import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/waveform_painter.dart';
import '../recording/recording_cubit.dart';
import '../recording/recording_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatingNotesController;
  final List<double> _amplitudes = List<double>.filled(40, 0.0);

  @override
  void initState() {
    super.initState();
    _floatingNotesController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
    context.read<RecordingCubit>().startRecording();
  }

  @override
  void dispose() {
    _floatingNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkBlue,
              AppColors.lightBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocListener<RecordingCubit, RecordingState>(
          listener: (context, state) {
            if (state is RecordingSaved) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<RecordingCubit, RecordingState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Waveform
                  Expanded(
                    child: Center(
                      child: CustomPaint(
                        painter: WaveformPainter(
                          amplitudes: _amplitudes,
                          color: AppColors.white,
                          opacity: 0.85,
                        ),
                        size: const Size(200, 150),
                      ),
                    ),
                  ),

                  // Floating Notes
                  Expanded(
                    child: Stack(
                      children: [
                        SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset.zero,
                            end: const Offset(0, -0.5),
                          ).animate(_floatingNotesController),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              '♪',
                              style: TextStyle(
                                fontSize: 32,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Timer
                  Center(
                    child: BlocBuilder<RecordingCubit, RecordingState>(
                      builder: (context, state) {
                        String duration = '00:00:00';
                        if (state is RecordingInProgress) {
                          final minutes =
                              state.duration.inMinutes.toString().padLeft(2, '0');
                          final seconds =
                              (state.duration.inSeconds % 60)
                                  .toString()
                                  .padLeft(2, '0');
                          final milliseconds =
                              (state.duration.inMilliseconds % 1000 ~/ 10)
                                  .toString()
                                  .padLeft(2, '0');
                          duration = '$minutes:$seconds:$milliseconds';
                        }
                        return Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        );
                      },
                    ),
                  ),

                  // Controls
                  Padding(
                    padding: const EdgeInsets.all(
                      AppDimensions.spacing20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          backgroundColor: AppColors.white.withOpacity(0.7),
                          onPressed: () {
                            context.read<RecordingCubit>().stopRecording();
                          },
                          child: const Icon(
                            Icons.stop,
                            color: AppColors.skyBlue,
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: AppColors.white,
                          child: const Icon(
                            Icons.check,
                            color: AppColors.skyBlue,
                          ),
                          onPressed: () {
                            context
                                .read<RecordingCubit>()
                                .saveAndApplyEffect('recording_path');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
