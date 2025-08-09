import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'update_task_status_page.dart'; // Ensure this path is correct

// Enum for Task Status
enum TaskStatus {
  notStarted,
  inProgress,
  completed,
}

// Model for a Task
class Task {
  final String id;
  String title; // << CHANGED: Made non-final
  TaskStatus status;
  DateTime dueDate;
  final String stationId;

  Task({
    required this.id,
    required this.title, // Title is now mutable
    required this.status,
    required this.dueDate,
    required this.stationId,
  });
}

class StaffTaskListPage extends StatefulWidget {
  const StaffTaskListPage({Key? key}) : super(key: key);

  @override
  _StaffTaskListPageState createState() => _StaffTaskListPageState();
}

class _StaffTaskListPageState extends State<StaffTaskListPage> {
  final List<Task> _tasks = [
    Task(id: "1", stationId: "VF-002", title: "Electrical Issue", status: TaskStatus.notStarted, dueDate: DateTime(2022, 7, 23)),
    Task(id: "2", stationId: "VF-004", title: "Leak problem", status: TaskStatus.completed, dueDate: DateTime(2022, 7, 23)),
    Task(id: "3", stationId: "VF-007", title: "Physical problem", status: TaskStatus.inProgress, dueDate: DateTime(2022, 7, 23)),
    Task(id: "4", stationId: "VF-012", title: "Another problem", status: TaskStatus.notStarted, dueDate: DateTime(2022, 7, 23)),
    Task(id: "5", stationId: "VF-015", title: "Software Update", status: TaskStatus.inProgress, dueDate: DateTime(2022, 7, 24)),
    Task(id: "6", stationId: "VF-018", title: "Network Connectivity", status: TaskStatus.completed, dueDate: DateTime(2022, 7, 22)),
  ];

  List<Task> _filteredTasks = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredTasks = List.from(_tasks);
    _searchController.addListener(_filterTasks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterTasks);
    _searchController.dispose();
    super.dispose();
  }

  void _filterTasks() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTasks = _tasks.where((task) {
        return task.title.toLowerCase().contains(query) ||
            task.stationId.toLowerCase().contains(query) ||
            _getStatusText(task.status).toLowerCase().contains(query);
      }).toList();
    });
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.notStarted:
        return Colors.redAccent;
      case TaskStatus.inProgress:
        return Color(0xFFFFD166);
      case TaskStatus.completed:
        return Color(0xFF06D6A0);
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.notStarted:
        return "Not started";
      case TaskStatus.inProgress:
        return "In progress";
      case TaskStatus.completed:
        return "Completed";
      default:
        return "Unknown";
    }
  }

  Future<void> _navigateToUpdatePage(Task taskToUpdate, int taskIndexInOriginalList) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateTaskStatusPage(task: taskToUpdate),
      ),
    );

    if (result != null && result is Task) {
      setState(() {
        _tasks[taskIndexInOriginalList] = result;
        _filterTasks();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFF1A1A26),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search Task",
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: Colors.white),
            onPressed: () {
              print("Filter/Sort Tapped");
            },
          ),
        ],
      ),
      body: _filteredTasks.isEmpty
          ? Center(
        child: Text(
          _searchController.text.isNotEmpty ? "No tasks found" : "No tasks available",
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _filteredTasks.length,
        itemBuilder: (context, index) {
          final task = _filteredTasks[index];
          final originalTaskIndex = _tasks.indexWhere((t) => t.id == task.id);

          return GestureDetector(
            onTap: () {
              if (originalTaskIndex != -1) {
                _navigateToUpdatePage(task, originalTaskIndex);
              } else {
                print("Error: Task not found in original list.");
              }
            },
            child: _buildTaskItem(task, theme),
          );
        },
      ),
    );
  }

  Widget _buildTaskItem(Task task, ThemeData theme) {
    final Color cardBackgroundColor = const Color(0xFF1A1A26);
    final Color accentBarColor = Color(0xFF0A6370);
    final Color subtleTextColor = Colors.grey[400]!;

    return Card(
      color: cardBackgroundColor,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 6.0,
              decoration: BoxDecoration(
                color: accentBarColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            task.stationId,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getStatusColor(task.status),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      task.title, // Hiển thị tiêu đề công việc
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: _getStatusColor(task.status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              _getStatusText(task.status),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: _getStatusColor(task.status),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Due date",
                              style: theme.textTheme.bodySmall?.copyWith(color: subtleTextColor, fontSize: 10),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.calendar_today_outlined, color: subtleTextColor, size: 12),
                                SizedBox(width: 4),
                                Text(
                                  DateFormat('MMM dd, yy').format(task.dueDate), // Sửa định dạng ngày nếu cần
                                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}