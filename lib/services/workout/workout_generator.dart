import '../../models/user_preferences.dart';
import '../../models/workout_plan.dart';
import '../../models/exercise.dart';

class WorkoutGenerator {
  static List<WorkoutPlan> generate7DayPlan(UserPreferences preferences) {
    final goal = preferences.goal ?? FitnessGoal.general;
    final level = preferences.fitnessLevel ?? FitnessLevel.beginner;

    final plans = <WorkoutPlan>[];

    // Get exercises based on goal and level
    final exercisePool = _getExercisePool(goal, level);

    // Generate 7-day plan
    final daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    for (int i = 0; i < 7; i++) {
      final dayName = daysOfWeek[i];

      // Rest day logic
      if (i == 2 || i == 6) { // Wednesday and Sunday
        plans.add(_createRestDay(dayName));
        continue;
      }

      // Create workout for the day
      plans.add(_createDayWorkout(
        dayName: dayName,
        dayIndex: i,
        goal: goal,
        level: level,
        exercisePool: exercisePool,
      ));
    }

    return plans;
  }

  static WorkoutPlan _createRestDay(String dayName) {
    return WorkoutPlan(
      name: '$dayName - Active Recovery',
      description: 'Light stretching and mobility work. Stay active but let your body recover.',
      exercises: [
        Exercise(
          title: 'Light Stretching',
          gifUrl: 'https://example.com/stretch.gif',
          sets: 1,
          duration: 600, // 10 minutes
        ),
        Exercise(
          title: 'Walking',
          gifUrl: 'https://example.com/walk.gif',
          sets: 1,
          duration: 1200, // 20 minutes
        ),
      ],
    );
  }

  static WorkoutPlan _createDayWorkout({
    required String dayName,
    required int dayIndex,
    required FitnessGoal goal,
    required FitnessLevel level,
    required Map<String, List<Exercise>> exercisePool,
  }) {
    List<Exercise> exercises = [];
    String description = '';

    // Day-specific focus
    switch (dayIndex) {
      case 0: // Monday - Upper Body
        exercises = _selectExercises(exercisePool['upper'] ?? [], level, 4);
        description = 'Upper body strength and conditioning';
        break;
      case 1: // Tuesday - Lower Body
        exercises = _selectExercises(exercisePool['lower'] ?? [], level, 4);
        description = 'Lower body power and endurance';
        break;
      case 3: // Thursday - Core & Cardio
        exercises = [
          ..._selectExercises(exercisePool['core'] ?? [], level, 2),
          ..._selectExercises(exercisePool['cardio'] ?? [], level, 2),
        ];
        description = 'Core stability and cardiovascular conditioning';
        break;
      case 4: // Friday - Full Body
        exercises = [
          ..._selectExercises(exercisePool['upper'] ?? [], level, 2),
          ..._selectExercises(exercisePool['lower'] ?? [], level, 2),
        ];
        description = 'Full body functional training';
        break;
      case 5: // Saturday - HIIT or Endurance
        if (goal == FitnessGoal.loseWeight || goal == FitnessGoal.increaseEndurance) {
          exercises = _selectExercises(exercisePool['cardio'] ?? [], level, 5);
          description = 'High-intensity interval training';
        } else {
          exercises = _selectExercises(exercisePool['strength'] ?? [], level, 5);
          description = 'Strength and hypertrophy focus';
        }
        break;
      default:
        exercises = _selectExercises(exercisePool['full'] ?? [], level, 4);
        description = 'Balanced workout session';
    }

    return WorkoutPlan(
      name: '$dayName - ${_getFocusName(dayIndex)}',
      description: description,
      exercises: exercises,
    );
  }

  static String _getFocusName(int dayIndex) {
    switch (dayIndex) {
      case 0:
        return 'Upper Body';
      case 1:
        return 'Lower Body';
      case 3:
        return 'Core & Cardio';
      case 4:
        return 'Full Body';
      case 5:
        return 'Power Session';
      default:
        return 'Workout';
    }
  }

