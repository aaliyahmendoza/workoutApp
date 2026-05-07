import 'package:flutter/material.dart';
import '../../models/exercise_library/exercise_data.dart';
import '../../utils/ui_constants.dart';

class ExerciseTile extends StatelessWidget {
  final ExerciseData exercise;
  final VoidCallback onTap;

  const ExerciseTile({
    super.key,
    required this.exercise,
    required this.onTap,
  });

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _getDifficultyColor(exercise.difficulty).withOpacity(0.2),
                                _getDifficultyColor(exercise.difficulty).withOpacity(0.05),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _getMuscleEmoji(exercise.targetMuscle),
                                  style: const TextStyle(fontSize: 48),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  exercise.targetMuscle.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: _getDifficultyColor(exercise.difficulty),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(exercise.difficulty)
                              .withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          UIConstants.getLevelIcon(exercise.difficulty),
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        exercise.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                              fontSize: 13,
                            ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          _getCategoryIcon(exercise.category),
                          size: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            exercise.targetMuscle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                  fontSize: 11,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        exercise.equipment,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'strength':
        return Icons.fitness_center;
      case 'cardio':
        return Icons.directions_run;
      case 'core':
        return Icons.self_improvement;
      case 'flexibility':
        return Icons.accessibility_new;
      default:
        return Icons.sports_gymnastics;
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
}
