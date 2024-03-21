// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:taskmaster/app/constants/achievement.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/data/models/achievement_model.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    super.key,
    required this.achievement,
    this.listModel,
  });

  final Achievement achievement;
  final List<AchievementModel>? listModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Opacity(
        opacity: listModel?.firstWhereOrNull(
                    (e) => e.achievementName == achievement.name) !=
                null
            ? 1
            : 0.4,
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        64,
                      ),
                    ),
                    border: achievement.achievementColor != null
                        ? Border.all(
                            color: achievement.achievementColor ?? Colors.black,
                            width: 1,
                          )
                        : const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.taskmasterAchievementMasterLeft,
                                AppColors.taskmasterAchievementMasterRight,
                              ],
                            ),
                            width: 1,
                          ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      achievement.achievementImageName,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        achievement.achievementTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        achievement.achievementConditionDetail,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                listModel?.firstWhereOrNull(
                            (e) => e.achievementName == achievement.name) !=
                        null
                    ? Expanded(
                        flex: 1,
                        child: Text(
                          textAlign: TextAlign.end,
                          'Unlock at : ${DateTime.parse(listModel?.firstWhereOrNull((e) => e.achievementName == achievement.name)?.date ?? '').day}/${DateTime.parse(listModel?.firstWhereOrNull((e) => e.achievementName == achievement.name)?.date ?? '').month}/${DateTime.parse(listModel?.firstWhereOrNull((e) => e.achievementName == achievement.name)?.date ?? '').year}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
