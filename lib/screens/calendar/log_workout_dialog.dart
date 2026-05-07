import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../../models/workout_log.dart';
import '../../models/user_preferences.dart';
import '../../services/database_service.dart';
import '../../utils/unit_converter.dart';

class LogWorkoutDialog extends StatefulWidget {
  final DateTime date;

  const LogWorkoutDialog({super.key, required this.date});

  @override
  State<LogWorkoutDialog> createState() => _LogWorkoutDialogState();
}

class _LogWorkoutDialogState extends State<LogWorkoutDialog> {
  final DatabaseService _dbService = DatabaseService();
  final TextEditingController _notesController = TextEditingController();
  final List<ExerciseLogEntry> _exercises = [];
  List<String> _exerciseNameSuggestions = [];

  String _selectedWorkoutType = 'Full Body';
  WeightUnit _weightUnit = WeightUnit.kg;
  final List<String> _workoutTypes = [
    'Full Body',
    'Lifting',
    'Cardio',
    'Arms',
    'Legs',
    'Chest',
    'Back',
    'Shoulders',
    'Core',
  ];

  @override
  void initState() {
    super.initState();
    _loadExerciseNames();
  }

  Future<void> _loadExerciseNames() async {
    final db = await _dbService.isar;
    final allExercises = await db.exerciseLogs.where().findAll();
    final uniqueNames = allExercises
        .map((e) => e.exerciseName)
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList();
    uniqueNames.sort();

    if (mounted) {
      setState(() {
        _exerciseNameSuggestions = uniqueNames;
      });
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _addExercise() {
    setState(() {
      _exercises.add(ExerciseLogEntry());
    });
  }

  void _removeExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
    });
  }

  Future<void> _saveWorkout() async {
    if (_exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one exercise')),
      );
      return;
    }

    // Create workout log
    final workoutLog = WorkoutLog()
      ..date = DateTime(widget.date.year, widget.date.month, widget.date.day)
      ..workoutType = _selectedWorkoutType
      ..notes = _notesController.text.isEmpty ? null : _notesController.text;

    // Create exercise logs
    final exerciseLogs = _exercises.map((entry) {
      final exercise = ExerciseLog()
        ..exerciseName = entry.nameController.text;

      final sets = <SetLog>[];
      for (var setEntry in entry.sets) {
        final displayWeight = double.tryParse(setEntry.weightController.text);
        final reps = int.tryParse(setEntry.repsController.text);

        if (displayWeight != null || reps != null) {
          // Convert weight to kg for storage
          final storageWeight = displayWeight != null
              ? UnitConverter.toStorageWeight(displayWeight, _weightUnit == WeightUnit.kg)
              : null;

          sets.add(SetLog()
            ..weight = storageWeight
            ..reps = reps);
        }
      }

      exercise.sets = sets.isEmpty ? null : sets;
      return exercise;
    }).toList();

    // Save to database
    await _dbService.createWorkoutLog(workoutLog, exerciseLogs);

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 500),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.fitness_center, color: Colors.white),
                  const SizedBox(width: 12),
                  const Text(
                    'Log Workout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Workout Type',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedWorkoutType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: _workoutTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedWorkoutType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weight Unit',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            ChoiceChip(
                              label: const Text('kg'),
                              selected: _weightUnit == WeightUnit.kg,
                              onSelected: (selected) {
                                setState(() {
                                  _weightUnit = WeightUnit.kg;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: const Text('lbs'),
                              selected: _weightUnit == WeightUnit.lbs,
                              onSelected: (selected) {
                                setState(() {
                                  _weightUnit = WeightUnit.lbs;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Exercises',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          onPressed: _addExercise,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._exercises.asMap().entries.map((entry) {
                      return _buildExerciseEntry(entry.key, entry.value);
                    }),
                    if (_exercises.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Icon(
                                Icons.fitness_center,
                                size: 48,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.3),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'No exercises added yet',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Notes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        hintText: 'Add any notes about your workout...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveWorkout,
                      child: const Text('Save Workout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseEntry(int index, ExerciseLogEntry entry) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return _exerciseNameSuggestions.where((String option) {
                        return option
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      entry.nameController.text = selection;
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      // Sync the autocomplete controller with our entry controller
                      if (entry.nameController.text != fieldController.text) {
                        fieldController.text = entry.nameController.text;
                      }
                      fieldController.addListener(() {
                        entry.nameController.text = fieldController.text;
                      });

                      return TextField(
                        controller: fieldController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: 'Exercise Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          suffixIcon: entry.nameController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear, size: 18),
                                  onPressed: () {
                                    fieldController.clear();
                                    entry.nameController.clear();
                                  },
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () => _removeExercise(index),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sets',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Set'),
                  onPressed: () {
                    setState(() {
                      entry.sets.add(SetLogEntry());
                    });
                  },
                ),
              ],
            ),
            ...entry.sets.asMap().entries.map((setEntry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${setEntry.key + 1}.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: setEntry.value.weightController,
                        decoration: InputDecoration(
                          labelText: 'Weight (${_weightUnit == WeightUnit.kg ? 'kg' : 'lbs'})',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: setEntry.value.repsController,
                        decoration: InputDecoration(
                          labelText: 'Reps',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, size: 20),
                      onPressed: () {
                        setState(() {
                          entry.sets.removeAt(setEntry.key);
                        });
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ExerciseLogEntry {
  final TextEditingController nameController = TextEditingController();
  final List<SetLogEntry> sets = [];

  ExerciseLogEntry() {
    // Add one set by default
    sets.add(SetLogEntry());
  }
}

class SetLogEntry {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
}
