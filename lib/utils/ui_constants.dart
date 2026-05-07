import 'package:flutter/material.dart';

class UIConstants {
  // Level Icons
  static const Map<String, IconData> levelIcons = {
    'beginner': Icons.person_outline,
    'intermediate': Icons.person,
    'advanced': Icons.workspace_premium,
  };

  // Goal Icons
  static const Map<String, IconData> goalIcons = {
    'loseWeight': Icons.trending_down,
    'buildMuscle': Icons.fitness_center,
    'maintainFitness': Icons.favorite,
    'increaseEndurance': Icons.directions_run,
    'general': Icons.self_improvement,
  };

  // Category Icons
  static const Map<String, IconData> categoryIcons = {
    'strength': Icons.fitness_center,
    'cardio': Icons.directions_run,
    'core': Icons.self_improvement,
    'flexibility': Icons.accessibility_new,
    'general': Icons.sports_gymnastics,
  };

  // Equipment Icons
  static const Map<String, IconData> equipmentIcons = {
    'bodyweight': Icons.accessibility,
    'dumbbell': Icons.fitness_center,
    'barbell': Icons.sports_kabaddi,
    'resistance_band': Icons.expand,
    'pull_up_bar': Icons.vertical_align_center,
    'none': Icons.do_not_disturb_on,
  };

  // Action Icons (Dark Mode Safe)
  static IconData getActionIcon(String action, bool isDarkMode) {
    switch (action) {
      case 'delete':
      case 'trash':
        return Icons.delete_outline;
      case 'close':
        return Icons.close;
      case 'clear':
        return Icons.clear;
      case 'remove':
        return Icons.remove_circle_outline;
      default:
        return Icons.more_vert;
    }
  }

  static Color getActionIconColor(BuildContext context, {bool isDestructive = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDestructive) {
      // Destructive actions (delete, close) - always visible
      return isDark ? const Color(0xFFFF8A9B) : const Color(0xFFFF6584);
    }

    // Regular actions
    return Theme.of(context).colorScheme.onSurface.withOpacity(0.8);
  }

  // Level Colors
  static const Map<String, Color> levelColors = {
    'beginner': Color(0xFF4CAF50),
    'intermediate': Color(0xFFFF9800),
    'advanced': Color(0xFFFF6584),
  };

  // Compact Labels
  static const Map<String, String> compactLabels = {
    'beginner': 'BGN',
    'intermediate': 'INT',
    'advanced': 'ADV',
  };

  static String getCompactLevel(String level) {
    return compactLabels[level.toLowerCase()] ?? level.substring(0, 3).toUpperCase();
  }

  static IconData getLevelIcon(String level) {
    return levelIcons[level.toLowerCase()] ?? Icons.person;
  }

  static Color getLevelColor(String level) {
    return levelColors[level.toLowerCase()] ?? const Color(0xFF6C63FF);
  }
}
