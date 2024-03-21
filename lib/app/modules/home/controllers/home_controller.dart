// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmaster/app/constants/task_type.dart';
import 'package:taskmaster/app/data/models/achievement_model.dart';
import 'package:taskmaster/app/data/models/pokemon_index_model.dart';
import 'package:taskmaster/app/data/models/task_model.dart';
import 'package:taskmaster/app/managers/session_manager.dart';

class HomeController extends GetxController {
  final SessionManager _sessionManager = Get.find();

  final RxInt bottomNavigationIndex = 2.obs;
  final pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );

  late final RxList<TaskModel?> taskHistory;
  late final RxList<int> pokemonInBackpack;
  late final RxList<AchievementModel> achievement;
  late final RxList<TaskType> selectedTask;
  late final RxList<PokemonIndex> pokemon;
  late final RxBool isLoading;

  final RxList<TaskType> selectedRemoveTaskType = RxList<TaskType>([]);
  final RxInt selectedDate = DateTime.now().day.obs;

  final Rx<DateTime> today = DateTime.now().obs;
  final Rx<DateTime> selectedDateCalendar = DateTime.now().obs;
  final Rx<DateTime> focusedDayCalendar = DateTime.now().obs;

  Map<DateTime, List> eventsList = {};
  final RxBool isBackpack = false.obs;

  @override
  void onInit() {
    super.onInit();
    taskHistory = _sessionManager.taskHistory;
    pokemonInBackpack = _sessionManager.pokemonBackpack;
    achievement = _sessionManager.achievement;
    selectedTask = _sessionManager.selectedTask;
    pokemon = _sessionManager.pokemonIndex;
    isLoading = _sessionManager.isLoadingGetPokemon;

    for (var task in taskHistory) {
      final DateTime? taskDate = DateTime.tryParse(task?.date ?? '');
      if (taskDate != null && task?.task != null) {
        eventsList[taskDate] = task!.task!;
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void resetAllData() {
    _sessionManager.clearAllData();
  }

  DateTime getNextDate(int index) {
    return DateTime(DateTime.now().year, DateTime.now().month, index + 1);
  }

  int getCurrentDateCount() {
    return DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
  }

  void changeNewSelectedIndex(int index) {
    selectedDate.value = index + 1;
  }

  void updateTask(int listOutsideNumber, int listInsideNumber, int date) {
    _sessionManager.updateTask(listOutsideNumber, listInsideNumber, date);
    _sessionManager.taskHistory.refresh();
  }

  void getRandomMonster(GetListTask? task) {
    _sessionManager.getRandomPokemon(selectedDate.value, task);
    _sessionManager.getCheckedAchievement();
  }

  void getRemoveSelectedTask(List<TaskType> taskType) {
    _sessionManager.removeSelectedTask(taskType);
    selectedRemoveTaskType.clear();
  }

  void addRemoveTask(TaskType taskType) {
    if (selectedRemoveTaskType.contains(taskType)) {
      selectedRemoveTaskType.remove(taskType);
    } else {
      selectedRemoveTaskType.add(taskType);
    }
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    if (!isSameDay(selectedDateCalendar.value, selectedDay)) {
      selectedDateCalendar.value = selectedDay;
      focusedDayCalendar.value = focusedDay;
    }
  }
}
