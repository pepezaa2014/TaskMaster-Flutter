// Filename: session_manager.dart
// Author: Drunrapakon Sangraung 630510620
// Description: This file contains the all of the get storage in application.

// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskmaster/app/constants/achievement.dart';
import 'package:taskmaster/app/constants/app_constants.dart';
import 'package:taskmaster/app/constants/task.dart';
import 'package:taskmaster/app/constants/task_type.dart';
import 'package:taskmaster/app/core/api/pokemon_api.dart';
import 'package:taskmaster/app/data/models/achievement_model.dart';
import 'package:taskmaster/app/data/models/app_error_model.dart';
import 'package:taskmaster/app/data/models/pokemon_index_model.dart';
import 'package:taskmaster/app/data/models/task_model.dart';
import 'package:taskmaster/app/data/models/user_model.dart';
import 'package:taskmaster/app/routes/app_pages.dart';
import 'package:taskmaster/app/utils/show_alert.dart';

class SessionManager {
  late final GetStorage _getStorage;

  final PokemonAPI _pokemonAPI = Get.find();

  final Rxn<UserData> user = Rxn();
  final RxList<TaskType> selectedTask = RxList<TaskType>([]);
  final RxList<TaskModel?> taskHistory = RxList<TaskModel?>([]);
  final RxList<int> pokemonBackpack = RxList<int>([]);
  final RxList<AchievementModel> achievement = RxList<AchievementModel>([]);

  final RxList<PokemonIndex> pokemonIndex = RxList<PokemonIndex>([]);
  final RxList<Task> customTask = RxList<Task>([]);

  final today = DateTime.now();

  final RxBool isLoadingGetPokemon = false.obs;

  SessionManager(this._getStorage);

  /// Load the all of the session when application start.
  void loadSession() {
    final checkedUser = _getStorage.read(AppConstants.keyValueUser);
    if (checkedUser != null) {
      user.value = UserData.fromJson(jsonDecode(checkedUser));
    }

    final checkedPokemonIndex =
        _getStorage.read(AppConstants.keyValuePokemonIndex);
    if (checkedPokemonIndex != null) {
      for (var i in checkedPokemonIndex) {
        pokemonIndex.add(PokemonIndex.fromJson(jsonDecode(i)));
      }
      isLoadingGetPokemon(true);
    } else {
      _getPokemonIndex();
    }

    final checkedSelectedAchievement =
        _getStorage.read(AppConstants.keyValueAchievement);
    if (checkedSelectedAchievement != null) {
      for (var i in checkedSelectedAchievement) {
        achievement.add(AchievementModel.fromJson(jsonDecode(i)));
      }
    }

    final checkedSelectedTask =
        _getStorage.read(AppConstants.keyValueSelectedTask);
    if (checkedSelectedTask != null) {
      for (var i in checkedSelectedTask) {
        selectedTask.add(TaskType.values.firstWhere((e) => e.name == i));
      }
    }

    final checkedTaskHistory =
        _getStorage.read(AppConstants.keyValueTaskHistory);
    if (checkedTaskHistory != null) {
      for (int i = 0; i < checkedTaskHistory.length; i++) {
        taskHistory.add(TaskModel.fromJson(jsonDecode(checkedTaskHistory[i])));
      }
    }

    final checkedMonster = _getStorage.read(AppConstants.keyValueBackPack);
    if (checkedMonster != null) {
      for (var i in checkedMonster) {
        pokemonBackpack.add(i);
      }
    }

    if (taskHistory.isNotEmpty) {
      checkTaskNewDay();
    }
  }

  /// Get Pokemon data from API
  Future<void> _getPokemonBatch(
      {required int startIndex, required int endIndex}) async {
    try {
      List<PokemonIndex> batchResult = [];

      for (int index = startIndex; index <= endIndex; index++) {
        final result = await _pokemonAPI.getPokemonIndex(pokemonIndex: index);
        batchResult.add(result);
      }

      isLoadingGetPokemon(false);

      pokemonIndex.addAll(batchResult);

      final List<String> result =
          batchResult.map((pokemon) => json.encode(pokemon.toJson())).toList();
      _getStorage.write(AppConstants.keyValuePokemonIndex, result);
      pokemonIndex.refresh();
    } catch (error) {
      isLoadingGetPokemon(false);
      showAlert(
        title: 'Error',
        message: (error as AppError).message,
      );
    }
  }

