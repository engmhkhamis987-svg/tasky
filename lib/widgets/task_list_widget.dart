import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyString,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String emptyString;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyString,
              style: TextStyle(color: Color(0XFFFFFCFC), fontSize: 16),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 50),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  color: Color(0XFF282828),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Row(
                  children: [
                    SizedBox(height: 8),
                    Checkbox(
                      value: tasks[index].isDone,
                      onChanged: (val) {
                        onTap(val, index);
                      },
                      activeColor: Color(0XFF15B86C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 16),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tasks[index].taskName,
                            style: TextStyle(
                              color: tasks[index].isDone
                                  ? Color(0XFFA0A0A0)
                                  : Color(0XFFFFFCFC),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              decoration: tasks[index].isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Color(0XFFA0A0A0),
                              overflow: TextOverflow.ellipsis,
                            ),

                            maxLines: 1,
                          ),
                          if (tasks[index].taskDescription.isNotEmpty)
                            Text(
                              tasks[index].taskDescription,
                              style: TextStyle(
                                color: Color(0XFFC6C6C6),
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: tasks[index].isDone
                            ? Color(0XFFA0A0A0)
                            : Color(0XFFC6C6C6),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
