import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/exercise_library/exercise_data.dart';

class ExerciseService {
  static const String exercisesUrl =
      'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json';

  static const String fallbackUrl =
      'https://gist.githubusercontent.com/anonymous/sample/raw/exercises.json';

  Future<List<ExerciseData>> fetchExercises() async {
    try {
      final response = await http.get(Uri.parse(exercisesUrl)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((json) => ExerciseData.fromJson(json))
            .where((exercise) => exercise.name.isNotEmpty)
            .toList()
            .take(50) // Reduced from 100 to 50 for better performance
            .toList();
      } else {
        throw Exception('Failed to load exercises: ${response.statusCode}');
      }
    } catch (e) {
      return _getFallbackExercises();
    }
  }

  List<ExerciseData> _getFallbackExercises() {
    return [
      ExerciseData(
        id: '1',
        name: 'Push-ups',
        gifUrl: 'https://i.pinimg.com/originals/8f/3e/1f/8f3e1f5e5e5e5e5e5e5e5e5e5e5e5e5e.gif',
        category: 'strength',
        targetMuscle: 'chest',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'A classic upper body exercise targeting chest, shoulders, and triceps.',
        instructions: [
          'Start in a plank position with hands shoulder-width apart',
          'Lower your body until your chest nearly touches the floor',
          'Push back up to starting position',
          'Keep your core engaged throughout the movement',
        ],
      ),
      ExerciseData(
        id: '2',
        name: 'Squats',
        gifUrl: 'https://media.giphy.com/media/1qfDU4MJv9xoGtIojR/giphy.gif',
        category: 'strength',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'A fundamental lower body exercise for building leg strength.',
        instructions: [
          'Stand with feet shoulder-width apart',
          'Lower your body by bending your knees and hips',
          'Keep your chest up and back straight',
          'Push through your heels to return to standing',
        ],
      ),
      ExerciseData(
        id: '3',
        name: 'Plank',
        gifUrl: 'https://media.giphy.com/media/l0HlxJMw7rkPTN8sg/giphy.gif',
        category: 'core',
        targetMuscle: 'abs',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'An isometric core exercise that builds stability and endurance.',
        instructions: [
          'Start in a forearm plank position',
          'Keep your body in a straight line from head to heels',
          'Engage your core and hold the position',
          'Breathe steadily throughout',
        ],
      ),
      ExerciseData(
        id: '4',
        name: 'Burpees',
        gifUrl: 'https://media.giphy.com/media/3o6Zt6fzS6qEbLhKWQ/giphy.gif',
        category: 'cardio',
        targetMuscle: 'full body',
        equipment: 'bodyweight',
        difficulty: 'intermediate',
        description: 'A full-body exercise combining strength and cardio.',
        instructions: [
          'Start standing, then drop into a squat position',
          'Kick your feet back into a plank',
          'Do a push-up',
          'Jump your feet back to your hands and jump up',
        ],
      ),
      ExerciseData(
        id: '5',
        name: 'Lunges',
        gifUrl: 'https://media.giphy.com/media/3o7TKMt1VVNkHV2PaE/giphy.gif',
        category: 'strength',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'A unilateral leg exercise that improves balance and strength.',
        instructions: [
          'Stand with feet hip-width apart',
          'Step forward with one leg',
          'Lower your hips until both knees are bent at 90 degrees',
          'Push back to starting position and repeat',
        ],
      ),
      ExerciseData(
        id: '6',
        name: 'Mountain Climbers',
        gifUrl: 'https://media.giphy.com/media/l2SpZtackEqFmMT3G/giphy.gif',
        category: 'cardio',
        targetMuscle: 'core',
        equipment: 'bodyweight',
        difficulty: 'intermediate',
        description: 'A dynamic exercise that targets core and cardiovascular fitness.',
        instructions: [
          'Start in a plank position',
          'Bring one knee toward your chest',
          'Quickly switch legs',
          'Continue alternating at a rapid pace',
        ],
      ),
      ExerciseData(
        id: '7',
        name: 'Pull-ups',
        gifUrl: 'https://media.giphy.com/media/3o7TKPATxjC2JrOc6Y/giphy.gif',
        category: 'strength',
        targetMuscle: 'back',
        equipment: 'pull-up bar',
        difficulty: 'advanced',
        description: 'An upper body exercise targeting back and biceps.',
        instructions: [
          'Hang from a pull-up bar with palms facing away',
          'Pull your body up until chin is over the bar',
          'Lower yourself back down with control',
          'Keep movements smooth and controlled',
        ],
      ),
      ExerciseData(
        id: '8',
        name: 'Jumping Jacks',
        gifUrl: 'https://media.giphy.com/media/3o7TKPdUqqY0VGK1sY/giphy.gif',
        category: 'cardio',
        targetMuscle: 'full body',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'A simple cardio exercise to increase heart rate.',
        instructions: [
          'Start standing with feet together',
          'Jump while spreading legs and raising arms',
          'Return to starting position',
          'Repeat at a steady pace',
        ],
      ),
      ExerciseData(
        id: '9',
        name: 'High Knees',
        gifUrl: '',
        category: 'cardio',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'A high-intensity cardio exercise that targets the legs and core.',
        instructions: [
          'Stand with feet hip-width apart',
          'Run in place lifting knees to hip level',
          'Pump arms vigorously',
          'Keep a fast pace for cardio benefit',
        ],
      ),
      ExerciseData(
        id: '10',
        name: 'Jump Rope',
        gifUrl: '',
        category: 'cardio',
        targetMuscle: 'full body',
        equipment: 'jump rope',
        difficulty: 'intermediate',
        description: 'Classic cardio exercise for endurance and coordination.',
        instructions: [
          'Hold rope handles at hip level',
          'Swing rope over head and jump over it',
          'Land softly on balls of feet',
          'Maintain steady rhythm',
        ],
      ),
      ExerciseData(
        id: '11',
        name: 'Box Jumps',
        gifUrl: '',
        category: 'plyometrics',
        targetMuscle: 'legs',
        equipment: 'box',
        difficulty: 'intermediate',
        description: 'Explosive lower body exercise for power and strength.',
        instructions: [
          'Stand facing a sturdy box or platform',
          'Jump explosively onto the box',
          'Land softly with knees slightly bent',
          'Step down and repeat',
        ],
      ),
      ExerciseData(
        id: '12',
        name: 'Running in Place',
        gifUrl: '',
        category: 'cardio',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'Simple cardio exercise that can be done anywhere.',
        instructions: [
          'Stand with feet hip-width apart',
          'Run in place lifting feet off ground',
          'Pump arms naturally',
          'Maintain a steady pace',
        ],
      ),
      ExerciseData(
        id: '13',
        name: 'Jump Squats',
        gifUrl: '',
        category: 'plyometrics',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'intermediate',
        description: 'Explosive variation of squats for power and cardio.',
        instructions: [
          'Start in squat position',
          'Jump explosively upward',
          'Land softly and immediately lower into next squat',
          'Keep chest up throughout movement',
        ],
      ),
      ExerciseData(
        id: '14',
        name: 'Butt Kicks',
        gifUrl: '',
        category: 'cardio',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'beginner',
        description: 'Cardio exercise that warms up the hamstrings.',
        instructions: [
          'Stand with feet hip-width apart',
          'Run in place kicking heels up toward glutes',
          'Keep core engaged',
          'Maintain quick pace',
        ],
      ),
      ExerciseData(
        id: '15',
        name: 'Skater Hops',
        gifUrl: '',
        category: 'plyometrics',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'intermediate',
        description: 'Lateral jumping exercise for agility and cardio.',
        instructions: [
          'Start on one leg with slight bend',
          'Jump laterally to opposite leg',
          'Land softly and stabilize',
          'Immediately jump to other side',
        ],
      ),
      ExerciseData(
        id: '16',
        name: 'Tuck Jumps',
        gifUrl: '',
        category: 'plyometrics',
        targetMuscle: 'legs',
        equipment: 'bodyweight',
        difficulty: 'advanced',
        description: 'Explosive exercise for maximum power development.',
        instructions: [
          'Stand with feet shoulder-width apart',
          'Jump as high as possible',
          'Bring knees up toward chest',
          'Land softly and repeat',
        ],
      ),
    ];
  }

  List<ExerciseData> searchExercises(List<ExerciseData> exercises, String query) {
    if (query.isEmpty) return exercises;

    final lowercaseQuery = query.toLowerCase();
    return exercises.where((exercise) {
      return exercise.name.toLowerCase().contains(lowercaseQuery) ||
          exercise.category.toLowerCase().contains(lowercaseQuery) ||
          exercise.targetMuscle.toLowerCase().contains(lowercaseQuery) ||
          exercise.equipment.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<ExerciseData> filterByCategory(
      List<ExerciseData> exercises, String category) {
    if (category.isEmpty || category == 'all') return exercises;
    return exercises
        .where((exercise) =>
            exercise.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  List<String> getCategories(List<ExerciseData> exercises) {
    final categories = exercises.map((e) => e.category).toSet().toList();
    categories.sort();
    return ['all', ...categories];
  }
}
