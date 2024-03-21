// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/task_type.dart';

class TaskButton extends StatelessWidget {
  const TaskButton({
    super.key,
    required this.taskType,
    required this.function,
    this.isEnabled,
  });

  final TaskType taskType;
  final Function() function;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ?? true ? 1 : 0.6,
      child: ElevatedButton(
        onPressed: () => {
          isEnabled ?? true ? function() : null,
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: isEnabled ?? true
              ? Colors.white
              : AppColors.taskmasterSecondaryGray,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
          child: Row(
            children: [
              Image.asset(
                taskType.imageTaskName,
                width: 45,
                height: 45,
                color: isEnabled ?? true ? Colors.black : Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskType.taskName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isEnabled ?? true ? Colors.black : Colors.white,
                      ),
                    ),
                    Text(
                      taskType.taskDetail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: isEnabled ?? true ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
