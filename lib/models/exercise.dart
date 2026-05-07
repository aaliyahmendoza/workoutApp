import 'package:isar/isar.dart';

part 'exercise.g.dart';

@embedded
class Exercise {
  String? title;
  String? gifUrl;
  int? sets;
  int? duration; // in seconds

  Exercise({
    this.title,
    this.gifUrl,
    this.sets,
    this.duration,
  });

  Exercise copyWith({
    String? title,
    String? gifUrl,
    int? sets,
    int? duration,
  }) {
    return Exercise(
      title: title ?? this.title,
      gifUrl: gifUrl ?? this.gifUrl,
      sets: sets ?? this.sets,
      duration: duration ?? this.duration,
    );
  }
}
