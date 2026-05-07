class ExerciseData {
  final String id;
  final String name;
  final String gifUrl;
  final String category;
  final String targetMuscle;
  final String equipment;
  final String difficulty;
  final String? description;
  final List<String>? instructions;

  ExerciseData({
    required this.id,
    required this.name,
    required this.gifUrl,
    required this.category,
    required this.targetMuscle,
    required this.equipment,
    required this.difficulty,
    this.description,
    this.instructions,
  });

  factory ExerciseData.fromJson(Map<String, dynamic> json) {
    // Handle different API response formats
    String gifUrl = json['gifUrl'] ?? json['images']?.first ?? '';

    // Extract category from level if needed
    String category = json['category'] ?? json['level'] ?? 'strength';

    // Primary muscles to target muscle mapping
    String targetMuscle = json['targetMuscle'] ??
        json['primaryMuscles']?.first ??
        json['target'] ??
        'full body';

    // Equipment mapping
    String equipment = json['equipment'] ?? 'bodyweight';

    // Difficulty from level
    String difficulty = json['difficulty'] ?? json['level'] ?? 'intermediate';

    return ExerciseData(
      id: json['id']?.toString() ?? json['name']?.toString() ?? '',
      name: json['name'] ?? '',
      gifUrl: gifUrl,
      category: category,
      targetMuscle: targetMuscle,
      equipment: equipment,
      difficulty: difficulty,
      description: json['description'] ?? json['instructions']?.join(' '),
      instructions: json['instructions'] != null
          ? List<String>.from(json['instructions'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gifUrl': gifUrl,
      'category': category,
      'targetMuscle': targetMuscle,
      'equipment': equipment,
      'difficulty': difficulty,
      'description': description,
      'instructions': instructions,
    };
  }

  ExerciseData copyWith({
    String? id,
    String? name,
    String? gifUrl,
    String? category,
    String? targetMuscle,
    String? equipment,
    String? difficulty,
    String? description,
    List<String>? instructions,
  }) {
    return ExerciseData(
      id: id ?? this.id,
      name: name ?? this.name,
      gifUrl: gifUrl ?? this.gifUrl,
      category: category ?? this.category,
      targetMuscle: targetMuscle ?? this.targetMuscle,
      equipment: equipment ?? this.equipment,
      difficulty: difficulty ?? this.difficulty,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
    );
  }
}
