class Todo {
  final String id;
  final String title;
  final String decription;
  final bool isPrimary;
  final String endDate;

  Todo({
    required this.id,
    required this.title,
    required this.decription,
    required this.isPrimary,
    required this.endDate,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'],
      title: json['title'],
      decription: json['decription'],
      isPrimary: json['isPrimary'] ?? false,
      endDate: json['endDate'] ?? "",
    );
  }
}
