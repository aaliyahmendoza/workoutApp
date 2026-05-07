import 'package:isar/isar.dart';

part 'user_preferences.g.dart';

enum FitnessGoal {
  loseWeight,
  buildMuscle,
  maintainFitness,
  increaseEndurance,
  general,
}

enum FitnessLevel {
  beginner,
  intermediate,
  advanced,
}

enum WeightUnit {
  kg,
  lbs,
}

enum HeightUnit {
  cm,
  inches,
}

@collection
class UserPreferences {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  FitnessGoal? goal;

  int? age;
  double? weight; // stored in kg
  double? height; // stored in cm

  @Enumerated(EnumType.name)
  FitnessLevel? fitnessLevel;

  @Enumerated(EnumType.name)
  WeightUnit weightUnit;

  @Enumerated(EnumType.name)
  HeightUnit heightUnit;

  DateTime? createdAt;
  DateTime? updatedAt;

  UserPreferences({
    this.goal,
    this.age,
    this.weight,
    this.height,
    this.fitnessLevel,
    this.weightUnit = WeightUnit.kg,
    this.heightUnit = HeightUnit.cm,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  UserPreferences copyWith({
    Id? id,
    FitnessGoal? goal,
    int? age,
    double? weight,
    double? height,
    FitnessLevel? fitnessLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserPreferences(
      goal: goal ?? this.goal,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    )..id = id ?? this.id;
  }

  double? get bmi {
    if (weight == null || height == null || height == 0) return null;
    return weight! / ((height! / 100) * (height! / 100));
  }
}
