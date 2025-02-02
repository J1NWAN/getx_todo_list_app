class TodoModel {
  final String id;
  final String title;
  final String? categoryId;
  final bool isCompleted;
  final DateTime createdAt;

  TodoModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.categoryId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
        'createdAt': createdAt.toIso8601String(),
        'categoryId': categoryId,
      };

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        isCompleted: json['isCompleted'],
        createdAt: DateTime.parse(json['createdAt']),
        categoryId: json['categoryId'],
      );
}
