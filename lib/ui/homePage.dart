import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timetable_proj/models/task.dart';
import 'package:timetable_proj/services/theme_services.dart';
import 'package:timetable_proj/ui/add_task_bar.dart';
import 'package:timetable_proj/ui/theme.dart';
import 'package:timetable_proj/ui/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  List<TaskInfo> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          Expanded(child: HourlyTimeline(tasks: tasks))
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 45.0,
      iconTheme: IconThemeData(color: Colors.white),
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.white,
        ),
      ),
      backgroundColor: Color(0xFF8ABAC5),
    );
  }

  Widget _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  'Today',
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(
            label: '+Add Task',
            onTap: () async {
              TaskInfo? newTask = await Get.to(AddTaskPage());
              // Handle the new task as needed
              if (newTask != null) {
                setState(() {
                  tasks.add(newTask);
                });
                // Do something with the new task
                print('New Task: $newTask');
              }
            },
          ),
        ],
      ),
    );
  }
}

class HourlyTimeline extends StatelessWidget {
  HourlyTimeline({required this.tasks});
  // Dummy list of tasks for testing
  final List<TaskInfo> tasks;
  // Add more tasks as needed

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index = 0; index < 24; index++)
                  _buildTimelineHour(index + 1),
              ],
            ),
            for (TaskInfo task in tasks) _buildTaskWidget(context, task),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineHour(int hour) {
    String formattedHour = hour % 12 == 0 ? '12' : (hour % 12).toString();
    String amPm = hour < 12 ? 'AM' : 'PM';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$formattedHour:00 $amPm',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTaskWidget(BuildContext context, TaskInfo task) {
    double startFraction = task.startTime.hour + (task.startTime.minute / 60)/24;
    double endFraction = task.endTime.hour + (task.endTime.minute / 60)/24;
    double topPosition = (startFraction ) * 0.8;
    double taskHeight = ((endFraction- startFraction) ) * 0.8;

    return Positioned(
      top: topPosition,
      left: 50, // Adjust the left position as needed
      child: FractionallySizedBox(
        heightFactor: taskHeight,
        widthFactor: 0.8,
        child: Container(
          color: Colors.blue, // Adjust the color as needed
          child: Center(
            child: Text(
              task.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
