# Workout App

A comprehensive Flutter fitness application with persistent data storage using Isar database.

## Features

- **User Preferences Management**: Store and manage user profile data including:
  - Fitness goal (lose weight, build muscle, maintain fitness, etc.)
  - Age, weight, and height
  - Fitness level (beginner, intermediate, advanced)
  - Automatic BMI calculation

- **Workout Plan Management**: Create and manage workout plans with:
  - Plan name and description
  - Multiple exercises per plan
  - Exercise details (title, GIF URL, sets, duration)
  - Timestamps for creation and updates

- **Persistent Storage**: All data is stored locally using Isar database and persists even when the app is closed

## Project Structure

```
lib/
├── models/
│   ├── exercise.dart              # Exercise model (embedded in WorkoutPlan)
│   ├── exercise.g.dart            # Generated Isar schema
│   ├── user_preferences.dart      # User preferences model
│   ├── user_preferences.g.dart    # Generated Isar schema
│   ├── workout_plan.dart          # Workout plan model
│   └── workout_plan.g.dart        # Generated Isar schema
├── services/
│   └── database_service.dart      # Singleton database service with CRUD operations
└── main.dart                      # Main app with demo UI
```

## Data Models

### UserPreferences
- `goal`: Fitness goal (enum)
- `age`: User's age (int)
- `weight`: Weight in kg (double)
- `height`: Height in cm (double)
- `fitnessLevel`: Fitness level (enum)
- `bmi`: Calculated BMI (computed property)

### WorkoutPlan
- `id`: Auto-incremented ID
- `name`: Plan name
- `description`: Plan description
- `exercises`: List of Exercise objects
- `createdAt`: Creation timestamp
- `updatedAt`: Last update timestamp

### Exercise (Embedded)
- `title`: Exercise name
- `gifUrl`: URL to exercise GIF
- `sets`: Number of sets
- `duration`: Duration in seconds

## Database Service API

The `DatabaseService` class provides a complete CRUD interface:

### User Preferences
```dart
// Get user preferences
final prefs = await DatabaseService().getUserPreferences();

// Create or update preferences
final newPrefs = UserPreferences(
  goal: FitnessGoal.buildMuscle,
  age: 25,
  weight: 70.0,
  height: 175.0,
  fitnessLevel: FitnessLevel.intermediate,
);
await DatabaseService().createOrUpdateUserPreferences(newPrefs);

// Delete preferences
await DatabaseService().deleteUserPreferences();

// Watch for changes (Stream)
DatabaseService().watchUserPreferences().listen((prefs) {
  // React to changes
});
```

### Workout Plans
```dart
// Get all workout plans
final plans = await DatabaseService().getAllWorkoutPlans();

// Get specific plan by ID
final plan = await DatabaseService().getWorkoutPlanById(1);

// Create new plan
final newPlan = WorkoutPlan(
  name: 'Full Body Workout',
  description: 'A comprehensive routine',
  exercises: [
    Exercise(
      title: 'Push-ups',
      gifUrl: 'https://example.com/pushup.gif',
      sets: 3,
      duration: 60,
    ),
  ],
);
await DatabaseService().createWorkoutPlan(newPlan);

// Update existing plan
plan.name = 'Updated Name';
await DatabaseService().updateWorkoutPlan(plan);

// Delete plan
await DatabaseService().deleteWorkoutPlan(plan.id);

// Delete all plans
await DatabaseService().deleteAllWorkoutPlans();

// Watch for changes (Stream)
DatabaseService().watchAllWorkoutPlans().listen((plans) {
  // React to changes
});
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK

### Installation

1. Navigate to the project directory:
```bash
cd ~/Desktop/workout_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate Isar schema files (already done):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:
```bash
flutter run
```

## Usage

The demo app includes:
- Display of current user preferences and workout plans
- "Create Sample Data" button to generate test data
- "Clear All Data" button to reset the database
- Expandable workout plan cards showing exercises

## Database Initialization

The database is automatically initialized when the app starts:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final dbService = DatabaseService();
  await dbService.isar; // Initialize database
  
  runApp(const MyApp());
}
```

## Regenerating Schema Files

If you modify the data models, regenerate the schema files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Notes

- Isar database files are stored in the app's documents directory
- The `DatabaseService` uses a singleton pattern for consistent database access
- All write operations are wrapped in transactions (`writeTxn`)
- Streams are available for reactive UI updates

## Next Steps

To build a complete fitness app, consider adding:
- User authentication
- Workout tracking and progress history
- Exercise library with real GIF URLs
- Workout scheduling and reminders
- Statistics and analytics
- Social features
- Export/import functionality
