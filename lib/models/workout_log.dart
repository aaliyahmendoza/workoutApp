import 'package:isar/isar.dart';

part 'workout_log.g.dart';

@collection
class WorkoutLog {
  Id id = Isar.autoIncrement;

  @Index()
  String uid = '';

  @Index()
  late DateTime date;

  late String workoutType;

  String? notes;

  final exercises = IsarLinks<ExerciseLog>();
}

@collection
class ExerciseLog {
  Id id = Isar.autoIncrement;

  late String exerciseName;

  List<SetLog>? sets;

  DateTime? loggedAt;
}

@embedded
class SetLog {
  int? reps;
  double? weight; // in kg
  int? duration; // in seconds for cardio/timed exercises
}
