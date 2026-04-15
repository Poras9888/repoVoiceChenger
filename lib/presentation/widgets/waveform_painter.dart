import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final Color color;
  final double opacity;

  WaveformPainter({
    required this.amplitudes,
    this.color = AppColors.white,
    this.opacity = 0.85,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (amplitudes.isEmpty) return;

    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = AppDimensions.waveformBarWidth
      ..strokeCap = StrokeCap.round;

    final maxHeight = size.height;
    final barWidth = size.width / amplitudes.length;
    final spacing = AppDimensions.waveformBarSpacing;

    for (int i = 0; i < amplitudes.length; i++) {
      final amplitude = amplitudes[i].clamp(0.0, 1.0);
      final height = amplitude * maxHeight;
      final x = i * barWidth + barWidth / 2;
      final startY = maxHeight / 2 - height / 2;
      final endY = maxHeight / 2 + height / 2;

      canvas.drawLine(Offset(x, startY), Offset(x, endY), paint);
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return amplitudes != oldDelegate.amplitudes ||
        color != oldDelegate.color ||
        opacity != oldDelegate.opacity;
  }
}

class CircularProgressButton extends StatefulWidget {
  final double progress; // 0.0 - 1.0
  final double size;
  final Color progressColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Widget child;
  final double strokeWidth;

  const CircularProgressButton({
    super.key,
    required this.progress,
    required this.size,
    required this.progressColor,
    required this.backgroundColor,
    required this.onPressed,
    required this.child,
    this.strokeWidth = 4.0,
  });

  @override
  State<CircularProgressButton> createState() => _CircularProgressButtonState();
}

class _CircularProgressButtonState extends State<CircularProgressButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: CircularProgressPainter(
                progress: widget.progress,
                progressColor: widget.progressColor,
                backgroundColor: widget.backgroundColor,
                strokeWidth: widget.strokeWidth,
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    // Background circle
    const bgPaint = Paint()
      ..color = Color(0x1F000000)
      ..style = PaintingStyle.stroke;
    bgPaint.strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    progressPaint.strokeWidth = strokeWidth;

    const startAngle = -3.14159 / 2;
    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        progressColor != oldDelegate.progressColor ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}

class AudioVisualizerWidget extends StatefulWidget {
  final Stream<List<double>> amplitudeStream;
  final Color barColor;
  final double barHeight;

  const AudioVisualizerWidget({
    super.key,
    required this.amplitudeStream,
    this.barColor = AppColors.skyBlue,
    this.barHeight = 150,
  });

  @override
  State<AudioVisualizerWidget> createState() => _AudioVisualizerWidgetState();
}

class _AudioVisualizerWidgetState extends State<AudioVisualizerWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<double>>(
      stream: widget.amplitudeStream,
      builder: (context, snapshot) {
        final amplitudes = snapshot.data ?? [];
        return Container(
          height: widget.barHeight,
          color: Colors.transparent,
          child: CustomPaint(
            painter: WaveformPainter(
              amplitudes: amplitudes,
              color: widget.barColor,
            ),
            child: Container(),
          ),
        );
      },
    );
  }
}
