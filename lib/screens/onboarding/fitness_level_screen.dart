import 'package:flutter/material.dart';
import '../../models/user_preferences.dart';

class FitnessLevelScreen extends StatefulWidget {
  final FitnessLevel? selectedLevel;
  final Function(FitnessLevel) onLevelSelected;

  const FitnessLevelScreen({
    super.key,
    this.selectedLevel,
    required this.onLevelSelected,
  });

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  FitnessLevel? _selectedLevel;

  final List<LevelOption> _levels = [
    LevelOption(
      level: FitnessLevel.beginner,
      title: 'Beginner',
      description: 'New to fitness or returning after a break',
      details: '0-6 months of experience',
      icon: Icons.emoji_people,
      gradient: const [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    ),
    LevelOption(
      level: FitnessLevel.intermediate,
      title: 'Intermediate',
      description: 'Regular workout routine established',
      details: '6-24 months of experience',
      icon: Icons.directions_run,
      gradient: const [Color(0xFF6C63FF), Color(0xFF8E86FF)],
    ),
    LevelOption(
      level: FitnessLevel.advanced,
      title: 'Advanced',
      description: 'Experienced athlete with strong foundation',
      details: '2+ years of experience',
      icon: Icons.emoji_events,
      gradient: const [Color(0xFFFF6584), Color(0xFFFF8A9B)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.selectedLevel;
  }

  void _selectLevel(FitnessLevel level) {
    setState(() {
      _selectedLevel = level;
    });
    widget.onLevelSelected(level);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            'Fitness Level',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Select your current fitness experience',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: _levels.length,
              itemBuilder: (context, index) {
                return LevelCard(
                  option: _levels[index],
                  isSelected: _selectedLevel == _levels[index].level,
                  onTap: () => _selectLevel(_levels[index].level),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LevelOption {
  final FitnessLevel level;
  final String title;
  final String description;
  final String details;
  final IconData icon;
  final List<Color> gradient;

  LevelOption({
    required this.level,
    required this.title,
    required this.description,
    required this.details,
    required this.icon,
    required this.gradient,
  });
}

class LevelCard extends StatefulWidget {
  final LevelOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<LevelCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            gradient: widget.isSelected
                ? LinearGradient(
                    colors: widget.option.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color:
                widget.isSelected ? null : Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isSelected
                  ? Colors.transparent
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              width: 2,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: widget.option.gradient.first.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: widget.isSelected
                            ? Colors.white.withOpacity(0.2)
                            : widget.option.gradient.first.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        widget.option.icon,
                        size: 36,
                        color: widget.isSelected
                            ? Colors.white
                            : widget.option.gradient.first,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.option.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: 24,
                                  color: widget.isSelected
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.option.details,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: widget.isSelected
                                      ? Colors.white.withOpacity(0.8)
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      widget.isSelected
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: widget.isSelected
                          ? Colors.white
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.3),
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.option.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: widget.isSelected
                            ? Colors.white.withOpacity(0.9)
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
