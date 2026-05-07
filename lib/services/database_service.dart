import 'package:firebase_auth/firebase_auth.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_preferences.dart';
import '../models/workout_plan.dart';
import '../models/workout/workout_session.dart';
import '../models/workout_log.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Isar? _isar;

  Future<Isar> get isar async {
    if (_isar != null) return _isar!;
    _isar = await _initDB();
    return _isar!;
  }

  Future<Isar> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [UserPreferencesSchema, WorkoutPlanSchema, WorkoutSessionSchema, WorkoutLogSchema, ExerciseLogSchema],
      directory: dir.path,
    );
  }

  // ==================== USER PREFERENCES CRUD ====================

  Future<UserPreferences?> getUserPreferences() async {
    final db = await isar;
    return await db.userPreferences.where().findFirst();
  }

  Future<UserPreferences> createOrUpdateUserPreferences(
      UserPreferences preferences) async {
    final db = await isar;
    final existing = await getUserPreferences();

    if (existing != null) {
      preferences.id = existing.id;
      preferences.createdAt = existing.createdAt;
    }
    preferences.updatedAt = DateTime.now();

    await db.writeTxn(() async {
      await db.userPreferences.put(preferences);
    });

    return preferences;
  }

  Future<void> deleteUserPreferences() async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.userPreferences.clear();
    });
  }

  // ==================== WORKOUT PLAN CRUD ====================

  Future<List<WorkoutPlan>> getAllWorkoutPlans() async {
    final db = await isar;
    return await db.workoutPlans.where().findAll();
  }

  Future<WorkoutPlan?> getWorkoutPlanById(Id id) async {
    final db = await isar;
    return await db.workoutPlans.get(id);
  }

  Future<WorkoutPlan> createWorkoutPlan(WorkoutPlan plan) async {
    final db = await isar;
    plan.createdAt = DateTime.now();
    plan.updatedAt = DateTime.now();

    await db.writeTxn(() async {
      plan.id = await db.workoutPlans.put(plan);
    });

    return plan;
  }

  Future<WorkoutPlan> updateWorkoutPlan(WorkoutPlan plan) async {
    final db = await isar;
    plan.updatedAt = DateTime.now();

    await db.writeTxn(() async {
      await db.workoutPlans.put(plan);
    });

    return plan;
  }

  Future<void> deleteWorkoutPlan(Id id) async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.workoutPlans.delete(id);
    });
  }

  Future<void> deleteAllWorkoutPlans() async {
    final db = await isar;
    await db.writeTxn(() async {
      await db.workoutPlans.clear();
    });
  }

  Stream<List<WorkoutPlan>> watchAllWorkoutPlans() async* {
    final db = await isar;
    yield* db.workoutPlans.where().watch(fireImmediately: true);
  }

  Stream<UserPreferences?> watchUserPreferences() async* {
    final db = await isar;
    yield* db.userPreferences.where().watch(fireImmediately: true).map(
          (list) => list.isEmpty ? null : list.first,
        );
  }

  Future<void> saveWorkoutPlans(List<WorkoutPlan> plans) async {
    final db = await isar;
    await db.writeTxn(() async {
      for (var plan in plans) {
        await db.workoutPlans.put(plan);
      }
    });
  }

  // ==================== WORKOUT LOG CRUD ====================

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<WorkoutLog> createWorkoutLog(WorkoutLog log, List<ExerciseLog> exercises) async {
    final db = await isar;
    log.uid = _uid;

    await db.writeTxn(() async {
      for (var exercise in exercises) {
        exercise.loggedAt = DateTime.now();
        await db.exerciseLogs.put(exercise);
      }
      log.id = await db.workoutLogs.put(log);
      await log.exercises.save();
      for (var exercise in exercises) {
        log.exercises.add(exercise);
      }
      await log.exercises.save();
    });

    return log;
  }

  Future<List<WorkoutLog>> getWorkoutLogsByDateRange(DateTime start, DateTime end) async {
    final db = await isar;
    return await db.workoutLogs
        .filter()
        .uidEqualTo(_uid)
        .and()
        .dateBetween(start, end)
        .findAll();
  }

  Future<List<WorkoutLog>> getAllWorkoutLogs() async {
    final db = await isar;
    return await db.workoutLogs.filter().uidEqualTo(_uid).findAll();
  }

  Future<WorkoutLog?> getWorkoutLogByDate(DateTime date) async {
    final db = await isar;
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final logs = await db.workoutLogs
        .filter()
        .uidEqualTo(_uid)
        .and()
        .dateBetween(startOfDay, endOfDay)
        .findAll();

    return logs.isEmpty ? null : logs.first;
  }

  Future<Map<String, double>> getPersonalRecords() async {
    final db = await isar;
    final userLogs = await db.workoutLogs.filter().uidEqualTo(_uid).findAll();
    final prs = <String, double>{};
    for (var log in userLogs) {
      await log.exercises.load();
      for (var exercise in log.exercises) {
        if (exercise.sets != null) {
          for (var set in exercise.sets!) {
            if (set.weight != null) {
              final currentPR = prs[exercise.exerciseName] ?? 0.0;
              if (set.weight! > currentPR) prs[exercise.exerciseName] = set.weight!;
            }
          }
        }
      }
    }
    return prs;
  }

  Future<Map<String, double>> getWeeklyPersonalRecords() async {
    final db = await isar;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeekNormalized = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    final weekLogs = await db.workoutLogs
        .filter()
        .uidEqualTo(_uid)
        .and()
        .dateGreaterThan(startOfWeekNormalized)
        .findAll();

    final prs = <String, double>{};
    for (var log in weekLogs) {
      await log.exercises.load();
      for (var exercise in log.exercises) {
        if (exercise.sets != null) {
          for (var set in exercise.sets!) {
            if (set.weight != null) {
              final currentPR = prs[exercise.exerciseName] ?? 0.0;
              if (set.weight! > currentPR) prs[exercise.exerciseName] = set.weight!;
            }
          }
        }
      }
    }
    return prs;
  }

  Future<void> deleteWorkoutLog(Id id) async {
    final db = await isar;
    await db.writeTxn(() async {
      final log = await db.workoutLogs.get(id);
      if (log != null) {
        await log.exercises.load();
        for (var exercise in log.exercises) {
          await db.exerciseLogs.delete(exercise.id);
        }
        await db.workoutLogs.delete(id);
      }
    });
  }

  Future<void> clearAllData() async {
    final db = await isar;
    // Separate transactions — a single tx fails silently when linked records exist
    await db.writeTxn(() async => await db.exerciseLogs.clear());
    await db.writeTxn(() async => await db.workoutLogs.clear());
    await db.writeTxn(() async => await db.workoutSessions.clear());
    await db.writeTxn(() async => await db.workoutPlans.clear());
    await db.writeTxn(() async => await db.userPreferences.clear());
  }

  Future<void> nuclearClear() async {
    await _isar?.close(deleteFromDisk: true);
    _isar = null;
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
