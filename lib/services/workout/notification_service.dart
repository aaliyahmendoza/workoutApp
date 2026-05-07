class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    // Notifications disabled for now due to API compatibility
  }

  Future<void> showSetCompleteNotification({
    required String exerciseName,
    required int setNumber,
    required int totalSets,
  }) async {
    // Notification system disabled for compatibility
    // Can be re-enabled with proper flutter_local_notifications setup
  }

  Future<void> showRestCompleteNotification({
    required String nextExerciseName,
  }) async {
    // Notification system disabled for compatibility
  }

  Future<void> showWorkoutCompleteNotification({
    required String workoutName,
    required int duration,
    required int exercisesCompleted,
  }) async {
    // Notification system disabled for compatibility
  }

  Future<void> cancelAll() async {
    // Notification system disabled for compatibility
  }
}
