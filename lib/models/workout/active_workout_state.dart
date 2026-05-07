class ActiveWorkoutState {
  final String workoutId;
  final String workoutName;
  final int currentExerciseIndex;
  final int currentSet;
  final int totalExercises;
  final String currentExerciseName;
  final int currentExerciseSets;
  final int currentExerciseDuration;
  final DateTime startTime;
  final bool isRestPeriod;
  final int restTimeRemaining;
  final int exerciseTimeRemaining;
  final List<String> completedExerciseIds;

  ActiveWorkoutState({
    required this.workoutId,
    required this.workoutName,
    this.currentExerciseIndex = 0,
    this.currentSet = 1,
    required this.totalExercises,
    required this.currentExerciseName,
    this.currentExerciseSets = 3,
    this.currentExerciseDuration = 60,
    DateTime? startTime,
    this.isRestPeriod = false,
    this.restTimeRemaining = 0,
    this.exerciseTimeRemaining = 0,
    this.completedExerciseIds = const [],
  }) : startTime = startTime ?? DateTime.now();

  double get progress =>
      totalExercises > 0 ? currentExerciseIndex / totalExercises : 0;

  int get completedExercises => completedExerciseIds.length;

  Map<String, dynamic> toJson() {
    return {
      'workoutId': workoutId,
      'workoutName': workoutName,
      'currentExerciseIndex': currentExerciseIndex,
      'currentSet': currentSet,
      'totalExercises': totalExercises,
      'currentExerciseName': currentExerciseName,
      'currentExerciseSets': currentExerciseSets,
      'currentExerciseDuration': currentExerciseDuration,
      'startTime': startTime.toIso8601String(),
      'isRestPeriod': isRestPeriod,
      'restTimeRemaining': restTimeRemaining,
      'exerciseTimeRemaining': exerciseTimeRemaining,
      'completedExerciseIds': completedExerciseIds,
    };
  }

  factory ActiveWorkoutState.fromJson(Map<String, dynamic> json) {
    return ActiveWorkoutState(
      workoutId: json['workoutId'] ?? '',
      workoutName: json['workoutName'] ?? '',
      currentExerciseIndex: json['currentExerciseIndex'] ?? 0,
      currentSet: json['currentSet'] ?? 1,
      totalExercises: json['totalExercises'] ?? 0,
      currentExerciseName: json['currentExerciseName'] ?? '',
      currentExerciseSets: json['currentExerciseSets'] ?? 3,
      currentExerciseDuration: json['currentExerciseDuration'] ?? 60,
      startTime: DateTime.parse(json['startTime']),
      isRestPeriod: json['isRestPeriod'] ?? false,
      restTimeRemaining: json['restTimeRemaining'] ?? 0,
      exerciseTimeRemaining: json['exerciseTimeRemaining'] ?? 0,
      completedExerciseIds:
          List<String>.from(json['completedExerciseIds'] ?? []),
    );
  }

  ActiveWorkoutState copyWith({
    String? workoutId,
    String? workoutName,
    int? currentExerciseIndex,
    int? currentSet,
    int? totalExercises,
    String? currentExerciseName,
    int? currentExerciseSets,
    int? currentExerciseDuration,
    DateTime? startTime,
    bool? isRestPeriod,
    int? restTimeRemaining,
    int? exerciseTimeRemaining,
    List<String>? completedExerciseIds,
  }) {
    return ActiveWorkoutState(
      workoutId: workoutId ?? this.workoutId,
      workoutName: workoutName ?? this.workoutName,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      currentSet: currentSet ?? this.currentSet,
      totalExercises: totalExercises ?? this.totalExercises,
      currentExerciseName: currentExerciseName ?? this.currentExerciseName,
      currentExerciseSets: currentExerciseSets ?? this.currentExerciseSets,
      currentExerciseDuration:
          currentExerciseDuration ?? this.currentExerciseDuration,
      startTime: startTime ?? this.startTime,
      isRestPeriod: isRestPeriod ?? this.isRestPeriod,
      restTimeRemaining: restTimeRemaining ?? this.restTimeRemaining,
      exerciseTimeRemaining:
          exerciseTimeRemaining ?? this.exerciseTimeRemaining,
      completedExerciseIds: completedExerciseIds ?? this.completedExerciseIds,
    );
  }
}
