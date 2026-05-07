import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import '../../models/workout_log.dart';
import '../../models/user_preferences.dart';
import '../../services/database_service.dart';
import '../../utils/unit_converter.dart';
import 'log_workout_dialog.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DatabaseService _dbService = DatabaseService();
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  Map<DateTime, List<WorkoutLog>> _workoutEvents = {};
  Map<String, double> _personalRecords = {};
  bool _isLoading = true;
  bool _prInKg = true;
  final Set<int> _editingWorkoutIds = {};
  final Map<int, Map<String, TextEditingController>> _editControllers = {};

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
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _loadUserPreferences();
    _loadWorkoutLogs();
    _loadPersonalRecords();
  }

  Future<void> _loadUserPreferences() async {
    final prefs = await _dbService.getUserPreferences();
    if (prefs != null) {
      setState(() {
        _prInKg = prefs.weightUnit == WeightUnit.kg;
      });
    }
  }

  Future<void> _saveWeightUnitPreference(bool useKg) async {
    final prefs = await _dbService.getUserPreferences();
    if (prefs != null) {
      prefs.weightUnit = useKg ? WeightUnit.kg : WeightUnit.lbs;
      await _dbService.createOrUpdateUserPreferences(prefs);
    }
  }

  Future<void> _loadWorkoutLogs() async {
    setState(() => _isLoading = true);
    final logs = await _dbService.getAllWorkoutLogs();

    final events = <DateTime, List<WorkoutLog>>{};
    for (var log in logs) {
      final date = DateTime(log.date.year, log.date.month, log.date.day);
      if (events[date] == null) {
        events[date] = [];
      }
      events[date]!.add(log);
    }

    setState(() {
      _workoutEvents = events;
      _isLoading = false;
    });
  }

  Future<void> _loadPersonalRecords() async {
    final prs = await _dbService.getWeeklyPersonalRecords();
    setState(() {
      _personalRecords = prs;
    });
  }

  List<WorkoutLog> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _workoutEvents[normalizedDay] ?? [];
  }

  Future<void> _showLogWorkoutDialog(DateTime date) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => LogWorkoutDialog(date: date),
    );

    if (result == true) {
      await _loadWorkoutLogs();
      await _loadPersonalRecords();
    }
  }

  Future<void> _saveInlineEdit(List<WorkoutLog> workouts) async {
    final db = await _dbService.isar;
    await db.writeTxn(() async {
      for (var workout in workouts) {
        await db.workoutLogs.put(workout);
        await workout.exercises.load();
        for (var exercise in workout.exercises) {
          await db.exerciseLogs.put(exercise);
        }
      }
    });

    await _loadWorkoutLogs();
    await _loadPersonalRecords();
  }

  Future<void> _editEntireWorkout(WorkoutLog workout) async {
    // Load exercises first
    await workout.exercises.load();

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _EditEntireWorkoutDialog(
        workout: workout,
        useKg: _prInKg,
      ),
    );

    if (result != null) {
      // Update workout details
      workout.workoutType = result['workoutType'];
      workout.notes = result['notes'];

      // Get updated exercises
      final updatedExercises = result['exercises'] as List<Map<String, dynamic>>;

      final db = await _dbService.isar;
      await db.writeTxn(() async {
        // Update workout
        await db.workoutLogs.put(workout);

        // Update each exercise
        for (var i = 0; i < workout.exercises.length; i++) {
          final exercise = workout.exercises.elementAt(i);
          exercise.exerciseName = updatedExercises[i]['name'];
          exercise.sets = updatedExercises[i]['sets'];
          await db.exerciseLogs.put(exercise);
        }
      });

      await _loadWorkoutLogs();
      await _loadPersonalRecords();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _loadWorkoutLogs();
              _loadPersonalRecords();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildCalendar(),
                  const SizedBox(height: 16),
                  _buildPersonalRecordsSection(),
                  const SizedBox(height: 16),
                  _buildSelectedDayWorkouts(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLogWorkoutDialog(_selectedDay ?? DateTime.now()),
        icon: const Icon(Icons.add),
        label: const Text('Log Workout'),
      ),
    );
  }

  Widget _buildCalendar() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: TableCalendar<WorkoutLog>(
        firstDay: DateTime(2020, 1, 1),
        lastDay: DateTime(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: _getEventsForDay,
        calendarStyle: CalendarStyle(
          markerDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: Theme.of(context).textTheme.titleLarge!,
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget _buildPersonalRecordsSection() {
    if (_personalRecords.isEmpty) {
      return const SizedBox.shrink();
    }

    final sortedPRs = _personalRecords.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.emoji_events, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "THIS WEEK'S PRs",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _prInKg = true;
                        });
                        _saveWeightUnitPreference(true);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _prInKg
                              ? Colors.white.withOpacity(0.3)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'kg',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                _prInKg ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _prInKg = false;
                        });
                        _saveWeightUnitPreference(false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: !_prInKg
                              ? Colors.white.withOpacity(0.3)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'lbs',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                !_prInKg ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...sortedPRs.take(5).map((entry) {
            final displayWeight = _prInKg
                ? entry.value
                : UnitConverter.kgToLbs(entry.value);
            final unit = _prInKg ? 'kg' : 'lbs';

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${displayWeight.toStringAsFixed(1)} $unit',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          if (sortedPRs.length > 5)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '+${sortedPRs.length - 5} more PRs',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectedDayWorkouts() {
    if (_selectedDay == null) return const SizedBox.shrink();

    final workouts = _getEventsForDay(_selectedDay!);
    final dateStr = DateFormat('MMMM d, yyyy').format(_selectedDay!);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateStr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              FilledButton.icon(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const _WorkoutStopwatchSheet(),
                ),
                icon: const Text('⏱️', style: TextStyle(fontSize: 16)),
                label: const Text('Timer'),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (workouts.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 48,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.3),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No workouts logged',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the button below to log a workout',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ..._buildGroupedWorkoutCards(workouts),
        ],
      ),
    );
  }

  List<Widget> _buildGroupedWorkoutCards(List<WorkoutLog> workouts) {
    // Group workouts by type
    final Map<String, List<WorkoutLog>> groupedWorkouts = {};
    for (var workout in workouts) {
      if (!groupedWorkouts.containsKey(workout.workoutType)) {
        groupedWorkouts[workout.workoutType] = [];
      }
      groupedWorkouts[workout.workoutType]!.add(workout);
    }

    // Build a card for each group
    return groupedWorkouts.entries.map((entry) {
      final workoutType = entry.key;
      final workoutsInGroup = entry.value;

      return _buildGroupedWorkoutCard(workoutType, workoutsInGroup);
    }).toList();
  }

  Widget _buildGroupedWorkoutCard(String workoutType, List<WorkoutLog> workouts) {
    // For inline editing, we'll use a StatefulBuilder to track edit state per card
    return StatefulBuilder(
      builder: (context, setCardState) {
        final isEditing = _editingWorkoutIds.contains(workouts.first.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!isEditing)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          workoutType.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: workoutType,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
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
                              setCardState(() {
                                for (var workout in workouts) {
                                  workout.workoutType = value;
                                }
                              });
                            }
                          },
                        ),
                      ),
                    if (!isEditing) const Spacer(),
                    if (!isEditing) ...[
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () {
                          setState(() {
                            _editingWorkoutIds.add(workouts.first.id);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Workout'),
                              content: Text(
                                workouts.length > 1
                                    ? 'Are you sure you want to delete all ${workouts.length} $workoutType workouts?'
                                    : 'Are you sure you want to delete this workout log?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            for (var workout in workouts) {
                              await _dbService.deleteWorkoutLog(workout.id);
                            }
                            _loadWorkoutLogs();
                            _loadPersonalRecords();
                          }
                        },
                      ),
                    ] else ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _editingWorkoutIds.remove(workouts.first.id);
                          });
                          _loadWorkoutLogs();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 4),
                      ElevatedButton(
                        onPressed: () async {
                          await _saveInlineEdit(workouts);
                          setState(() {
                            _editingWorkoutIds.remove(workouts.first.id);
                          });
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ],
                ),
            // Display each workout's exercises followed by its note
            ...workouts.asMap().entries.map((workoutEntry) {
              final workoutIndex = workoutEntry.key;
              final workout = workoutEntry.value;
              workout.exercises.loadSync();
              final exercises = workout.exercises.toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (workouts.length > 1) ...[
                    const SizedBox(height: 16),
                    if (workoutIndex > 0) const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Workout ${workoutIndex + 1}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                    ),
                  ],
                  if (exercises.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ...exercises.map((exercise) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isEditing)
                              Row(
                                children: [
                                  Icon(
                                    Icons.fitness_center,
                                    size: 16,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      exercise.exerciseName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              TextFormField(
                                key: ValueKey('exercise_${workout.id}_${exercise.id}'),
                                initialValue: exercise.exerciseName,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.fitness_center, size: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                onChanged: (value) {
                                  exercise.exerciseName = value;
                                },
                              ),
                            if (exercise.sets != null && exercise.sets!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              ...exercise.sets!.asMap().entries.map((entry) {
                                final setNum = entry.key + 1;
                                final set = entry.value;
                                final displayWeight = set.weight != null
                                    ? (_prInKg
                                        ? set.weight!
                                        : UnitConverter.kgToLbs(set.weight!))
                                    : null;
                                final unit = _prInKg ? 'kg' : 'lbs';

                                if (!isEditing) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 24, bottom: 4),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$setNum',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        if (displayWeight != null)
                                          Text(
                                            '${displayWeight.toStringAsFixed(1)} $unit',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        if (displayWeight != null && set.reps != null)
                                          Text(
                                            ' × ',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        if (set.reps != null)
                                          Text(
                                            '${set.reps} reps',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                      ],
                                    ),
                                  );
                                } else {
                                  // Editable set fields
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          child: Text(
                                            '$setNum.',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            key: ValueKey('weight_${workout.id}_${exercise.exerciseName}_$setNum'),
                                            initialValue: displayWeight?.toStringAsFixed(1) ?? '',
                                            decoration: InputDecoration(
                                              labelText: 'Weight ($unit)',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                            ),
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              final weight = double.tryParse(value);
                                              if (weight != null) {
                                                set.weight = UnitConverter.toStorageWeight(
                                                  weight,
                                                  _prInKg,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: TextFormField(
                                            key: ValueKey('reps_${workout.id}_${exercise.exerciseName}_$setNum'),
                                            initialValue: set.reps?.toString() ?? '',
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
                                            onChanged: (value) {
                                              set.reps = int.tryParse(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                            ],
                          ],
                        ),
                      );
                    }),
                  ],
                  // Show note right after this workout's exercises
                  if (!isEditing && workout.notes != null && workout.notes!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.note,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              workout.notes!,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (isEditing) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      key: ValueKey('notes_${workout.id}'),
                      initialValue: workout.notes ?? '',
                      decoration: InputDecoration(
                        labelText: 'Notes',
                        prefixIcon: const Icon(Icons.note, size: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      maxLines: 2,
                      onChanged: (value) {
                        workout.notes = value.isEmpty ? null : value;
                      },
                    ),
                  ],
                ],
              );
            }),
          ],
        ),
      ),
    );
      },
    );
  }

  Widget _buildWorkoutCard(WorkoutLog workout) {
    // Load exercises
    workout.exercises.loadSync();
    final exercises = workout.exercises.toList();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    workout.workoutType.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _editEntireWorkout(workout),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Workout'),
                        content: const Text(
                            'Are you sure you want to delete this workout log?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await _dbService.deleteWorkoutLog(workout.id);
                      _loadWorkoutLogs();
                      _loadPersonalRecords();
                    }
                  },
                ),
              ],
            ),
            if (exercises.isNotEmpty) ...[
              const SizedBox(height: 16),
              ...exercises.map((exercise) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              exercise.exerciseName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      if (exercise.sets != null && exercise.sets!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ...exercise.sets!.asMap().entries.map((entry) {
                          final setNum = entry.key + 1;
                          final set = entry.value;
                          final displayWeight = set.weight != null
                              ? (_prInKg
                                  ? set.weight!
                                  : UnitConverter.kgToLbs(set.weight!))
                              : null;
                          final unit = _prInKg ? 'kg' : 'lbs';

                          return Padding(
                            padding: const EdgeInsets.only(left: 24, bottom: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$setNum',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (displayWeight != null)
                                  Text(
                                    '${displayWeight.toStringAsFixed(1)} $unit',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                if (displayWeight != null && set.reps != null)
                                  Text(
                                    ' × ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                if (set.reps != null)
                                  Text(
                                    '${set.reps} reps',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                );
              }),
            ],
            if (workout.notes != null && workout.notes!.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      workout.notes!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7),
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EditExerciseDialog extends StatefulWidget {
  final ExerciseLog exercise;
  final bool useKg;

  const _EditExerciseDialog({
    required this.exercise,
    required this.useKg,
  });

  @override
  State<_EditExerciseDialog> createState() => _EditExerciseDialogState();
}

class _EditExerciseDialogState extends State<_EditExerciseDialog> {
  late TextEditingController _nameController;
  late List<_SetEditController> _setControllers;
  late bool _useKg;
  List<String> _exerciseNameSuggestions = [];
  final DatabaseService _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.exercise.exerciseName);
    _useKg = widget.useKg;
    _loadExerciseNames();

    _setControllers = (widget.exercise.sets ?? []).map((set) {
      final displayWeight = set.weight != null
          ? (_useKg ? set.weight! : UnitConverter.kgToLbs(set.weight!))
          : null;

      return _SetEditController(
        weightController: TextEditingController(
          text: displayWeight?.toStringAsFixed(1) ?? '',
        ),
        repsController: TextEditingController(
          text: set.reps?.toString() ?? '',
        ),
      );
    }).toList();

    if (_setControllers.isEmpty) {
      _setControllers.add(_SetEditController(
        weightController: TextEditingController(),
        repsController: TextEditingController(),
      ));
    }
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
    _nameController.dispose();
    for (var controller in _setControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addSet() {
    setState(() {
      _setControllers.add(_SetEditController(
        weightController: TextEditingController(),
        repsController: TextEditingController(),
      ));
    });
  }

  void _removeSet(int index) {
    setState(() {
      _setControllers[index].dispose();
      _setControllers.removeAt(index);
    });
  }

  void _save() {
    final sets = <SetLog>[];
    for (var controller in _setControllers) {
      final displayWeight = double.tryParse(controller.weightController.text);
      final reps = int.tryParse(controller.repsController.text);

      if (displayWeight != null || reps != null) {
        final storageWeight = displayWeight != null
            ? UnitConverter.toStorageWeight(displayWeight, _useKg)
            : null;

        sets.add(SetLog()
          ..weight = storageWeight
          ..reps = reps);
      }
    }

    Navigator.pop(context, {
      'name': _nameController.text,
      'sets': sets,
    });
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
                  const Icon(Icons.edit, color: Colors.white),
                  const SizedBox(width: 12),
                  const Text(
                    'Edit Exercise',
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
                    Autocomplete<String>(
                      initialValue: TextEditingValue(text: _nameController.text),
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
                        _nameController.text = selection;
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        fieldController.text = _nameController.text;
                        fieldController.addListener(() {
                          _nameController.text = fieldController.text;
                        });

                        return TextField(
                          controller: fieldController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: 'Exercise Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sets',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            ChoiceChip(
                              label: const Text('kg'),
                              selected: _useKg,
                              onSelected: (selected) {
                                setState(() {
                                  _useKg = true;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: const Text('lbs'),
                              selected: !_useKg,
                              onSelected: (selected) {
                                setState(() {
                                  _useKg = false;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle),
                              onPressed: _addSet,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ..._setControllers.asMap().entries.map((entry) {
                      final index = entry.key;
                      final controller = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                '${index + 1}.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller.weightController,
                                decoration: InputDecoration(
                                  labelText: 'Weight (${_useKg ? 'kg' : 'lbs'})',
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
                                controller: controller.repsController,
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
                              icon: const Icon(Icons.remove_circle_outline,
                                  size: 20),
                              onPressed: () => _removeSet(index),
                            ),
                          ],
                        ),
                      );
                    }),
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
                      onPressed: _save,
                      child: const Text('Save'),
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
}

class _SetEditController {
  final TextEditingController weightController;
  final TextEditingController repsController;

  _SetEditController({
    required this.weightController,
    required this.repsController,
  });

  void dispose() {
    weightController.dispose();
    repsController.dispose();
  }
}

class _EditEntireWorkoutDialog extends StatefulWidget {
  final WorkoutLog workout;
  final bool useKg;

  const _EditEntireWorkoutDialog({
    required this.workout,
    required this.useKg,
  });

  @override
  State<_EditEntireWorkoutDialog> createState() => _EditEntireWorkoutDialogState();
}

class _EditEntireWorkoutDialogState extends State<_EditEntireWorkoutDialog> {
  late String _selectedWorkoutType;
  late TextEditingController _notesController;
  late List<_ExerciseEditData> _exercises;
  late bool _useKg;
  List<String> _exerciseNameSuggestions = [];
  final DatabaseService _dbService = DatabaseService();

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
    _selectedWorkoutType = widget.workout.workoutType;
    _notesController = TextEditingController(text: widget.workout.notes ?? '');
    _useKg = widget.useKg;
    _loadExerciseNames();

    // Load all exercises
    _exercises = widget.workout.exercises.map((exercise) {
      final setControllers = (exercise.sets ?? []).map((set) {
        final displayWeight = set.weight != null
            ? (_useKg ? set.weight! : UnitConverter.kgToLbs(set.weight!))
            : null;

        return _SetEditController(
          weightController: TextEditingController(
            text: displayWeight?.toStringAsFixed(1) ?? '',
          ),
          repsController: TextEditingController(
            text: set.reps?.toString() ?? '',
          ),
        );
      }).toList();

      return _ExerciseEditData(
        nameController: TextEditingController(text: exercise.exerciseName),
        setControllers: setControllers.isEmpty
            ? [
                _SetEditController(
                  weightController: TextEditingController(),
                  repsController: TextEditingController(),
                )
              ]
            : setControllers,
      );
    }).toList();
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
    for (var exercise in _exercises) {
      exercise.dispose();
    }
    super.dispose();
  }

  void _save() {
    final exercisesData = _exercises.map((exercise) {
      final sets = <SetLog>[];
      for (var setCtrl in exercise.setControllers) {
        final displayWeight = double.tryParse(setCtrl.weightController.text);
        final reps = int.tryParse(setCtrl.repsController.text);

        if (displayWeight != null || reps != null) {
          final storageWeight = displayWeight != null
              ? UnitConverter.toStorageWeight(displayWeight, _useKg)
              : null;

          sets.add(SetLog()
            ..weight = storageWeight
            ..reps = reps);
        }
      }

      return {
        'name': exercise.nameController.text,
        'sets': sets,
      };
    }).toList();

    Navigator.pop(context, {
      'workoutType': _selectedWorkoutType,
      'notes': _notesController.text.isEmpty ? null : _notesController.text,
      'exercises': exercisesData,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 700, maxWidth: 500),
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
                  const Icon(Icons.edit, color: Colors.white),
                  const SizedBox(width: 12),
                  const Text(
                    'Edit Workout',
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
                              selected: _useKg,
                              onSelected: (selected) {
                                setState(() {
                                  _useKg = true;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: const Text('lbs'),
                              selected: !_useKg,
                              onSelected: (selected) {
                                setState(() {
                                  _useKg = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Exercises',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ..._exercises.asMap().entries.map((entry) {
                      final index = entry.key;
                      final exercise = entry.value;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Autocomplete<String>(
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
                                  exercise.nameController.text = selection;
                                },
                                fieldViewBuilder: (BuildContext context,
                                    TextEditingController fieldController,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted) {
                                  if (exercise.nameController.text != fieldController.text) {
                                    fieldController.text = exercise.nameController.text;
                                  }
                                  fieldController.addListener(() {
                                    exercise.nameController.text = fieldController.text;
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
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 12),
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
                                        exercise.setControllers.add(_SetEditController(
                                          weightController: TextEditingController(),
                                          repsController: TextEditingController(),
                                        ));
                                      });
                                    },
                                  ),
                                ],
                              ),
                              ...exercise.setControllers.asMap().entries.map((setEntry) {
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
                                            labelText: 'Weight (${_useKg ? 'kg' : 'lbs'})',
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
                                            exercise.setControllers.removeAt(setEntry.key);
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
                    }),
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
                      onPressed: _save,
                      child: const Text('Save Changes'),
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
}

class _ExerciseEditData {
  final TextEditingController nameController;
  final List<_SetEditController> setControllers;

  _ExerciseEditData({
    required this.nameController,
    required this.setControllers,
  });

  void dispose() {
    nameController.dispose();
    for (var controller in setControllers) {
      controller.dispose();
    }
  }
}

class _EditWorkoutDialog extends StatefulWidget {
  final WorkoutLog workout;

  const _EditWorkoutDialog({required this.workout});

  @override
  State<_EditWorkoutDialog> createState() => _EditWorkoutDialogState();
}

class _EditWorkoutDialogState extends State<_EditWorkoutDialog> {
  late String _selectedWorkoutType;
  late TextEditingController _notesController;

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
    _selectedWorkoutType = widget.workout.workoutType;
    _notesController = TextEditingController(text: widget.workout.notes ?? '');
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(context, {
      'workoutType': _selectedWorkoutType,
      'notes': _notesController.text.isEmpty ? null : _notesController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400, maxWidth: 500),
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
                  const Icon(Icons.edit, color: Colors.white),
                  const SizedBox(width: 12),
                  const Text(
                    'Edit Workout',
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
                      maxLines: 4,
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
                      onPressed: _save,
                      child: const Text('Save'),
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
}

class _WorkoutStopwatchSheet extends StatefulWidget {
  const _WorkoutStopwatchSheet();

  @override
  State<_WorkoutStopwatchSheet> createState() => _WorkoutStopwatchSheetState();
}

class _WorkoutStopwatchSheetState extends State<_WorkoutStopwatchSheet> {
  final Stopwatch _stopwatch = Stopwatch();
  bool _running = false;

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      if (_running) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
      _running = !_running;
    });
  }

  void _reset() {
    setState(() {
      _stopwatch.reset();
      _stopwatch.stop();
      _running = false;
    });
  }

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (h > 0) return '$h:$m:$s';
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text('Workout Timer',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 32),
          StreamBuilder<int>(
            stream: Stream.periodic(const Duration(milliseconds: 100), (i) => i),
            builder: (context, _) {
              return Text(
                _format(_stopwatch.elapsed),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 4,
                    ),
              );
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              FilledButton.icon(
                onPressed: _toggle,
                icon: Icon(_running ? Icons.pause : Icons.play_arrow, size: 28),
                label: Text(_running ? 'Pause' : 'Start',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
