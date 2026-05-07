import 'package:flutter/material.dart';
import '../../models/user_preferences.dart';
import '../../services/database_service.dart';
import '../../services/user_service.dart';
import '../../utils/unit_converter.dart';

class EditProfileScreen extends StatefulWidget {
  final UserPreferences currentPreferences;
  final VoidCallback onReset;

  const EditProfileScreen({
    super.key,
    required this.currentPreferences,
    required this.onReset,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final DatabaseService _dbService = DatabaseService();
  bool _isSaving = false;

  late FitnessGoal? _goal;
  late FitnessLevel? _fitnessLevel;
  late int _age;
  late double _weight;
  late double _height;
  WeightUnit _weightUnit = WeightUnit.kg;
  HeightUnit _heightUnit = HeightUnit.cm;

  @override
  void initState() {
    super.initState();
    final p = widget.currentPreferences;
    _goal = p.goal;
    _fitnessLevel = p.fitnessLevel;
    _age = p.age ?? 25;
    _weight = p.weight ?? 70.0;
    _height = p.height ?? 170.0;
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    final updated = widget.currentPreferences.copyWith(
      goal: _goal,
      fitnessLevel: _fitnessLevel,
      age: _age,
      weight: _weight,
      height: _height,
      updatedAt: DateTime.now(),
    );
    await _dbService.createOrUpdateUserPreferences(updated);
    await UserService().saveProfile(updated);
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated!'), behavior: SnackBarBehavior.floating),
      );
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _resetProfile() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Profile?'),
        content: const Text(
          'This will clear all your preferences and workout plans, and restart setup. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await _dbService.deleteUserPreferences();
      await _dbService.deleteAllWorkoutPlans();
      if (mounted) {
        Navigator.of(context).pop();
        widget.onReset();
      }
    }
  }

  double? get _bmi {
    if (_weight <= 0 || _height <= 0) return null;
    return _weight / ((_height / 100) * (_height / 100));
  }

  String get _bmiCategory {
    final bmi = _bmi;
    if (bmi == null) return '';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            TextButton(
              onPressed: _save,
              child: Text('Save',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeader('Fitness Goal'),
          const SizedBox(height: 12),
          ..._goalOptions(),
          const SizedBox(height: 28),
          _sectionHeader('Body Metrics'),
          const SizedBox(height: 12),
          _buildMetricCard(
            title: 'Age',
            value: '$_age',
            unit: 'years',
            icon: Icons.cake,
            gradient: const [Color(0xFF6C63FF), Color(0xFF8E86FF)],
            child: Column(children: [
              Slider(
                value: _age.toDouble(),
                min: 15,
                max: 80,
                divisions: 65,
                label: '$_age',
                onChanged: (v) => setState(() => _age = v.round()),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('15', style: Theme.of(context).textTheme.bodySmall),
                Text('80', style: Theme.of(context).textTheme.bodySmall),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          _buildMetricCard(
            title: 'Weight',
            value: UnitConverter.getDisplayWeight(_weight, _weightUnit == WeightUnit.kg)
                .toStringAsFixed(1),
            unit: _weightUnit == WeightUnit.kg ? 'kg' : 'lbs',
            icon: Icons.monitor_weight,
            gradient: const [Color(0xFFFF6584), Color(0xFFFF8A9B)],
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ChoiceChip(
                    label: const Text('kg'),
                    selected: _weightUnit == WeightUnit.kg,
                    onSelected: (_) => setState(() => _weightUnit = WeightUnit.kg)),
                const SizedBox(width: 8),
                ChoiceChip(
                    label: const Text('lbs'),
                    selected: _weightUnit == WeightUnit.lbs,
                    onSelected: (_) => setState(() => _weightUnit = WeightUnit.lbs)),
              ]),
              const SizedBox(height: 8),
              Slider(
                value: _weight,
                min: 40,
                max: 150,
                divisions: 220,
                label:
                    '${UnitConverter.getDisplayWeight(_weight, _weightUnit == WeightUnit.kg).toStringAsFixed(1)} ${_weightUnit == WeightUnit.kg ? 'kg' : 'lbs'}',
                onChanged: (v) => setState(() => _weight = v),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(_weightUnit == WeightUnit.kg ? '40 kg' : '88 lbs',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(_weightUnit == WeightUnit.kg ? '150 kg' : '330 lbs',
                    style: Theme.of(context).textTheme.bodySmall),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          _buildMetricCard(
            title: 'Height',
            value: UnitConverter.getDisplayHeight(_height, _heightUnit == HeightUnit.cm)
                .toStringAsFixed(_heightUnit == HeightUnit.cm ? 0 : 1),
            unit: _heightUnit == HeightUnit.cm ? 'cm' : 'in',
            icon: Icons.height,
            gradient: const [Color(0xFF4CAF50), Color(0xFF66BB6A)],
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ChoiceChip(
                    label: const Text('cm'),
                    selected: _heightUnit == HeightUnit.cm,
                    onSelected: (_) => setState(() => _heightUnit = HeightUnit.cm)),
                const SizedBox(width: 8),
                ChoiceChip(
                    label: const Text('in'),
                    selected: _heightUnit == HeightUnit.inches,
                    onSelected: (_) => setState(() => _heightUnit = HeightUnit.inches)),
              ]),
              const SizedBox(height: 8),
              Slider(
                value: _height,
                min: 140,
                max: 220,
                divisions: 80,
                label:
                    '${UnitConverter.getDisplayHeight(_height, _heightUnit == HeightUnit.cm).toStringAsFixed(_heightUnit == HeightUnit.cm ? 0 : 1)} ${_heightUnit == HeightUnit.cm ? 'cm' : 'in'}',
                onChanged: (v) => setState(() => _height = v),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(_heightUnit == HeightUnit.cm ? '140 cm' : '55 in',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(_heightUnit == HeightUnit.cm ? '220 cm' : '87 in',
                    style: Theme.of(context).textTheme.bodySmall),
              ]),
            ]),
          ),
          if (_bmi != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                ]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3), width: 2),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text('BMI: ${_bmi!.toStringAsFixed(1)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(_bmiCategory,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
          ],
          const SizedBox(height: 28),
          _sectionHeader('Fitness Level'),
          const SizedBox(height: 12),
          ..._levelOptions(),
          const SizedBox(height: 40),
          OutlinedButton.icon(
            onPressed: _resetProfile,
            icon: const Icon(Icons.refresh, color: Colors.red),
            label: const Text('Reset & Redo Setup', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) => Text(title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700));

  List<Widget> _goalOptions() {
    final goals = [
      (
        FitnessGoal.loseWeight,
        'Lose Weight',
        'Burn calories and shed pounds',
        Icons.trending_down,
        [const Color(0xFFFF6584), const Color(0xFFFF8A9B)]
      ),
      (
        FitnessGoal.buildMuscle,
        'Build Muscle',
        'Gain strength and muscle mass',
        Icons.fitness_center,
        [const Color(0xFF6C63FF), const Color(0xFF8E86FF)]
      ),
      (
        FitnessGoal.maintainFitness,
        'Maintain Fitness',
        'Stay healthy and active',
        Icons.favorite,
        [const Color(0xFF4CAF50), const Color(0xFF66BB6A)]
      ),
      (
        FitnessGoal.increaseEndurance,
        'Increase Endurance',
        'Boost stamina and performance',
        Icons.directions_run,
        [const Color(0xFFFF9800), const Color(0xFFFFB74D)]
      ),
      (
        FitnessGoal.general,
        'General Fitness',
        'Overall health and wellness',
        Icons.self_improvement,
        [const Color(0xFF00BCD4), const Color(0xFF4DD0E1)]
      ),
    ];

    return goals
        .map((g) => _selectionTile(
              isSelected: _goal == g.$1,
              onTap: () => setState(() => _goal = g.$1),
              title: g.$2,
              subtitle: g.$3,
              icon: g.$4,
              gradient: g.$5,
            ))
        .toList();
  }

  List<Widget> _levelOptions() {
    final levels = [
      (
        FitnessLevel.beginner,
        'Beginner',
        '0–6 months of experience',
        Icons.emoji_people,
        [const Color(0xFF4CAF50), const Color(0xFF66BB6A)]
      ),
      (
        FitnessLevel.intermediate,
        'Intermediate',
        '6–24 months of experience',
        Icons.directions_run,
        [const Color(0xFF6C63FF), const Color(0xFF8E86FF)]
      ),
      (
        FitnessLevel.advanced,
        'Advanced',
        '2+ years of experience',
        Icons.emoji_events,
        [const Color(0xFFFF6584), const Color(0xFFFF8A9B)]
      ),
    ];

    return levels
        .map((l) => _selectionTile(
              isSelected: _fitnessLevel == l.$1,
              onTap: () => setState(() => _fitnessLevel = l.$1),
              title: l.$2,
              subtitle: l.$3,
              icon: l.$4,
              gradient: l.$5,
            ))
        .toList();
  }

  Widget _selectionTile({
    required bool isSelected,
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight)
              : null,
          color: isSelected ? null : Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            width: 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: gradient.first.withOpacity(0.35), blurRadius: 16, offset: const Offset(0, 8))]
              : [],
        ),
        child: Row(children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white.withOpacity(0.2) : gradient.first.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: isSelected ? Colors.white : gradient.first, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? Colors.white : null, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? Colors.white.withOpacity(0.85)
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
          ])),
          Icon(isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.3)),
        ]),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required List<Color> gradient,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1), width: 2),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(width: 4),
              Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(unit, style: Theme.of(context).textTheme.bodyLarge)),
            ]),
          ]),
        ]),
        const SizedBox(height: 20),
        child,
      ]),
    );
  }
}
