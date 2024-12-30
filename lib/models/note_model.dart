class NoteDataModel {
  NoteDataModel({
    required this.taskName,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.pritority,
  });

  final String taskName;
  static const String taskNameKey = "task_name";

  final String description;
  static const String descriptionKey = "description";

  final String date;
  static const String dateKey = "date";

  final String time;
  static const String timeKey = "time";

  final List<dynamic> category;
  static const String categoryKey = "category";

  final int pritority;
  static const String pritorityKey = "pritority";

  NoteDataModel copyWith({
    String? taskName,
    String? description,
    String? date,
    String? time,
    List<dynamic>? category,
    int? pritority,
  }) {
    return NoteDataModel(
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      category: category ?? this.category,
      pritority: pritority ?? this.pritority,
    );
  }

  factory NoteDataModel.fromJson(Map<String, dynamic> json) {
    return NoteDataModel(
      taskName: json["task_name"] ?? "",
      description: json["description"] ?? "",
      date: json["date"] ?? "",
      time: json["time"] ?? "",
      category: json["category"] == null
          ? []
          : List<dynamic>.from(json["category"]!.map((x) => x)),
      pritority: json["pritority"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "task_name": taskName,
        "description": description,
        "date": date,
        "time": time,
        "category": category.map((x) => x).toList(),
        "pritority": pritority,
      };

  @override
  String toString() {
    return "$taskName, $description, $date, $time, $category, $pritority, ";
  }
}
