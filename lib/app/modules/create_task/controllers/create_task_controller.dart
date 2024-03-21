// Author: warut ruangvatanasirikul 620510664

// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:taskmaster/app/constants/task.dart';
import 'package:taskmaster/app/constants/task_type.dart';
import 'package:taskmaster/app/managers/session_manager.dart';
import 'package:taskmaster/app/routes/app_pages.dart';

class CreateTaskController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final RxList<Task> selectedCustomTask = RxList<Task>();
  late final RxList<TaskType> selectedTask;
  final RxString alert = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedTask = _sessionManager.selectedTask;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goHome(TaskType taskType) {
    _sessionManager.addTaskToCurrentTask(
      taskType,
      DateTime.now(),
    );

    Get.offAllNamed(Routes.HOME);
  }

  void addTask(Task task) {
    if (selectedCustomTask.contains(task)) {
      selectedCustomTask.remove(task);
    } else {
      selectedCustomTask.add(task);
    }
  }

  void createCustom() {
    if (selectedCustomTask.length < 4) {
      alert.value = 'You need to select at least 4 task.';
    } else {
      alert.value = '';
      _sessionManager.addCustomTaskToCurrentTask(
        selectedCustomTask.value,
        DateTime.now(),
      );

      Get.offAllNamed(Routes.HOME);
    }
  }
}
