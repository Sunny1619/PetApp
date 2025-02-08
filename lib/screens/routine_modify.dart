import 'package:flutter/material.dart';

class RoutineModifyPage extends StatefulWidget {
  @override
  _RoutineModifyPageState createState() => _RoutineModifyPageState();
}

class _RoutineModifyPageState extends State<RoutineModifyPage> {
  List<Map<String, String>> routineTasks = [
    {
      'title': 'Breakfast',
      'description': 'Feed a protein-rich pedigree',
      'time': '10:00 - 12:30 am'
    },
    {
      'title': 'Play',
      'description': 'Play a light game with pet',
      'time': '1:00 - 2:00 pm'
    },
    {
      'title': 'Walk',
      'description': 'Go for a walk',
      'time': '5:00 - 6:00 pm'
    },
  ];

  void _deleteTask(int index) {
    setState(() {
      routineTasks.removeAt(index);
    });
  }

  void _editTask(int index) async {
    final editedTask = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _EditTaskDialog(task: routineTasks[index]),
    );

    if (editedTask != null) {
      setState(() {
        routineTasks[index] = editedTask;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pet's Routine",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final task = routineTasks.removeAt(oldIndex);
                    routineTasks.insert(newIndex, task);
                  });
                },
                proxyDecorator: (child, index, animation) {
                  return Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(16),
                    child: child,
                  );
                },
                children: List.generate(
                  routineTasks.length,
                      (index) => Card(
                    key: ValueKey(routineTasks[index]['title']),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                routineTasks[index]['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.blue),
                                  SizedBox(width: 4),
                                  Text(
                                    routineTasks[index]['time']!,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(height: 20, thickness: 1, color: Colors.grey[300]),
                          Text(
                            routineTasks[index]['description']!,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, size: 20),
                                  onPressed: () => _editTask(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, size: 20),
                                  onPressed: () => _deleteTask(index),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Text('Next', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditTaskDialog extends StatefulWidget {
  final Map<String, String> task;

  _EditTaskDialog({required this.task});

  @override
  __EditTaskDialogState createState() => __EditTaskDialogState();
}

class __EditTaskDialogState extends State<_EditTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task['title']);
    _descriptionController = TextEditingController(text: widget.task['description']);
    _timeController = TextEditingController(text: widget.task['time']);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'title': _titleController.text,
              'description': _descriptionController.text,
              'time': _timeController.text,
            });
          },
          child: Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
