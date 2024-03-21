// Author: drunrapakon sangraung 630510620

// ignore_for_file: invalid_use_of_protected_member

import 'dart:collection';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmaster/app/constants/achievement.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/app/constants/app_constants.dart';
import 'package:taskmaster/app/constants/home_title.dart';
import 'package:taskmaster/app/constants/main_type_button.dart';
import 'package:taskmaster/app/constants/pokemon_types.dart';
import 'package:taskmaster/app/constants/task.dart';
import 'package:taskmaster/app/constants/task_type.dart';
import 'package:taskmaster/app/data/models/pokemon_index_model.dart';
import 'package:taskmaster/app/data/models/task_model.dart';
import 'package:taskmaster/app/global_widgets/buttons/create_new_task_button.dart';
import 'package:taskmaster/app/global_widgets/buttons/main_button.dart';
import 'package:taskmaster/app/global_widgets/buttons/setting_button.dart';
import 'package:taskmaster/app/global_widgets/cards/achievement_card.dart';
import 'package:taskmaster/app/global_widgets/cards/inventory.dart';
import 'package:taskmaster/app/global_widgets/cards/task_card_with_action.dart';
import 'package:taskmaster/app/global_widgets/cards/task_type_card.dart';
import 'package:taskmaster/app/global_widgets/date/date_selected_format.dart';
import 'package:taskmaster/app/global_widgets/dialogs/get_item_dialog.dart';
import 'package:taskmaster/app/global_widgets/dialogs/update_dialog.dart';
import 'package:taskmaster/app/utils/loading_indicator.dart';
import 'package:taskmaster/resources/resources.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => Scaffold(
            appBar: _appbar(),
            body: SafeArea(
              child: _animatedSwitcher(context),
            ),
            bottomNavigationBar: _bottomNavigationBar(),
          ),
        ),
        Obx(
          () => LoadingIndicator(
            isLoading: controller.isLoading.value,
            current: controller.pokemon.length,
            all: AppConstants.maxPokemonIndexNow,
          ),
        ),
      ],
    );
  }

  AnimatedSwitcher _animatedSwitcher(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      switchInCurve: Curves.easeInOut,
      child: _body(
        controller.bottomNavigationIndex.value,
        context,
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Text(
        HomeTitle.values[controller.bottomNavigationIndex.value].homeTitleName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        controller.bottomNavigationIndex.value == 3
            ? Obx(
                () => IconButton(
                  onPressed: () => controller.isBackpack.toggle(),
                  icon: controller.isBackpack.value
                      ? const Icon(
                          Icons.backpack,
                          color: AppColors.taskmasterConfirm,
                        )
                      : const Icon(
                          Icons.no_backpack,
                          color: AppColors.taskmasterAlert,
                        ),
                ),
              )
            : const SizedBox(),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }

  Widget _body(
    int selectedIndex,
    BuildContext context,
  ) {
    switch (selectedIndex) {
      case 0:
        return _calendar();
      case 1:
        return _achievement(context);
      case 2:
        return _home(context);
      case 3:
        return _game();
      case 4:
        return _setting(context);
      default:
        return Container();
    }
  }

  CurvedNavigationBar _bottomNavigationBar() {
    return CurvedNavigationBar(
      height: 60,
      color: AppColors.taskmasterPrimaryColor,
      buttonBackgroundColor: AppColors.taskmasterSecondaryColor,
      index: controller.bottomNavigationIndex.value,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      letIndexChange: (index) => true,
      backgroundColor: AppColors.taskmasterPrimaryColor,
      items: <Widget>[
        _iconBottomNavigationBar(
          icon: ImageName.calendar,
          text: "Calendar",
          isSelected: controller.bottomNavigationIndex.value != 0,
        ),
        _iconBottomNavigationBar(
          icon: ImageName.football,
          text: "Achievement",
          isSelected: controller.bottomNavigationIndex.value != 1,
        ),
        _iconBottomNavigationBar(
          icon: ImageName.home,
          text: "Home",
          isSelected: controller.bottomNavigationIndex.value != 2,
        ),
        _iconBottomNavigationBar(
          icon: ImageName.console,
          text: "Game",
          isSelected: controller.bottomNavigationIndex.value != 3,
        ),
        _iconBottomNavigationBar(
          icon: ImageName.settings,
          text: "Setting",
          isSelected: controller.bottomNavigationIndex.value != 4,
        )
      ],
      onTap: (index) {
        controller.bottomNavigationIndex.value = index;
      },
    );
  }

  Widget _iconBottomNavigationBar({
    required String icon,
    required String text,
    bool? isSelected,
  }) {
    return Padding(
      padding: EdgeInsets.all(
        (isSelected ?? false) ? 0 : 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelected ?? false)
            const SizedBox(
              height: 16,
            ),
          Image.asset(
            icon,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          if (isSelected ?? false)
            const SizedBox(
              height: 8,
            ),
          if (isSelected ?? false)
            Text(
              text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Widget _calendar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 16 / 3,
              ),
              itemCount: TaskType.values.length,
              itemBuilder: (context, index) {
                return _showDotTask(TaskType.values[index]);
              },
            ),
          ),
          _tableCalendar(),
          Expanded(
            // flex: 6,
            child: ListView.builder(
              itemCount: TaskType.values.length,
              itemBuilder: (context, index) {
                return _showTaskNumber(
                  TaskType.values[index],
                  controller.taskHistory.value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _showDotTask(TaskType taskType) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _dotColor(
          color: taskType.colorName,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            taskType.taskName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _showTaskNumber(TaskType taskType, List<TaskModel?> taskData) {
    final RxInt taskNumber = 0.obs;

    for (var i in taskData) {
      if (i?.task
              ?.firstWhereOrNull((e) => e.taskType == taskType.name)
              ?.isGetItem ==
          true) {
        taskNumber.value++;
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _dotColor(
            color: taskType.colorName,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'x $taskNumber',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dotColor({required Color color, bool? padding, bool? container}) {
    return Container(
      alignment: container ?? false ? Alignment.topLeft : null,
      child: Padding(
        padding: padding ?? false
            ? const EdgeInsets.only(
                top: 6,
                left: 6,
              )
            : const EdgeInsets.all(0),
        child: Icon(
          Icons.circle,
          color: color,
          size: 6,
        ),
      ),
    );
  }

  Widget _achievement(context) {
    final achievement = controller.achievement.value;
    final double allAchievementPercent =
        controller.achievement.value.length / Achievement.values.length;

    final List<Achievement> allAchievement = <Achievement>[];
    allAchievement.addAll(Achievement.values);

    achievement.forEach((i) {
      final achievementData = Achievement.values
          .firstWhereOrNull((e) => e.name == i.achievementName);
      allAchievement.sort((a, b) => a == achievementData
          ? -1
          : b == achievementData
              ? 1
              : 0);
    });

    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 32,
        right: 16,
        left: 16,
      ),
      child: Column(
        children: [
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 32,
            animation: true,
            lineHeight: 20.0,
            animationDuration: 1000,
            percent: allAchievementPercent,
            center: Text(
              '${(allAchievementPercent * 100).toStringAsFixed(2)}%',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            barRadius: const Radius.circular(16),
            progressColor: Colors.green,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allAchievement.length,
              itemBuilder: (context, index) {
                return AchievementCard(
                  achievement: allAchievement[index],
                  listModel: achievement,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _home(context) {
    final taskHistory = controller.taskHistory;
    final selectedDate = controller.selectedDate.value;

    final yourTask = taskHistory.firstWhereOrNull(
        (e) => DateTime.parse(e?.date ?? '').day == selectedDate);

    return Stack(
      children: [
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SmoothPageIndicator(
                controller: controller.pageController,
                count: yourTask?.task?.length ?? 1,
                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Colors.white,
                  activeDotColor: AppColors.taskmasterTertiaryColor,
                ),
              ),
            ),
          ),
        ),
        PageView.builder(
          controller: controller.pageController,
          itemCount: yourTask?.task?.length ?? 1,
          itemBuilder: (context, indexPage) {
            final currentThisTask = yourTask?.task?[indexPage];

            return Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 32,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 48,
                            ),
                            yourTask != null
                                ? (currentThisTask?.taskList
                                                    ?.where((e) =>
                                                        e.isClear == true)
                                                    .length ??
                                                0) !=
                                            (currentThisTask
                                                    ?.taskList?.length ??
                                                1) ||
                                        currentThisTask?.isGetItem == true
                                    ? _percentage(
                                        current: currentThisTask?.taskList
                                                ?.where(
                                                    (e) => e.isClear == true)
                                                .length ??
                                            0,
                                        allTask:
                                            currentThisTask?.taskList?.length ??
                                                1,
                                      )
                                    : _getMonsterButton(
                                        currentThisTask,
                                        context,
                                      )
                                : const SizedBox(),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              flex: 6,
                              child: yourTask != null
                                  ? ListView.builder(
                                      itemCount:
                                          currentThisTask?.taskList?.length,
                                      itemBuilder: (context, index) {
                                        return TaskCardWithAction(
                                          task: Task.values.firstWhere((e) =>
                                              e.name ==
                                              currentThisTask
                                                  ?.taskList?[index].task),
                                          currentIndex: 0,
                                          function: () => controller.updateTask(
                                            indexPage,
                                            index,
                                            selectedDate,
                                          ),
                                          onTap: () =>
                                              _showDialogUpdateInventory(
                                            context: context,
                                            task: Task.values.firstWhere((e) =>
                                                e.name ==
                                                currentThisTask
                                                    ?.taskList?[index].task),
                                            function: () =>
                                                controller.updateTask(
                                              indexPage,
                                              index,
                                              selectedDate,
                                            ),
                                          ),
                                          isDisable: currentThisTask
                                              ?.taskList?[index].isClear,
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Text(
                                        'No data in this day',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        const Positioned(
          left: 16,
          top: 72,
          child: CreateNewTaskButton(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: SizedBox(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.getCurrentDateCount(),
              itemBuilder: (context, index) {
                return Obx(
                  () => DateSelectedFormat(
                    date: controller.getNextDate(index),
                    isSelected: controller.selectedDate.value == index + 1,
                    function: () => controller.changeNewSelectedIndex(index),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _game() {
    final List<PokemonIndex> pokemon = controller.pokemon.value;
    final List<int> backPack = controller.pokemonInBackpack.value;

    List<PokemonIndex> pokemonList = pokemon;

    if (controller.isBackpack.value) {
      pokemonList = pokemonList
          .where((e) => controller.pokemonInBackpack.contains(e.id))
          .toList();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return Inventory(
            pokemon: pokemonList[index],
            isContain: backPack.contains(
              pokemonList[index].id,
            ),
            function: () => _showPokemonDetail(
              context,
              pokemonList[index],
            ),
          );
        },
      ),
    );
  }

  Widget _setting(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SettingButton(
            title: 'Reset Data',
            function: () => _showDialogResetAllData(
              context: context,
              function: () => {
                controller.resetAllData(),
              },
            ),
            icon: ImageName.reset,
            color: AppColors.taskmasterConfirm,
          ),
          const SizedBox(
            height: 16,
          ),
          SettingButton(
            title: 'Remove selected task',
            function: () => _showSelectedRemoveSelectedTask(context),
            icon: ImageName.bin,
            color: AppColors.taskmasterAlert,
          ),
        ],
      ),
    );
  }

  Widget _percentage({
    required int current,
    required int allTask,
  }) {
    return Center(
      child: CircularPercentIndicator(
        animation: true,
        animationDuration: 1000,
        radius: 90.0,
        lineWidth: 8.0,
        circularStrokeCap: CircularStrokeCap.round,
        percent: current / allTask,
        center: Text(
          '$current/$allTask',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        progressColor: AppColors.taskmasterConfirm,
      ),
    );
  }

  Widget _getMonsterButton(GetListTask? task, context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.taskMasterGetMonsterButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(240),
          ),
          elevation: 4,
          shadowColor: AppColors.taskMasterGetMonsterButton,
        ),
        onPressed: () => {
          controller.getRandomMonster(task),
          _showDialogGetMonster(
            context: context,
            pokemonIndex: controller.pokemon.value
                .firstWhere((e) => e.id == controller.pokemonInBackpack.last),
          ),
          controller.bottomNavigationIndex.value = 3
        },
        child: const Text(
          textAlign: TextAlign.center,
          'Get Pokemon',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 32,
          ),
        ),
      ),
    );
  }

  Widget _tableCalendar() {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: controller.getHashCode,
    )..addAll(controller.eventsList);

    List _getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Column(
      children: [
        TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            leftChevronIcon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
            ),
            titleCentered: true,
          ),
          eventLoader: (day) {
            return _getEventForDay(day);
          },
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
          ),
          firstDay: DateTime.utc(2024, 1, 1),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: controller.focusedDayCalendar.value,
          onFormatChanged: (format) => {},
          onDaySelected: (selectedDay, focusedDay) => {
            controller.onDaySelected(selectedDay, focusedDay),
          },
          selectedDayPredicate: (day) => isSameDay(
            controller.selectedDateCalendar.value,
            day,
          ),
          onPageChanged: (focusedDay) => {
            controller.focusedDayCalendar.value = focusedDay,
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isNotEmpty) {
                events as List<GetListTask>;
                final List<GetListTask> getItemEvents =
                    events.where((event) => event.isGetItem == true).toList();

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    getItemEvents.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: TaskType.values
                                .firstWhereOrNull((e) =>
                                    e.name == getItemEvents[index].taskType)
                                ?.colorName ??
                            Colors.transparent,
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  void _showSelectedRemoveSelectedTask(
    BuildContext context,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.taskmasterPrimaryGray,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 2 / 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: TaskType.values.length,
                    itemBuilder: (context, index) {
                      final thisTaskType = TaskType.values[index];
                      return Obx(
                        () => TaskTypeCard(
                          taskType: thisTaskType,
                          isSelected:
                              controller.selectedRemoveTaskType.contains(
                            thisTaskType,
                          ),
                          isInSelectedTask: controller.selectedTask.value
                              .contains(thisTaskType),
                          function: () => {
                            controller.addRemoveTask(thisTaskType),
                          },
                        ),
                      );
                    },
                  ),
                ),
                MainButton(
                  mainTypeButton: MainTypeButton.delete,
                  function: () => {
                    _showDialogRemoveTask(
                      context: context,
                      function: () => {
                        controller.getRemoveSelectedTask(
                            controller.selectedRemoveTaskType.value),
                        Navigator.pop(context),
                      },
                    )
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPokemonDetail(
    BuildContext context,
    PokemonIndex pokemonIndex,
  ) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
            color: AppColors.taskmasterPrimaryGray,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: AppColors.taskmasterSecondaryGray,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Default Form',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Image.network(
                                  pokemonIndex.sprites?.frontDefault ?? ''),
                              pokemonIndex.sprites?.backDefault != null
                                  ? Image.network(
                                      pokemonIndex.sprites?.backDefault ?? '')
                                  : const SizedBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: AppColors.taskmasterSecondaryGray,
                        ),
                      ),
                      child: pokemonIndex.sprites?.frontShiny != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Shiny Form',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    pokemonIndex.sprites?.frontShiny != null
                                        ? Image.network(
                                            pokemonIndex.sprites?.frontShiny ??
                                                '')
                                        : const SizedBox(),
                                    pokemonIndex.sprites?.backShiny != null
                                        ? Image.network(
                                            pokemonIndex.sprites?.backShiny ??
                                                '')
                                        : const SizedBox(),
                                  ],
                                )
                              ],
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          '${pokemonIndex.name?.substring(0, 1).toUpperCase()}${pokemonIndex.name?.substring(1)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          ' #${pokemonIndex.id ?? 0}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 125,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pokemonIndex.types?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Image.asset(
                                  height: 24,
                                  PokemonTypes.values
                                          .firstWhereOrNull(
                                            (e) =>
                                                e.name ==
                                                (pokemonIndex.types?[index].type
                                                        ?.name ??
                                                    ''),
                                          )
                                          ?.pokemonTypeImage ??
                                      '',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 8,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showDialogUpdateInventory({
    required context,
    required Task task,
    required Function() function,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateDialog(
          onTap: () {
            function();
            Navigator.of(context).pop();
          },
          title: 'Current Task is : ${task.taskName}',
          contents: 'Do you want to end this task?',
          accept: 'Clear',
          cancel: 'Cancel',
        );
      },
    );
  }

  _showDialogRemoveTask({
    required context,
    required Function() function,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateDialog(
          onTap: () {
            function();
            Navigator.of(context).pop();
          },
          alert: true,
          title: 'Be Careful !!',
          contents: 'Do you want to remove this task?',
          accept: 'Confirm',
          cancel: 'Cancel',
        );
      },
    );
  }

  _showDialogResetAllData({
    required context,
    required Function() function,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return UpdateDialog(
          onTap: () {
            function();
            Navigator.of(context).pop();
          },
          alert: true,
          title: 'Be Careful !!',
          contents:
              'If you reset all data, all data can not recovery.\nDo you want to remove all data?',
          accept: 'Confirm',
          cancel: 'Cancel',
        );
      },
    );
  }

  _showDialogGetMonster({
    required context,
    required PokemonIndex pokemonIndex,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return GetItemDialog(
          pokemonIndex: pokemonIndex,
        );
      },
    );
  }
}
