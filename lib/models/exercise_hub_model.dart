class ExerciseHub {
  List<Exercises> exercises = [];

  ExerciseHub({required this.exercises});

  ExerciseHub.fromJson(Map<String, dynamic> json) {
    if (json['exercises'] != null) {
      exercises = [];
      json['exercises'].forEach((v) {
        exercises.add(Exercises.fromJson(v));
      });
    }
  }
}

class Exercises {
  late String id;
  late String title;
  late String thumbnail;
  late String gif;
  late String seconds;

  Exercises({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.gif,
    required this.seconds,
  });

  Exercises.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    gif = json['gif'];
    seconds = json['seconds'];
  }
}
