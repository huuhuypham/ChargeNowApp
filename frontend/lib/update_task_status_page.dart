import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'staff_list.dart'; // Import Task and TaskStatus

class UpdateTaskStatusPage extends StatefulWidget {
  final Task task;

  const UpdateTaskStatusPage({Key? key, required this.task}) : super(key: key);

  @override
  _UpdateTaskStatusPageState createState() => _UpdateTaskStatusPageState();
}

class _UpdateTaskStatusPageState extends State<UpdateTaskStatusPage> {
  late TextEditingController _titleController;
  late TaskStatus _selectedStatus;
  late DateTime _selectedFinishDate;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _selectedStatus = widget.task.status;
    _selectedFinishDate = widget.task.dueDate;
    if (widget.task.status == TaskStatus.completed) {
      _selectedFinishDate = widget.task.dueDate;
    } else {
      _selectedFinishDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedFinishDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.tealAccent,
              onPrimary: Colors.black,
              surface: const Color(0xFF1A1A26),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF121212),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedFinishDate) {
      setState(() {
        _selectedFinishDate = picked;
      });
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

  void _resetAll() {
    setState(() {
      _titleController.text = widget.task.title;
      _selectedStatus = widget.task.status;
      if (widget.task.status == TaskStatus.completed) {
        _selectedFinishDate = widget.task.dueDate;
      } else {
        _selectedFinishDate = DateTime.now();
      }
      _reasonController.clear();
    });
  }

  void _updateTask() {
    Task updatedTask = Task(
      id: widget.task.id,
      stationId: widget.task.stationId,
      title: _titleController.text.isNotEmpty ? _titleController.text : widget.task.title, // Sử dụng tiêu đề mới
      status: _selectedStatus,
      dueDate: _selectedStatus == TaskStatus.completed ? _selectedFinishDate : widget.task.dueDate,
    );
    print("Task Update Button Tapped");
    print("Updated Title: ${updatedTask.title}");
    print("Updated Status: $_selectedStatus");
    print("Updated Finish Date: $_selectedFinishDate");
    Navigator.pop(context, updatedTask);
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color cardBackgroundColor = const Color(0xFF1A1A26);
    final Color subtleTextColor = Colors.grey[400]!;
    final Color accentBarColor = Colors.tealAccent.withOpacity(0.6);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Update Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // Đổi tiêu đề AppBar
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Info Header
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
                border: Border(left: BorderSide(color: accentBarColor, width: 6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.stationId, // Hiển thị Station ID
                    style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8), // Thêm khoảng cách
                  // Trường chỉnh sửa tiêu đề công việc
                  TextField(
                    controller: _titleController,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: "Task Title",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none, // Bỏ đường viền mặc định
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Status Selector
            _buildSectionHeader("Status", theme, onReset: () {
              setState(() {
                _selectedStatus = widget.task.status;
              });
            }),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: cardBackgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TaskStatus>(
                  value: _selectedStatus,
                  isExpanded: true,
                  dropdownColor: cardBackgroundColor,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.tealAccent),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  items: TaskStatus.values.map((TaskStatus status) {
                    return DropdownMenuItem<TaskStatus>(
                      value: status,
                      child: Text(_getStatusText(status)),
                    );
                  }).toList(),
                  onChanged: (TaskStatus? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedStatus = newValue;
                        if (newValue == TaskStatus.completed && widget.task.status != TaskStatus.completed) {
                          _selectedFinishDate = DateTime.now();
                        }
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 24),

            // Finish Day Picker
            if (_selectedStatus == TaskStatus.completed) ...[
              _buildSectionHeader("Finish day", theme, onReset: () {
                setState(() {
                  _selectedFinishDate = (widget.task.status == TaskStatus.completed)
                      ? widget.task.dueDate
                      : DateTime.now();
                });
              }),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: cardBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(_selectedFinishDate),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Icon(Icons.calendar_today_outlined, color: Colors.tealAccent, size: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetAll,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      side: BorderSide(color: Colors.grey[600]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Reset All",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _updateTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Update task",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme, {VoidCallback? onReset}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        if (onReset != null)
          TextButton(
            onPressed: onReset,
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(50,30)),
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.tealAccent.withOpacity(0.8), fontSize: 13),
            ),
          ),
      ],
    );
  }
}