  static List<Exercise> _selectExercises(
    List<Exercise> pool,
    FitnessLevel level,
    int count,
  ) {
    if (pool.isEmpty) return [];

    // Adjust sets and duration based on level
    final exercises = pool.take(count).map((e) {
      int sets, duration;

      switch (level) {
        case FitnessLevel.beginner:
          sets = 2;
          duration = 30;
          break;
        case FitnessLevel.intermediate:
          sets = 3;
          duration = 45;
          break;
        case FitnessLevel.advanced:
          sets = 4;
          duration = 60;
          break;
      }

      return Exercise(
        title: e.title,
        gifUrl: e.gifUrl,
        sets: sets,
        duration: duration,
      );
    }).toList();

    return exercises;
  }

  static Map<String, List<Exercise>> _getExercisePool(
    FitnessGoal goal,
    FitnessLevel level,
  ) {
    return {
      'upper': _getUpperBodyExercises(goal),
      'lower': _getLowerBodyExercises(goal),
      'core': _getCoreExercises(goal),
      'cardio': _getCardioExercises(goal),
      'strength': _getStrengthExercises(goal),
      'full': _getFullBodyExercises(goal),
    };
  }

  static List<Exercise> _getUpperBodyExercises(FitnessGoal goal) {
    return [
      Exercise(
        title: 'Push-ups',
        gifUrl: 'https://example.com/pushup.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Pull-ups',
        gifUrl: 'https://example.com/pullup.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Dips',
        gifUrl: 'https://example.com/dips.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Shoulder Press',
        gifUrl: 'https://example.com/shoulder.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Bicep Curls',
        gifUrl: 'https://example.com/bicep.gif',
        sets: 3,
        duration: 45,
      ),
    ];
  }

  static List<Exercise> _getLowerBodyExercises(FitnessGoal goal) {
    return [
      Exercise(
        title: 'Squats',
        gifUrl: 'https://example.com/squat.gif',
        sets: 3,
        duration: 60,
      ),
      Exercise(
        title: 'Lunges',
        gifUrl: 'https://example.com/lunge.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Deadlifts',
        gifUrl: 'https://example.com/deadlift.gif',
        sets: 3,
        duration: 60,
      ),
      Exercise(
        title: 'Leg Press',
        gifUrl: 'https://example.com/legpress.gif',
        sets: 3,
        duration: 60,
      ),
      Exercise(
        title: 'Calf Raises',
        gifUrl: 'https://example.com/calf.gif',
        sets: 3,
        duration: 30,
      ),
    ];
  }

  static List<Exercise> _getCoreExercises(FitnessGoal goal) {
    return [
      Exercise(
        title: 'Plank',
        gifUrl: 'https://example.com/plank.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Crunches',
        gifUrl: 'https://example.com/crunch.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Russian Twists',
        gifUrl: 'https://example.com/twist.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Leg Raises',
        gifUrl: 'https://example.com/legraise.gif',
        sets: 3,
        duration: 45,
      ),
    ];
  }

  static List<Exercise> _getCardioExercises(FitnessGoal goal) {
    return [
      Exercise(
        title: 'Burpees',
        gifUrl: 'https://example.com/burpee.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Mountain Climbers',
        gifUrl: 'https://example.com/mountain.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Jumping Jacks',
        gifUrl: 'https://example.com/jack.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'High Knees',
        gifUrl: 'https://example.com/knees.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Jump Rope',
        gifUrl: 'https://example.com/rope.gif',
        sets: 3,
        duration: 60,
      ),
    ];
  }

  static List<Exercise> _getStrengthExercises(FitnessGoal goal) {
    return [
      ..._getUpperBodyExercises(goal),
      ..._getLowerBodyExercises(goal),
    ];
  }

  static List<Exercise> _getFullBodyExercises(FitnessGoal goal) {
    return [
      Exercise(
        title: 'Burpees',
        gifUrl: 'https://example.com/burpee.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Thrusters',
        gifUrl: 'https://example.com/thruster.gif',
        sets: 3,
        duration: 45,
      ),
      Exercise(
        title: 'Clean and Press',
        gifUrl: 'https://example.com/clean.gif',
        sets: 3,
        duration: 60,
      ),
      Exercise(
        title: 'Turkish Get-up',
        gifUrl: 'https://example.com/turkish.gif',
        sets: 3,
        duration: 60,
      ),
    ];
  }
}
