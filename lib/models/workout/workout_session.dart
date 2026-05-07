import 'package:isar/isar.dart';

part 'workout_session.g.dart';

@collection
class WorkoutSession {
  Id id = Isar.autoIncrement;

  String? workoutPlanId;
  String? workoutPlanName;
  DateTime? startTime;
  DateTime? endTime;
  int? totalDuration; // in seconds
  int? completedExercises;
  int? totalExercises;
  bool isCompleted;
  List<CompletedExercise>? exercises;

  WorkoutSession({
    this.workoutPlanId,
    this.workoutPlanName,
    this.startTime,
    this.endTime,
    this.totalDuration,
    this.completedExercises = 0,
    this.totalExercises = 0,
    this.isCompleted = false,
    this.exercises,
  });
}

@embedded
class CompletedExercise {
  String? exerciseId;
  String? exerciseName;
  int? sets;
  int? reps;
  int? duration; // in seconds
  DateTime? completedAt;
  bool isCompleted;

  CompletedExercise({
    this.exerciseId,
    this.exerciseName,
    this.sets,
    this.reps,
    this.duration,
    this.completedAt,
    this.isCompleted = false,
  });
}
