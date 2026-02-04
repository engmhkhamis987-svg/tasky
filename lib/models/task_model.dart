class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;
  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> task) {
    return TaskModel(
      taskName: task['taskName'],
      taskDescription: task['taskDescription'],
      isHighPriority: task['isHighPriority'],
      isDone: task['isDone'] ?? false,
    );
  }
}
