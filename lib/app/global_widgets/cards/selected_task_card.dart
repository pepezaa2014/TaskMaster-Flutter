// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/task.dart';

class SelectedTaskCard extends StatelessWidget {
  const SelectedTaskCard({
    super.key,
    required this.task,
    this.function,
    this.isSelected,
  });

  final Task task;
  final Function()? function;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ?? false ? 1 : 0.6,
      child: ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColors.taskmasterAchievementSilver;
              } else {
                return isSelected ?? false
                    ? Colors.white
                    : AppColors.taskmasterSecondaryGray;
              }
            },
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              task.imageName,
              width: 32,
              height: 32,
              color: isSelected ?? false ? Colors.black : Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              task.taskName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ?? false ? Colors.black : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
