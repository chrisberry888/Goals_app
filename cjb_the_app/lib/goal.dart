

final String tableGoals = 'goals';

class GoalFields {
  static final List<String> values = [
    id, goal, description, dueDate
  ];

  static final String id = '_id';
  static final String goal = 'goal';
  static final String description = 'description';
  static final String dueDate = 'dueDate';
}

class Goal {
  final int? id;
  final String goal;
  final String description;
  final DateTime dueDate;

  const Goal({
    this.id,
    required this.goal,
    required this.description,
    required this.dueDate
  });




  Goal copy({
    int? id,
    String? goal,
    String? description,
    DateTime? dueDate,
  }) =>
      Goal(
        id: id ?? this.id,
        goal: goal ?? this.goal,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
      );



  Map<String, dynamic> toJson() {
    return {
      GoalFields.id: id,
      GoalFields.goal: goal,
      GoalFields.description: description,
      GoalFields.dueDate: dueDate.toIso8601String()
    };
  }


  static Goal fromJson(Map<String, Object?> json) => Goal(
        id: json[GoalFields.id] as int?,
        goal: json[GoalFields.goal] as String,
        description: json[GoalFields.description] as String,
        dueDate: DateTime.parse(json[GoalFields.dueDate] as String)
      );

}