import 'package:get/get.dart';
import 'package:timetable_proj/db/db_helper.dart';
import 'package:timetable_proj/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    try {
      int result = await DBHelper.insert(task);
      print('Task added successfully with ID: $result');
      return result;
    } catch (e) {
      print('Failed to add task: $e');
      return 0; // أو يمكنك تحديد قيمة خاصة بالأخطاء هنا
    }
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }
}