  /// Get Pokemon data with dio (dio will broken when it call more than 200 times at once)
  Future<void> _getPokemonIndex() async {
    final int totalPokemonCount = AppConstants.maxPokemonIndexNow;
    final int batchSize = 25;
    final int totalBatches = (totalPokemonCount / batchSize).toInt();

    for (int batchIndex = 0; batchIndex < totalBatches; batchIndex++) {
      final int startIndex = batchIndex * batchSize + 1;
      final int endIndex = (batchIndex + 1) * batchSize;

      await _getPokemonBatch(
        startIndex: startIndex,
        endIndex: endIndex,
      );
    }

    isLoadingGetPokemon(true);

    final List<String> result = <String>[];

    for (var i in pokemonIndex.value) {
      result.add(json.encode(i.toJson()));
    }

    _getStorage.write(AppConstants.keyValuePokemonIndex, result);
    pokemonIndex.refresh();
    isLoadingGetPokemon.refresh();
  }

  /// Update Selected Task and update to the session
  void updateTask(int listOutsideNumber, int listInsideNumber, int date) {
    final selectedTask = taskHistory
        .firstWhere((e) => DateTime.parse(e?.date ?? '').day == date);
    selectedTask?.task?[listOutsideNumber].taskList?[listInsideNumber].isClear =
        true;

    writeGetStorageTaskHistory();
  }

  /// Add Customize Task to session
  void addCustomTaskToCurrentTask(
    List<Task> task,
    DateTime date,
  ) {
    final RxList<CheckTask> waitTask = RxList<CheckTask>();
    for (Task e in task) {
      waitTask.add(
        CheckTask(
          task: e.name,
          isClear: false,
        ),
      );
    }

    if (taskHistory.isNotEmpty) {
      taskHistory
          .firstWhere(
            (e) =>
                DateTime.parse(e?.date ?? '').year == date.year &&
                DateTime.parse(e?.date ?? '').month == date.month &&
                DateTime.parse(e?.date ?? '').day == date.day,
          )
          ?.task
          ?.add(
            GetListTask(
              taskList: waitTask,
              taskType: TaskType.custom.name,
              isGetItem: false,
            ),
          );
    } else {
      taskHistory.add(
        TaskModel(
          task: [
            GetListTask(
              taskList: waitTask,
              taskType: TaskType.custom.name,
              isGetItem: false,
            ),
          ],
          date: today.toString(),
        ),
      );
    }

    selectedTask.add(TaskType.custom);
    writeGetStorageTaskHistory();
    writeGetStorageSelectedTask();
  }

  /// Add Task that create task in everyday
  void addTaskToCurrentTask(
    TaskType taskType,
    DateTime date,
  ) {
    final RxList<CheckTask> waitTask = RxList<CheckTask>();

    for (Task e in taskType.taskList) {
      waitTask.add(
        CheckTask(
          task: e.name,
          isClear: false,
        ),
      );
    }
    if (taskHistory.isNotEmpty) {
      taskHistory
          .firstWhere(
            (e) =>
                DateTime.parse(e?.date ?? '').year == date.year &&
                DateTime.parse(e?.date ?? '').month == date.month &&
                DateTime.parse(e?.date ?? '').day == date.day,
          )
          ?.task
          ?.add(
            GetListTask(
              taskList: waitTask,
              taskType: taskType.name,
              isGetItem: false,
            ),
          );
    } else {
      taskHistory.add(
        TaskModel(
          task: [
            GetListTask(
              taskList: waitTask,
              taskType: taskType.name,
              isGetItem: false,
            ),
          ],
          date: today.toString(),
        ),
      );
    }

    selectedTask.add(taskType);
    writeGetStorageTaskHistory();
    writeGetStorageSelectedTask();
  }

  /// Get random pokemon
  void getRandomPokemon(int date, GetListTask? task) {
    int rand = 0;

    do {
      rand = Random().nextInt(AppConstants.maxPokemonIndexNow);
    } while (pokemonBackpack.contains(rand));

    pokemonBackpack.add(rand);

    writeGetStorageMonster(date, task);
    writeGetStorageTaskHistory();
  }

  /// Remove the task that you do not want to do anymore
  void removeSelectedTask(List<TaskType> taskType) {
    for (var i in taskType) {
      selectedTask.value.remove(i);
      taskHistory.value.last?.task?.removeWhere((e) => e.taskType == i.name);
    }

    writeGetStorageSelectedTask();
  }

  /// Write in Get_storage
  void writeGetStorageAchievement() {
    final List<String> result = <String>[];

    for (var i in achievement) {
      result.add(json.encode(i.toJson()));
    }
    _getStorage.write(AppConstants.keyValueAchievement, result);
    achievement.refresh();
  }

