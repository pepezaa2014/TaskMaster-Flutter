// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/task.dart';

class TaskCardWithAction extends StatelessWidget {
  const TaskCardWithAction({
    super.key,
    required this.task,
    required this.currentIndex,
    required this.function,
    required this.onTap,
    this.isDisable,
  });

  final int currentIndex;
  final Task? task;
  final Function() function;
  final Function() onTap;
  final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Slidable(
        enabled: isDisable ?? false ? false : true,
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              onPressed: (BuildContext context) {
                function();
              },
              backgroundColor: AppColors.taskmasterAchievementSilver,
              foregroundColor: Colors.white,
              icon: Icons.check,
              label: 'Clear',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => {
            isDisable ?? false ? null : onTap(),
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isDisable ?? false
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white,
            ),
            child: Row(
              children: [
                Image.asset(
                  task?.imageName ?? "",
                  width: 45,
                  height: 45,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  task?.taskName ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
