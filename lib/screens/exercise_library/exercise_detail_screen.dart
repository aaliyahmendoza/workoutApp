import 'package:flutter/material.dart';
import '../../models/exercise_library/exercise_data.dart';
import '../../widgets/exercise/countdown_timer.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final ExerciseData exercise;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  int _restTime = 60;
  bool _showTimer = false;
  bool _isFavorited = false;

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildSettingsSheet(),
    );
  }

  Widget _buildSettingsSheet() {
    int tempRestTime = _restTime;

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        'Rest Time Settings',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rest Duration',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${tempRestTime}s',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Slider(
                        value: tempRestTime.toDouble(),
                        min: 15,
                        max: 300,
                        divisions: 57,
                        label: '${tempRestTime}s',
                        onChanged: (value) {
                          setModalState(() {
                            tempRestTime = value.round();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '15s',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '5m',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildPresetButton(context, '30s', 30, tempRestTime,
                              (value) {
                            setModalState(() {
                              tempRestTime = value;
                            });
                          }),
                          const SizedBox(width: 8),
                          _buildPresetButton(context, '60s', 60, tempRestTime,
                              (value) {
                            setModalState(() {
                              tempRestTime = value;
                            });
                          }),
                          const SizedBox(width: 8),
                          _buildPresetButton(context, '90s', 90, tempRestTime,
                              (value) {
                            setModalState(() {
                              tempRestTime = value;
                            });
                          }),
                          const SizedBox(width: 8),
                          _buildPresetButton(context, '120s', 120, tempRestTime,
                              (value) {
                            setModalState(() {
                              tempRestTime = value;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _restTime = tempRestTime;
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Rest time set to ${tempRestTime}s'),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Save Settings',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPresetButton(
    BuildContext context,
    String label,
    int value,
    int currentValue,
    Function(int) onTap,
  ) {
    final isSelected = currentValue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return const Color(0xFF4CAF50);
      case 'intermediate':
        return const Color(0xFFFF9800);
      case 'advanced':
        return const Color(0xFFFF6584);
      default:
        return const Color(0xFF6C63FF);
    }
  }

  String _getMuscleEmoji(String muscle) {
    final muscleLower = muscle.toLowerCase();
    if (muscleLower.contains('chest') || muscleLower.contains('pectoral')) {
      return '💪';
    } else if (muscleLower.contains('leg') || muscleLower.contains('quad') ||
               muscleLower.contains('hamstring') || muscleLower.contains('calves')) {
      return '🦵';
    } else if (muscleLower.contains('back') || muscleLower.contains('lats')) {
      return '🔙';
    } else if (muscleLower.contains('shoulder') || muscleLower.contains('deltoid')) {
      return '🏋️';
    } else if (muscleLower.contains('arm') || muscleLower.contains('bicep') ||
               muscleLower.contains('tricep')) {
      return '💪';
    } else if (muscleLower.contains('abs') || muscleLower.contains('abdominal') ||
               muscleLower.contains('core')) {
      return '🔥';
    } else if (muscleLower.contains('glute') || muscleLower.contains('butt')) {
      return '🍑';
    } else if (muscleLower.contains('cardio') || muscleLower.contains('full body')) {
      return '❤️';
    } else {
      return '💯';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildInfoCards(),
                  const SizedBox(height: 24),
                  if (widget.exercise.description != null) ...[
                    _buildDescription(),
                    const SizedBox(height: 24),
                  ],
                  if (widget.exercise.instructions != null &&
                      widget.exercise.instructions!.isNotEmpty) ...[
                    _buildInstructions(),
                    const SizedBox(height: 24),
                  ],
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                  if (_showTimer) ...[
                    CountdownTimer(
                      key: ValueKey(_restTime),
                      initialSeconds: _restTime,
                      onComplete: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Rest time complete!'),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isFavorited ? Icons.favorite : Icons.favorite_border,
              color: _isFavorited ? Colors.red : Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              _isFavorited = !_isFavorited;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isFavorited
                      ? 'Added to favorites'
                      : 'Removed from favorites',
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'exercise_${widget.exercise.id}',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getDifficultyColor(widget.exercise.difficulty),
                  _getDifficultyColor(widget.exercise.difficulty).withOpacity(0.6),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getMuscleEmoji(widget.exercise.targetMuscle),
                    style: const TextStyle(fontSize: 120),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.exercise.targetMuscle.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _getDifficultyColor(widget.exercise.difficulty)
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _getDifficultyColor(widget.exercise.difficulty),
              width: 1.5,
            ),
          ),
          child: Text(
            widget.exercise.difficulty.toUpperCase(),
            style: TextStyle(
              color: _getDifficultyColor(widget.exercise.difficulty),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.exercise.name,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }

  Widget _buildInfoCards() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            icon: Icons.category,
            label: 'Category',
            value: widget.exercise.category,
            color: const Color(0xFF6C63FF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            icon: Icons.sports_gymnastics,
            label: 'Target',
            value: widget.exercise.targetMuscle,
            color: const Color(0xFFFF6584),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            icon: Icons.fitness_center,
            label: 'Equipment',
            value: widget.exercise.equipment,
            color: const Color(0xFF4CAF50),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.exercise.description!,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        ...widget.exercise.instructions!.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _showTimer = !_showTimer;
                  });
                },
                icon: Icon(_showTimer ? Icons.timer_off : Icons.timer),
                label: Text(_showTimer ? 'Hide Timer' : 'Start Rest Timer'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _showSettingsBottomSheet,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Icon(Icons.settings, size: 28),
            ),
          ],
        ),
      ],
    );
  }
}