  /// Write in Get_storage
  void writeGetStorageTaskHistory() {
    final List<String> result = <String>[];

    for (var i in taskHistory) {
      result.add(json.encode(i?.toJson()));
    }
    _getStorage.write(AppConstants.keyValueTaskHistory, result);
    taskHistory.refresh();
  }

  /// Write in Get_storage
  void writeGetStorageSelectedTask() {
    final List<String> result = <String>[];

    for (var i in selectedTask.value) {
      result.add(i.name);
    }
    _getStorage.write(AppConstants.keyValueSelectedTask, result);
    selectedTask.refresh();
  }

  /// Write in Get_storage
  void writeGetStorageMonster(int date, GetListTask? list) {
    final List<int> result = <int>[];

    for (var i in pokemonBackpack) {
      result.add(i);
    }
    taskHistory
        .firstWhere((e) => DateTime.parse(e?.date ?? '').day == date)
        ?.task
        ?.firstWhere((e) => e == list)
        .isGetItem = true;
    _getStorage.write(AppConstants.keyValueBackPack, result);

    pokemonBackpack.refresh();
  }

  /// Check the new day
  /// If it new day create all new task
  void checkTaskNewDay() {
    if (taskHistory.firstWhereOrNull(
          (e) =>
              DateTime.parse(e?.date ?? '').year == today.year &&
              DateTime.parse(e?.date ?? '').month == today.month &&
              DateTime.parse(e?.date ?? '').day == today.day,
        ) ==
        null) {
      for (var x in selectedTask.value) {
        final RxList<CheckTask> waitTask = RxList<CheckTask>();

        for (Task e in x.taskList) {
          waitTask.add(
            CheckTask(
              task: e.name,
              isClear: false,
            ),
          );
        }
        if (taskHistory.firstWhereOrNull(
              (e) =>
                  DateTime.parse(e?.date ?? '').year == today.year &&
                  DateTime.parse(e?.date ?? '').month == today.month &&
                  DateTime.parse(e?.date ?? '').day == today.day,
            ) !=
            null) {
          taskHistory
              .firstWhere(
                (e) =>
                    DateTime.parse(e?.date ?? '').year == today.year &&
                    DateTime.parse(e?.date ?? '').month == today.month &&
                    DateTime.parse(e?.date ?? '').day == today.day,
              )
              ?.task
              ?.add(
                GetListTask(
                  taskList: waitTask,
                  taskType: x.name,
                  isGetItem: false,
                ),
              );
        } else {
          taskHistory.add(
            TaskModel(
              task: [
                GetListTask(
                  taskList: waitTask,
                  taskType: x.name,
                  isGetItem: false,
                ),
              ],
              date: today.toString(),
            ),
          );
        }
      }
    }
    writeGetStorageTaskHistory();
  }

  /// Check the achievement
  void getCheckedAchievement() {
    final int countPokemon = pokemonBackpack.value.length;
    int countDaily = 0;
    int countChallenge = 0;
    int countImprove = 0;
    int countCustom = 0;
    int countClear = taskHistory.length;

    for (var i in taskHistory.value) {
      countDaily += i?.task
              ?.where((e) =>
                  e.taskType == TaskType.daily.name && e.isGetItem == true)
              .length ??
          0;

      countChallenge += i?.task
              ?.where((e) =>
                  e.taskType == TaskType.challenge.name && e.isGetItem == true)
              .length ??
          0;

      countImprove += i?.task
              ?.where((e) =>
                  e.taskType == TaskType.improve.name && e.isGetItem == true)
              .length ??
          0;

      countCustom += i?.task
              ?.where((e) =>
                  e.taskType == TaskType.custom.name && e.isGetItem == true)
              .length ??
          0;
    }

    addPokemonAchievements(achievement, countPokemon);
    addDailyAchievements(achievement, countDaily);
    addChallengeAchievements(achievement, countChallenge);
    addImproveAchievements(achievement, countImprove);
    addCustomAchievements(achievement, countCustom);
    addClearAchievements(achievement, countClear);

    writeGetStorageAchievement();
  }

  /// Check the pokemon achievement
  void addPokemonAchievements(
    List<AchievementModel> achievement,
    int countMonster,
  ) {
    final monsterLevels = {
      Achievement.pokemonMaster: 365,
      Achievement.pokemonGold: 100,
      Achievement.pokemonSilver: 10,
      Achievement.pokemonBronze: 1,
    };

    for (var level in monsterLevels.entries) {
      if (countMonster >= level.value) {
        if (achievement
                .firstWhereOrNull((e) => e.achievementName == level.key.name) ==
            null) {
          achievement.add(
            AchievementModel(
              achievementName: level.key.name,
              date: today.toString(),
            ),
          );
        }
        break;
      }
    }
  }

