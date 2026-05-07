import 'package:flutter/material.dart';
import '../../models/user_preferences.dart';

class GoalSelectionScreen extends StatefulWidget {
  final FitnessGoal? selectedGoal;
  final Function(FitnessGoal) onGoalSelected;

  const GoalSelectionScreen({
    super.key,
    this.selectedGoal,
    required this.onGoalSelected,
  });

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen>
    with TickerProviderStateMixin {
  FitnessGoal? _selectedGoal;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  final List<GoalOption> _goals = [
    GoalOption(
      goal: FitnessGoal.loseWeight,
      title: 'Lose Weight',
      description: 'Burn calories and shed pounds',
      icon: Icons.trending_down,
      gradient: const [Color(0xFFFF6584), Color(0xFFFF8A9B)],
    ),
    GoalOption(
      goal: FitnessGoal.buildMuscle,
      title: 'Build Muscle',
      description: 'Gain strength and muscle mass',
      icon: Icons.fitness_center,
      gradient: const [Color(0xFF6C63FF), Color(0xFF8E86FF)],
    ),
    GoalOption(
      goal: FitnessGoal.maintainFitness,
      title: 'Maintain Fitness',
      description: 'Stay healthy and active',
      icon: Icons.favorite,
      gradient: const [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    ),
    GoalOption(
      goal: FitnessGoal.increaseEndurance,
      title: 'Increase Endurance',
      description: 'Boost stamina and performance',
      icon: Icons.directions_run,
      gradient: const [Color(0xFFFF9800), Color(0xFFFFB74D)],
    ),
    GoalOption(
      goal: FitnessGoal.general,
      title: 'General Fitness',
      description: 'Overall health and wellness',
      icon: Icons.self_improvement,
      gradient: const [Color(0xFF00BCD4), Color(0xFF4DD0E1)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedGoal = widget.selectedGoal;

    _controllers = List.generate(
      _goals.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 400 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      );
    }).toList();

    for (var controller in _controllers) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectGoal(FitnessGoal goal) {
    setState(() {
      _selectedGoal = goal;
    });
    widget.onGoalSelected(goal);
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
            'What\'s your goal?',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Choose your primary fitness objective',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                return FadeTransition(
                  opacity: _animations[index],
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.3, 0),
                      end: Offset.zero,
                    ).animate(_animations[index]),
                    child: GoalCard(
                      option: _goals[index],
                      isSelected: _selectedGoal == _goals[index].goal,
                      onTap: () => _selectGoal(_goals[index].goal),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GoalOption {
  final FitnessGoal goal;
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  GoalOption({
    required this.goal,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}

class GoalCard extends StatefulWidget {
  final GoalOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: 16),
        transform: Matrix4.identity()
          ..scale(_isPressed ? 0.98 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: widget.isSelected
                ? LinearGradient(
                    colors: widget.option.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: widget.isSelected
                ? null
                : Theme.of(context).cardTheme.color,
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
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? Colors.white.withOpacity(0.2)
                        : widget.option.gradient.first.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    widget.option.icon,
                    size: 32,
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: widget.isSelected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.option.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: widget.isSelected
                                  ? Colors.white.withOpacity(0.9)
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
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
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
