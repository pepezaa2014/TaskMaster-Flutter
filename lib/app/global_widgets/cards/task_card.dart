// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.function,
    this.isDisable,
  });

  final Task task;
  final Function()? function;
  final bool? isDisable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            function != null && isDisable != false ? function!() : null;
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            child: Row(
              children: [
                Image.asset(
                  task.imageName,
                  width: 45,
                  height: 45,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  task.taskName,
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

  Widget _itemShow() {
    return Text(
      '${task.defaultTaskTimes} ${(task.taskUnit ?? '')}',
      textAlign: TextAlign.end,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