  /// Check the daily achievement
  void addDailyAchievements(
    List<AchievementModel> achievement,
    int countDaily,
  ) {
    final dailyLevels = {
      Achievement.dailyMaster: 365,
      Achievement.dailyGold: 100,
      Achievement.dailySilver: 10,
      Achievement.dailyBronze: 1,
    };

    for (var level in dailyLevels.entries) {
      if (countDaily >= level.value) {
        if (achievement
                .firstWhereOrNull((e) => e.achievementName == level.key.name) ==
            null) {
          achievement.add(
            AchievementModel(
              achievementName: level.key.name,
              date: today.toString(),
            ),
          );
        }
        break;
      }
    }
  }

  /// Check the challenge achievement
  void addChallengeAchievements(
    List<AchievementModel> achievement,
    int countChallenge,
  ) {
    final challengeLevels = {
      Achievement.challengeMaster: 365,
      Achievement.challengeGold: 100,
      Achievement.challengeSilver: 10,
      Achievement.challengeBronze: 1,
    };

    for (var level in challengeLevels.entries) {
      if (countChallenge >= level.value) {
        if (achievement
                .firstWhereOrNull((e) => e.achievementName == level.key.name) ==
            null) {
          achievement.add(
            AchievementModel(
              achievementName: level.key.name,
              date: today.toString(),
            ),
          );
        }
        break;
      }
    }
  }

  /// Check the improve achievement
  void addImproveAchievements(
    List<AchievementModel> achievement,
    int countImprove,
  ) {
    final improveLevels = {
      Achievement.improveMaster: 365,
      Achievement.improveGold: 100,
      Achievement.improveSilver: 10,
      Achievement.improveBronze: 1,
    };

    for (var level in improveLevels.entries) {
      if (countImprove >= level.value) {
        if (achievement
                .firstWhereOrNull((e) => e.achievementName == level.key.name) ==
            null) {
          achievement.add(
            AchievementModel(
              achievementName: level.key.name,
              date: today.toString(),
            ),
          );
        }
        break;
      }
    }
  }

  /// Check the custom achievement
  void addCustomAchievements(
    List<AchievementModel> achievement,
    int countCustom,
  ) {
    final customLevels = {
      Achievement.customMaster: 365,
      Achievement.customGold: 100,
      Achievement.customSilver: 10,
      Achievement.customBronze: 1,
    };

    for (var level in customLevels.entries) {
      if (countCustom >= level.value) {
        if (achievement
                .firstWhereOrNull((e) => e.achievementName == level.key.name) ==
            null) {
          achievement.add(
            AchievementModel(
              achievementName: level.key.name,
              date: today.toString(),
            ),
          );
        }
        break;
      }
    }
  }

  /// Check the clear achievement
  void addClearAchievements(
    List<AchievementModel> achievement,
    int countClear,
  ) {
    final customLevels = {
      Achievement.clearMaster: 365,
      Achievement.clearGold: 100,
      Achievement.clearSilver: 10,
      Achievement.clearBronze: 1,
    };

    for (var level in customLevels.entries) {
      if (countClear >= level.value) {
        if (achievement
                .firstWhereOrNull((e) => e.achievementName == level.key.name) ==
            null) {
          achievement.add(
            AchievementModel(
              achievementName: level.key.name,
              date: today.toString(),
            ),
          );
        }
        break;
      }
    }
  }

  /// Remove all of the data but pokemon data still in application
  Future<void> clearAllData() async {
    await _getStorage.remove(AppConstants.keyValueTaskHistory);
    await _getStorage.remove(AppConstants.keyValueSelectedTask);
    await _getStorage.remove(AppConstants.keyValueCustomTask);
    await _getStorage.remove(AppConstants.keyValueBackPack);
    await _getStorage.remove(AppConstants.keyValueAchievement);
    await _getStorage.remove(AppConstants.keyValueAchievement);

    taskHistory.value = <TaskModel>[];
    selectedTask.value = <TaskType>[];
    pokemonBackpack.value = <int>[];
    achievement.value = <AchievementModel>[];

    taskHistory.refresh();
    selectedTask.refresh();
    pokemonBackpack.refresh();
    achievement.refresh();

    Get.offAllNamed(Routes.LOGIN);
  }
}
