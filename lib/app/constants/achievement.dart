// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/resources/resources.dart';

enum Achievement {
  pokemonBronze,
  pokemonSilver,
  pokemonGold,
  pokemonMaster,
  dailyBronze,
  dailySilver,
  dailyGold,
  dailyMaster,
  challengeBronze,
  challengeSilver,
  challengeGold,
  challengeMaster,
  improveBronze,
  improveSilver,
  improveGold,
  improveMaster,
  customBronze,
  customSilver,
  customGold,
  customMaster,
  clearBronze,
  clearSilver,
  clearGold,
  clearMaster,
}

extension AchievementExtension on Achievement {
  String get achievementImageName {
    switch (this) {
      case Achievement.pokemonBronze:
        return ImageName.trophyBronze;
      case Achievement.dailyBronze:
        return ImageName.trophyBronze;
      case Achievement.challengeBronze:
        return ImageName.trophyBronze;
      case Achievement.improveBronze:
        return ImageName.trophyBronze;
      case Achievement.customBronze:
        return ImageName.trophyBronze;
      case Achievement.clearBronze:
        return ImageName.trophyBronze;

      case Achievement.pokemonSilver:
        return ImageName.trophySilver;
      case Achievement.dailySilver:
        return ImageName.trophySilver;
      case Achievement.challengeSilver:
        return ImageName.trophySilver;
      case Achievement.improveSilver:
        return ImageName.trophySilver;
      case Achievement.customSilver:
        return ImageName.trophySilver;
      case Achievement.clearSilver:
        return ImageName.trophySilver;

      case Achievement.pokemonGold:
        return ImageName.trophyGold;
      case Achievement.dailyGold:
        return ImageName.trophyGold;
      case Achievement.challengeGold:
        return ImageName.trophyGold;
      case Achievement.improveGold:
        return ImageName.trophyGold;
      case Achievement.customGold:
        return ImageName.trophyGold;
      case Achievement.clearGold:
        return ImageName.trophyGold;

      case Achievement.pokemonMaster:
        return ImageName.trophyMaster;
      case Achievement.dailyMaster:
        return ImageName.trophyMaster;
      case Achievement.challengeMaster:
        return ImageName.trophyMaster;
      case Achievement.improveMaster:
        return ImageName.trophyMaster;
      case Achievement.customMaster:
        return ImageName.trophyMaster;
      case Achievement.clearMaster:
        return ImageName.trophyMaster;
    }
  }

  String get achievementTitle {
    switch (this) {
      case Achievement.pokemonBronze:
        return 'Pokemon Collection : Bronze Tier';
      case Achievement.dailyBronze:
        return 'Daily Task : Bronze Tier';
      case Achievement.challengeBronze:
        return 'Challenge Task : Bronze Tier';
      case Achievement.improveBronze:
        return 'Improve Yourself Task : Bronze Tier';
      case Achievement.customBronze:
        return 'Custom Task : Bronze Tier';
      case Achievement.clearBronze:
        return 'Clear Task : Bronze Tier';

      case Achievement.pokemonSilver:
        return 'Pokemon Collection : Silver Tier';
      case Achievement.dailySilver:
        return 'Daily Task : Silver Tier';
      case Achievement.challengeSilver:
        return 'Challenge Task : Silver Tier';
      case Achievement.improveSilver:
        return 'Improve Yourself Task : Silver Tier';
      case Achievement.customSilver:
        return 'Custom Task : Silver Tier';
      case Achievement.clearSilver:
        return 'Clear Task : Silver Tier';

      case Achievement.pokemonGold:
        return 'Pokemon Collection : Gold Tier';
      case Achievement.dailyGold:
        return 'Daily Task : Gold Tier';
      case Achievement.challengeGold:
        return 'Challenge Task : Gold Tier';
      case Achievement.improveGold:
        return 'Improve Yourself Task : Gold Tier';
      case Achievement.customGold:
        return 'Custom Task : Gold Tier';
      case Achievement.clearGold:
        return 'Clear Task : Gold Tier';

      case Achievement.pokemonMaster:
        return 'Pokemon Collection : Master Tier';
      case Achievement.dailyMaster:
        return 'Daily Task : Master Tier';
      case Achievement.challengeMaster:
        return 'Challenge Task : Master Tier';
      case Achievement.improveMaster:
        return 'Improve Yourself Task : Master Tier';
      case Achievement.customMaster:
        return 'Custom Task : Master Tier';
      case Achievement.clearMaster:
        return 'Clear Task : Master Tier';
    }
  }

