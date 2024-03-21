// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/routes/app_pages.dart';
import 'package:taskmaster/resources/resources.dart';

class CreateNewTaskButton extends StatelessWidget {
  const CreateNewTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: ElevatedButton(
        onPressed: () => {
          Get.toNamed(
            Routes.CREATE_TASK,
          ),
        },
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: AppColors.taskmasterConfirm,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.add,
                size: 24,
                color: Colors.black,
              ),
              const SizedBox(
                width: 8,
              ),
              Image.asset(
                ImageName.toDoList,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
