// Author: warut ruangvatanasirikul 620510664

// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/main_type_button.dart';
import 'package:taskmaster/app/constants/task.dart';
import 'package:taskmaster/app/constants/task_type.dart';
import 'package:taskmaster/app/global_widgets/buttons/main_button.dart';
import 'package:taskmaster/app/global_widgets/buttons/task_button.dart';
import 'package:taskmaster/app/global_widgets/cards/selected_task_card.dart';
import 'package:taskmaster/app/global_widgets/cards/task_card.dart';

import '../controllers/create_task_controller.dart';

class CreateTaskView extends GetView<CreateTaskController> {
  const CreateTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    final selectedTask = controller.selectedTask.value;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TaskButton(
            isEnabled: !selectedTask.contains(TaskType.daily),
            taskType: TaskType.daily,
            function: () => _showBottomSheet(
              context,
              TaskType.daily,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TaskButton(
            isEnabled: !selectedTask.contains(TaskType.challenge),
            taskType: TaskType.challenge,
            function: () => _showBottomSheet(
              context,
              TaskType.challenge,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TaskButton(
            isEnabled: !selectedTask.contains(TaskType.improve),
            taskType: TaskType.improve,
            function: () => _showBottomSheet(
              context,
              TaskType.improve,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TaskButton(
            taskType: TaskType.custom,
            function: () => _showBottomSheet(
              context,
              TaskType.custom,
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(
    BuildContext context,
    TaskType taskType,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: AppColors.taskmasterPrimaryGray,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: taskType == TaskType.custom
                ? _showCustom()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        taskType.taskName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: taskType == TaskType.daily
                            ? _showDaily()
                            : taskType == TaskType.challenge
                                ? _showChallenge()
                                : _showImprove(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MainButton(
                        mainTypeButton: MainTypeButton.create,
                        function: () => {controller.goHome(taskType)},
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _showDaily() {
    final task = TaskType.daily.taskList;
    return ListView.builder(
      itemCount: task.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TaskCard(
            task: task[index],
          ),
        );
      },
    );
  }

  Widget _showChallenge() {
    final task = TaskType.challenge.taskList;
    return ListView.builder(
      itemCount: task.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TaskCard(
            task: task[index],
          ),
        );
      },
    );
  }

  Widget _showImprove() {
    final task = TaskType.improve.taskList;
    return ListView.builder(
      itemCount: task.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TaskCard(
            task: task[index],
          ),
        );
      },
    );
  }

  Widget _showCustom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          TaskType.custom.taskName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: Task.values.length,
            itemBuilder: (BuildContext context, index) {
              return Obx(
                () => SelectedTaskCard(
                  task: Task.values[index],
                  function: () => {
                    controller.addTask(Task.values[index]),
                  },
                  isSelected: controller.selectedCustomTask
                      .contains(Task.values[index]),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Text(
            textAlign: TextAlign.center,
            controller.alert.value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        MainButton(
          mainTypeButton: MainTypeButton.create,
          function: () => {
            controller.createCustom(),
          },
        ),
      ],
    );
  }
}
