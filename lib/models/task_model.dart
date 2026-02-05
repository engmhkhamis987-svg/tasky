class TaskModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;
  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      taskName: task['taskName'],
      taskDescription: task['taskDescription'],
      isHighPriority: task['isHighPriority'],
      isDone: task['isDone'] ?? false,
    );
  }
}