  String get achievementConditionDetail {
    switch (this) {
      case Achievement.pokemonBronze:
        return 'Get 1 monster in inventory';
      case Achievement.dailyBronze:
        return 'Clear Daily Task 1 times';
      case Achievement.challengeBronze:
        return 'Clear Challenge Task 1 times';
      case Achievement.improveBronze:
        return 'Clear Improve Yourself Task 1 times';
      case Achievement.customBronze:
        return 'Clear Custom Task 1 times';
      case Achievement.clearBronze:
        return 'Clear your task 1 day';

      case Achievement.pokemonSilver:
        return 'Get 10 monster in inventory';
      case Achievement.dailySilver:
        return 'Clear Daily Task 10 times';
      case Achievement.challengeSilver:
        return 'Clear Challenge Task 10 times';
      case Achievement.improveSilver:
        return 'Clear Improve Yourself Task 10 times';
      case Achievement.customSilver:
        return 'Clear Custom Task 10 times';
      case Achievement.clearSilver:
        return 'Clear your task 10 day';

      case Achievement.pokemonGold:
        return 'Get 100 monster in inventory';
      case Achievement.dailyGold:
        return 'Clear Daily Task 100 times';
      case Achievement.challengeGold:
        return 'Clear Challenge Task 100 times';
      case Achievement.improveGold:
        return 'Clear Improve Yourself Task 100 times';
      case Achievement.customGold:
        return 'Clear Custom Task 100 times';
      case Achievement.clearGold:
        return 'Clear your task 100 day';

      case Achievement.pokemonMaster:
        return 'Get 365 monster in inventory';
      case Achievement.dailyMaster:
        return 'Clear Daily Task 365 times';
      case Achievement.challengeMaster:
        return 'Clear Challenge Task 365 times';
      case Achievement.improveMaster:
        return 'Clear Improve Yourself Task 365 times';
      case Achievement.customMaster:
        return 'Clear Custom Task 365 times';
      case Achievement.clearMaster:
        return 'Clear your task 365 day';
    }
  }

  Color? get achievementColor {
    switch (this) {
      case Achievement.pokemonBronze:
        return AppColors.taskmasterAchievementBronze;
      case Achievement.dailyBronze:
        return AppColors.taskmasterAchievementBronze;
      case Achievement.challengeBronze:
        return AppColors.taskmasterAchievementBronze;
      case Achievement.improveBronze:
        return AppColors.taskmasterAchievementBronze;
      case Achievement.customBronze:
        return AppColors.taskmasterAchievementBronze;
      case Achievement.clearBronze:
        return AppColors.taskmasterAchievementBronze;

      case Achievement.pokemonSilver:
        return AppColors.taskmasterAchievementSilver;
      case Achievement.dailySilver:
        return AppColors.taskmasterAchievementSilver;
      case Achievement.challengeSilver:
        return AppColors.taskmasterAchievementSilver;
      case Achievement.improveSilver:
        return AppColors.taskmasterAchievementSilver;
      case Achievement.customSilver:
        return AppColors.taskmasterAchievementSilver;
      case Achievement.clearSilver:
        return AppColors.taskmasterAchievementSilver;

      case Achievement.pokemonGold:
        return AppColors.taskmasterAchievementGold;
      case Achievement.dailyGold:
        return AppColors.taskmasterAchievementGold;
      case Achievement.challengeGold:
        return AppColors.taskmasterAchievementGold;
      case Achievement.improveGold:
        return AppColors.taskmasterAchievementGold;
      case Achievement.customGold:
        return AppColors.taskmasterAchievementGold;
      case Achievement.clearGold:
        return AppColors.taskmasterAchievementGold;

      default:
        return null;
    }
  }
}
