import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback? onComplete;
  final VoidCallback? onReset;

  const CountdownTimer({
    super.key,
    required this.initialSeconds,
    this.onComplete,
    this.onReset,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with SingleTickerProviderStateMixin {
  late int _remainingSeconds;
  Timer? _timer;
  bool _isRunning = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_remainingSeconds == 0) {
      _remainingSeconds = widget.initialSeconds;
    }

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _stopTimer();
          widget.onComplete?.call();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = widget.initialSeconds;
      _isRunning = false;
    });
    widget.onReset?.call();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = _remainingSeconds / widget.initialSeconds;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Rest Timer',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _remainingSeconds <= 10
                        ? const Color(0xFFFF6584)
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              ScaleTransition(
                scale: _isRunning ? _pulseAnimation : const AlwaysStoppedAnimation(1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(_remainingSeconds),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: _remainingSeconds <= 10
                                ? const Color(0xFFFF6584)
                                : Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      _remainingSeconds <= 10 ? 'Almost done!' : 'Keep resting',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                context,
                icon: Icons.refresh,
                label: 'Reset',
                onPressed: _resetTimer,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              _buildControlButton(
                context,
                icon: _isRunning ? Icons.pause : Icons.play_arrow,
                label: _isRunning ? 'Pause' : 'Start',
                onPressed: _isRunning ? _stopTimer : _startTimer,
                color: Theme.of(context).colorScheme.primary,
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
    bool isPrimary = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: isPrimary ? 28 : 24),
      label: Text(
        label,
        style: TextStyle(
          fontSize: isPrimary ? 18 : 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? color
            : color.withOpacity(0.1),
        foregroundColor: isPrimary ? Colors.white : color,
        padding: EdgeInsets.symmetric(
          horizontal: isPrimary ? 32 : 24,
          vertical: isPrimary ? 16 : 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
    );
  }
}
