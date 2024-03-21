// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/task_type.dart';

class TaskTypeCard extends StatelessWidget {
  const TaskTypeCard({
    super.key,
    required this.taskType,
    required this.isSelected,
    required this.function,
    required this.isInSelectedTask,
  });

  final TaskType taskType;
  final bool isSelected;
  final bool isInSelectedTask;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1 : 0.6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor:
              isSelected ? Colors.white : AppColors.taskmasterSecondaryGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadowColor: Colors.grey.withOpacity(0.5),
        ),
        onPressed: () => {
          isInSelectedTask ? function() : null,
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                taskType.imageTaskName,
                width: 60,
                color: isSelected ? Colors.black : Colors.white,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                textAlign: TextAlign.center,
                taskType.taskName,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.black : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
