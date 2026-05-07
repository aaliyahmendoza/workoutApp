import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularWorkoutTimer extends StatefulWidget {
  final int totalSeconds;
  final int remainingSeconds;
  final bool isRestPeriod;
  final VoidCallback? onComplete;
  final String label;

  const CircularWorkoutTimer({
    super.key,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.isRestPeriod = false,
    this.onComplete,
    this.label = '',
  });

  @override
  State<CircularWorkoutTimer> createState() => _CircularWorkoutTimerState();
}

class _CircularWorkoutTimerState extends State<CircularWorkoutTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Color _getTimerColor() {
    if (widget.isRestPeriod) {
      return const Color(0xFF4CAF50); // Green for rest
    }
    if (widget.remainingSeconds <= 10) {
      return const Color(0xFFFF6584); // Red for warning
    }
    return const Color(0xFF6C63FF); // Primary color
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.totalSeconds > 0
        ? widget.remainingSeconds / widget.totalSeconds
        : 0.0;

    final timerColor = _getTimerColor();

    return Container(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          CustomPaint(
            size: const Size(280, 280),
            painter: CircularProgressPainter(
              progress: 1.0,
              color: timerColor.withOpacity(0.1),
              strokeWidth: 16,
            ),
          ),
          // Progress circle
          CustomPaint(
            size: const Size(280, 280),
            painter: CircularProgressPainter(
              progress: progress,
              color: timerColor,
              strokeWidth: 16,
            ),
          ),
          // Moving indicator
          CustomPaint(
            size: const Size(280, 280),
            painter: MovingIndicatorPainter(
              progress: progress,
              color: timerColor,
              radius: 140,
            ),
          ),
          // Center content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.label.isNotEmpty) ...[
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 8),
              ],
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (_pulseController.value * 0.05),
                    child: Text(
                      _formatTime(widget.remainingSeconds),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 64,
                            fontWeight: FontWeight.w800,
                            color: timerColor,
                            height: 1.0,
                          ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: timerColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.isRestPeriod ? 'REST TIME' : 'EXERCISE TIME',
                  style: TextStyle(
                    color: timerColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class MovingIndicatorPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double radius;

  MovingIndicatorPainter({
    required this.progress,
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    const startAngle = -math.pi / 2;
    final currentAngle = startAngle + (2 * math.pi * progress);

    final indicatorX = center.dx + radius * math.cos(currentAngle);
    final indicatorY = center.dy + radius * math.sin(currentAngle);
    final indicatorCenter = Offset(indicatorX, indicatorY);

    final outerPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(indicatorCenter, 16, outerPaint);

    final innerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(indicatorCenter, 10, innerPaint);

    final corePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(indicatorCenter, 4, corePaint);
  }

  @override
  bool shouldRepaint(MovingIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
