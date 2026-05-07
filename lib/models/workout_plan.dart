import 'package:isar/isar.dart';
import 'exercise.dart';

part 'workout_plan.g.dart';

@collection
class WorkoutPlan {
  Id id = Isar.autoIncrement;

  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  List<Exercise>? exercises;

  WorkoutPlan({
    this.name,
    this.description,
    this.exercises,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  WorkoutPlan copyWith({
    Id? id,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Exercise>? exercises,
  }) {
    return WorkoutPlan(
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      exercises: exercises ?? this.exercises,
    )..id = id ?? this.id;
  }
}
