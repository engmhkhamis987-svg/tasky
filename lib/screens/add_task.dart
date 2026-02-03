import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  bool isHighPriority = true;

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
    taskDescController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF181818),
      appBar: AppBar(
        centerTitle: false,
        title: Text('New Task'),
        backgroundColor: Color(0XFF181818),
        iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
        titleTextStyle: TextStyle(
          color: Color(0xffFFFCFC),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Name',
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: taskNameController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0XFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Finish UI design for login screen',
                    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
                  ),
                  style: TextStyle(color: Color(0XFFFFFCFC)),
                  validator: (value) {
                    if (value!.trim() == "" || value.trim().isEmpty) {
                      return 'Please enter task name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Task Description',
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  maxLines: 5,
                  controller: taskDescController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0XFF282828),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText:
                        'Finish onboarding UI and hand off to devs by Thursday.',
                    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
                  ),
                  style: TextStyle(color: Color(0XFFFFFCFC)),
                  validator: (value) {
                    if (value!.trim() == "" || value.trim().isEmpty) {
                      return 'Please enter task description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'High Priority  ',
                      style: TextStyle(
                        color: Color(0XFFFFFCFC),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Switch(
                      value: isHighPriority,
                      onChanged: (value) {
                        setState(() {
                          isHighPriority = value;
                        });
                      },
                      activeThumbColor: Color(0XFFFFFCFC),
                      activeTrackColor: Color(0XFF15B86C),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: ElevatedButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String taskName = taskNameController.text.trim();
              String taskDesc = taskDescController.text.trim();
              bool priority = isHighPriority;

              Navigator.pop(context);
            }
          },
          label: Text("Add Task"),
          icon: Icon(Icons.add),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0XFF15B86C),
            foregroundColor: Color(0xffFFFCFC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            fixedSize: Size(MediaQuery.of(context).size.width, 44),
          ),
        ),
      ),
    );
  }
}
