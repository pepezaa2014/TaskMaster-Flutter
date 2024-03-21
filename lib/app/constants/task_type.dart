// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/task.dart';
import 'package:taskmaster/resources/resources.dart';

enum TaskType {
  daily,
  challenge,
  improve,
  custom,
}

extension TaskTypeExtension on TaskType {
  String get taskName {
    switch (this) {
      case TaskType.daily:
        return 'Daily Task';
      case TaskType.challenge:
        return 'Challenge Task';
      case TaskType.improve:
        return 'Improve Yourself Task';
      case TaskType.custom:
        return 'Custom Task';
    }
  }

  String get taskDetail {
    switch (this) {
      case TaskType.daily:
        return 'Better step by step';
      case TaskType.challenge:
        return 'You feel your life is easy? try this "Challenge task"';
      case TaskType.improve:
        return 'Improve yourself to be better than yesterday';
      case TaskType.custom:
        return 'Customize your task for your best performance';
    }
  }

  String get imageTaskName {
    switch (this) {
      case TaskType.daily:
        return ImageName.clock;
      case TaskType.challenge:
        return ImageName.running;
      case TaskType.improve:
        return ImageName.exercise;
      case TaskType.custom:
        return ImageName.drawing;
    }
  }

  List get taskList {
    switch (this) {
      case TaskType.daily:
        return [
          Task.makeBed,
          Task.drinkwater,
          Task.meditate,
          Task.breakfast,
          Task.lunch,
          Task.dinner,
          Task.shower,
          Task.walk,
          Task.sleep,
        ];
      case TaskType.challenge:
        return [
          // Task.bodyweight,
          Task.training,
          Task.workout,
        ];
      case TaskType.improve:
        return [
          Task.readBook,
          Task.sleepTime,
          Task.workout,
          Task.brushTooth,
          Task.skincare,
          Task.writeDaily,
          Task.watchNews,
        ];
      case TaskType.custom:
        return [];
    }
  }

  Color get colorName {
    switch (this) {
      case TaskType.daily:
        return AppColors.taskMasterDailyTaskColor;
      case TaskType.challenge:
        return AppColors.taskMasterChallengeTaskColor;
      case TaskType.improve:
        return AppColors.taskMasterImproveYourselfTaskColor;
      case TaskType.custom:
        return AppColors.taskMasterCustomizeTaskColor;
    }
  }
}
