import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:timetable_proj/controllers/task_controller.dart';
import 'package:timetable_proj/models/task.dart';

import 'package:timetable_proj/ui/homePage.dart';
import 'package:timetable_proj/ui/theme.dart';
import 'package:timetable_proj/ui/widgets/input_field.dart';
import 'dart:js';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = '9:30 PM';
  String _StartTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Add Break',
                  style: headingStyle,
                ),
                MyInputField(
                  hint: 'Enter your Title',
                  title: 'Title',
                  controller: _titleController,
                ),
                MyInputField(
                    title: 'Date',
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _getDateFromUser(context);
                      },
                    )),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: 'Start Date',
                        hint: _StartTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(context, isStartTime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: 'End Date',
                        hint: _endTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(context, isStartTime: false);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            )),
                      ),
                    ),
                  ],
                ),


                //jjj
                SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorpallet(),
                    MyButton(label: 'Create', onTap: () => _validateDate())
                  ],
                )
              ],
            ),
          )),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty) {
      Get.snackbar(
        'Required',
        'All fields are required !',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Color.fromARGB(255, 102, 133, 156),
        icon: Icon(Icons.warning_amber_rounded),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _StartTime,
      endTime: _endTime,
      color: _selectedColor,
      isCompleted: 0,
    ));

    print('My id is' + '$value');
  }

  _colorpallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TitleStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        Wrap(
            children: List<Widget>.generate(3, (int index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                  print('$index');
                });
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? color1
                        : index == 1
                            ? color2
                            : color3,
                    child: _selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.black,
                            size: 16,
                          )
                        : Container(),
                  )));
        }))
      ],
    );
  }

  _getDateFromUser(BuildContext context) async {
    if (context != null) {
      DateTime? _pickerDate = await showDatePicker(
          context: context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2040));
      if (_pickerDate != null) {
        setState(() {
          _selectedDate = _pickerDate;
        });
      } else {
        print('It is null or something is wrong');
      }
    }
  }

  _getTimeFromUser(BuildContext context, {required bool isStartTime}) async {
    var pickedTime = await _ShowTimePicker(context);
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('Time cancelled');
    } else if (isStartTime == true) {
      setState(() {
        _StartTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _ShowTimePicker(BuildContext context) async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_StartTime.split(':')[0]),
        minute: int.parse(_StartTime.split(':')[1].split(' ')[0]),
      ),
      initialEntryMode: TimePickerEntryMode.input,
    );
  }
}

_appBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 45.0,
    iconTheme: IconThemeData(color: Colors.white),
    leading: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Icon(Icons.arrow_back_ios,
          size: 20, color: Get.isDarkMode ? Colors.white : Colors.white),
    ),
    backgroundColor: Theme.of(context).primaryColor,
  );
  
}
