import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout/active_workout_state.dart';
import '../models/workout/workout_session.dart';
import '../services/database_service.dart';
import '../services/workout/notification_service.dart';

class WorkoutProvider extends ChangeNotifier {
  ActiveWorkoutState? _activeWorkout;
  Timer? _timer;
  final NotificationService _notificationService = NotificationService();
  final DatabaseService _dbService = DatabaseService();

  bool _isTimerRunning = false;
  int _elapsedSeconds = 0;

  ActiveWorkoutState? get activeWorkout => _activeWorkout;
  bool get hasActiveWorkout => _activeWorkout != null;
  bool get isTimerRunning => _isTimerRunning;
  int get elapsedSeconds => _elapsedSeconds;

  WorkoutProvider() {
    _loadActiveWorkout();
    _notificationService.initialize();
  }

  Future<void> _loadActiveWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutJson = prefs.getString('active_workout');
    if (workoutJson != null) {
      try {
        final data = json.decode(workoutJson);
        _activeWorkout = ActiveWorkoutState.fromJson(data);
        _elapsedSeconds =
            DateTime.now().difference(_activeWorkout!.startTime).inSeconds;
        notifyListeners();
      } catch (e) {
        debugPrint('Error loading active workout: $e');
      }
    }
  }

  Future<void> _saveActiveWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    if (_activeWorkout != null) {
      final workoutJson = json.encode(_activeWorkout!.toJson());
      await prefs.setString('active_workout', workoutJson);
    } else {
      await prefs.remove('active_workout');
    }
  }

  Future<void> startWorkout({
    required String workoutId,
    required String workoutName,
    required List<Map<String, dynamic>> exercises,
  }) async {
    if (exercises.isEmpty) return;

    final firstExercise = exercises[0];
    _activeWorkout = ActiveWorkoutState(
      workoutId: workoutId,
      workoutName: workoutName,
      totalExercises: exercises.length,
      currentExerciseName: firstExercise['name'] ?? 'Exercise',
      currentExerciseSets: firstExercise['sets'] ?? 3,
      currentExerciseDuration: firstExercise['duration'] ?? 60,
    );

    await _saveActiveWorkout();
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _isTimerRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _elapsedSeconds++;

      if (_activeWorkout?.isRestPeriod == true) {
        final remaining = _activeWorkout!.restTimeRemaining - 1;
        if (remaining <= 0) {
          _completeRest();
        } else {
          _activeWorkout = _activeWorkout!.copyWith(
            restTimeRemaining: remaining,
          );
        }
      } else if (_activeWorkout?.exerciseTimeRemaining != null &&
          _activeWorkout!.exerciseTimeRemaining > 0) {
        final remaining = _activeWorkout!.exerciseTimeRemaining - 1;
        _activeWorkout = _activeWorkout!.copyWith(
          exerciseTimeRemaining: remaining,
        );
      }

      notifyListeners();
    });
  }

  void pauseWorkout() {
    _isTimerRunning = false;
    _timer?.cancel();
    notifyListeners();
  }

  void resumeWorkout() {
    _startTimer();
    notifyListeners();
  }

  Future<void> completeSet() async {
    if (_activeWorkout == null) return;

    final currentSet = _activeWorkout!.currentSet;
    final totalSets = _activeWorkout!.currentExerciseSets;

    await _notificationService.showSetCompleteNotification(
      exerciseName: _activeWorkout!.currentExerciseName,
      setNumber: currentSet,
      totalSets: totalSets,
    );

    if (currentSet >= totalSets) {
      await _completeExercise();
    } else {
      _startRest();
    }
  }

  void _startRest() {
    if (_activeWorkout == null) return;

    _activeWorkout = _activeWorkout!.copyWith(
      isRestPeriod: true,
      restTimeRemaining: 60, // Default 60 seconds rest
      currentSet: _activeWorkout!.currentSet + 1,
    );

    _saveActiveWorkout();
    notifyListeners();
  }

  void _completeRest() {
    if (_activeWorkout == null) return;

    _activeWorkout = _activeWorkout!.copyWith(
      isRestPeriod: false,
      restTimeRemaining: 0,
    );

    _notificationService.showRestCompleteNotification(
      nextExerciseName: _activeWorkout!.currentExerciseName,
    );

    _saveActiveWorkout();
    notifyListeners();
  }

  Future<void> _completeExercise() async {
    if (_activeWorkout == null) return;

    final completedIds = List<String>.from(_activeWorkout!.completedExerciseIds)
      ..add(_activeWorkout!.currentExerciseIndex.toString());

    final nextIndex = _activeWorkout!.currentExerciseIndex + 1;

    if (nextIndex >= _activeWorkout!.totalExercises) {
      await _completeWorkout();
      return;
    }

    _activeWorkout = _activeWorkout!.copyWith(
      currentExerciseIndex: nextIndex,
      currentSet: 1,
      completedExerciseIds: completedIds,
    );

    await _saveActiveWorkout();
    notifyListeners();
  }

  Future<void> _completeWorkout() async {
    if (_activeWorkout == null) return;

    final duration =
        DateTime.now().difference(_activeWorkout!.startTime).inSeconds;

    await _notificationService.showWorkoutCompleteNotification(
      workoutName: _activeWorkout!.workoutName,
      duration: duration,
      exercisesCompleted: _activeWorkout!.completedExercises,
    );

    final session = WorkoutSession(
      workoutPlanId: _activeWorkout!.workoutId,
      workoutPlanName: _activeWorkout!.workoutName,
      startTime: _activeWorkout!.startTime,
      endTime: DateTime.now(),
      totalDuration: duration,
      completedExercises: _activeWorkout!.completedExercises,
      totalExercises: _activeWorkout!.totalExercises,
      isCompleted: true,
    );

    final db = await _dbService.isar;
    await db.writeTxn(() async {
      await db.workoutSessions.put(session);
    });

    await endWorkout();
  }

  Future<void> endWorkout() async {
    _timer?.cancel();
    _activeWorkout = null;
    _isTimerRunning = false;
    _elapsedSeconds = 0;
    await _saveActiveWorkout();
    await _notificationService.cancelAll();
    notifyListeners();
  }

  void skipExercise() {
    if (_activeWorkout == null) return;
    _completeExercise();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
