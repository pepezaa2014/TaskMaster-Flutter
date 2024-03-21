// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmaster/app/constants/app_colors.dart';

class DateSelectedFormat extends StatelessWidget {
  const DateSelectedFormat({
    super.key,
    required this.function,
    required this.isSelected,
    required this.date,
  });

  final DateTime date;
  final Function() function;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    String dayName = DateFormat.E()
        .format(date)
        .substring(0, 2); // Get day name (e.g., Mo, Tu)
    String dayNumber =
        DateFormat('dd').format(date); // Get day number (e.g., 1, 2, 3)

    return SizedBox(
      width: 50,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? AppColors.taskmasterSecondaryGray
              : AppColors.taskmasterPrimaryGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: function,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              dayNumber,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
