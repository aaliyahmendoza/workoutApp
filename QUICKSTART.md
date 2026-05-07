# Quick Start Guide

## Running the App

```bash
cd ~/Desktop/workout_app
flutter run
```

## Basic Usage Examples

### 1. Creating User Preferences

```dart
import 'package:workout_app/services/database_service.dart';
import 'package:workout_app/models/user_preferences.dart';

final dbService = DatabaseService();

final preferences = UserPreferences(
  goal: FitnessGoal.buildMuscle,
  age: 28,
  weight: 75.5,
  height: 180.0,
  fitnessLevel: FitnessLevel.intermediate,
);

await dbService.createOrUpdateUserPreferences(preferences);
```

### 2. Reading User Preferences

```dart
final prefs = await dbService.getUserPreferences();
if (prefs != null) {
  print('Goal: ${prefs.goal}');
  print('BMI: ${prefs.bmi?.toStringAsFixed(1)}');
}
```

### 3. Creating a Workout Plan

```dart
import 'package:workout_app/models/workout_plan.dart';
import 'package:workout_app/models/exercise.dart';

final exercises = [
  Exercise(
    title: 'Bench Press',
    gifUrl: 'https://example.com/bench-press.gif',
    sets: 4,
    duration: 120,
  ),
  Exercise(
    title: 'Deadlift',
    gifUrl: 'https://example.com/deadlift.gif',
    sets: 3,
    duration: 90,
  ),
  Exercise(
    title: 'Pull-ups',
    gifUrl: 'https://example.com/pullups.gif',
    sets: 3,
    duration: 60,
  ),
];

final plan = WorkoutPlan(
  name: 'Upper Body Strength',
  description: 'Focus on building upper body strength',
  exercises: exercises,
);

await dbService.createWorkoutPlan(plan);
```

### 4. Reading All Workout Plans

```dart
final plans = await dbService.getAllWorkoutPlans();
for (var plan in plans) {
  print('Plan: ${plan.name}');
  print('Exercises: ${plan.exercises?.length ?? 0}');
}
```

### 5. Updating a Workout Plan

```dart
final plan = await dbService.getWorkoutPlanById(1);
if (plan != null) {
  // Add a new exercise
  final newExercise = Exercise(
    title: 'Shoulder Press',
    gifUrl: 'https://example.com/shoulder-press.gif',
    sets: 3,
    duration: 75,
  );
  
  plan.exercises?.add(newExercise);
  plan.name = 'Updated Upper Body Workout';
  
  await dbService.updateWorkoutPlan(plan);
}
```

### 6. Deleting a Workout Plan

```dart
await dbService.deleteWorkoutPlan(1); // Delete by ID
```

### 7. Using Streams for Reactive UI

```dart
StreamBuilder<UserPreferences?>(
  stream: dbService.watchUserPreferences(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Text('No preferences set');
    }
    
    final prefs = snapshot.data!;
    return Text('Goal: ${prefs.goal}');
  },
)

StreamBuilder<List<WorkoutPlan>>(
  stream: dbService.watchAllWorkoutPlans(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }
    
    final plans = snapshot.data!;
    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(plans[index].name ?? 'Unnamed'),
        );
      },
    );
  },
)
```

## Fitness Goal Options

```dart
enum FitnessGoal {
  loseWeight,      // For weight loss
  buildMuscle,     // For muscle building
  maintainFitness, // For maintenance
  increaseEndurance, // For endurance training
  general,         // General fitness
}
```

## Fitness Level Options

```dart
enum FitnessLevel {
  beginner,      // New to fitness
  intermediate,  // Some experience
  advanced,      // Highly experienced
}
```

## Complete Example: Building a Custom Screen

```dart
import 'package:flutter/material.dart';
import 'package:workout_app/services/database_service.dart';
import 'package:workout_app/models/workout_plan.dart';

class WorkoutListScreen extends StatelessWidget {
  final DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Workouts')),
      body: StreamBuilder<List<WorkoutPlan>>(
        stream: dbService.watchAllWorkoutPlans(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final plans = snapshot.data!;
          
          if (plans.isEmpty) {
            return Center(
              child: Text('No workout plans yet!'),
            );
          }

          return ListView.builder(
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(plan.name ?? 'Unnamed Plan'),
                  subtitle: Text(
                    '${plan.exercises?.length ?? 0} exercises',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await dbService.deleteWorkoutPlan(plan.id);
                    },
                  ),
                  onTap: () {
                    // Navigate to workout detail screen
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create workout screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

## Tips

1. **Singleton Pattern**: `DatabaseService()` always returns the same instance
2. **Transactions**: All write operations use `writeTxn` for data integrity
3. **Auto-increment**: Workout plans get automatic IDs starting from 1
4. **Embedded Models**: Exercise is embedded in WorkoutPlan (not a separate collection)
5. **BMI Calculation**: UserPreferences automatically calculates BMI from height/weight
6. **Timestamps**: createdAt and updatedAt are automatically managed

## Troubleshooting

### If you modify the models:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### If you get build errors:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Database location:
The Isar database is stored in the app's documents directory. To reset:
```dart
await dbService.deleteUserPreferences();
await dbService.deleteAllWorkoutPlans();
```
