class PostsDataModel {
  PostsDataModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  static const String userIdKey = "userId";

  final int id;
  static const String idKey = "id";

  final String title;
  static const String titleKey = "title";

  final String body;
  static const String bodyKey = "body";

  PostsDataModel copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return PostsDataModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  factory PostsDataModel.fromJson(Map<String, dynamic> json) {
    return PostsDataModel(
      userId: json["userId"] ?? 0,
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      body: json["body"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  String toString() {
    return "$userId, $id, $title, $body, ";
  }
}
