// Author: warut ruangvatanasirikul 620510664

// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:get/get.dart';
import 'package:taskmaster/app/data/models/pokemon_index_model.dart';
import 'package:taskmaster/app/data/models/task_model.dart';
import 'package:taskmaster/app/managers/session_manager.dart';
import 'package:taskmaster/app/routes/app_pages.dart';
import 'package:taskmaster/resources/resources.dart';

class LoginController extends GetxController {
  final SessionManager _sessionManager = Get.find();
  // late final Rxn<UserData> idUser;
  late final RxList<TaskModel?> taskHistory;
  late final RxBool isLoading;
  late final RxList<PokemonIndex> pokemon;

  final imageLogo = ImageName.logo;

  @override
  void onInit() {
    super.onInit();
    taskHistory = _sessionManager.taskHistory;
    isLoading = _sessionManager.isLoadingGetPokemon;
    pokemon = _sessionManager.pokemonIndex;
  }

  @override
  void onReady() {
    super.onReady();
    if (taskHistory.value.isNotEmpty) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  String _generateRandomCode(int length) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  void goCreateNewTask() {
    Get.offAllNamed(Routes.CREATE_TASK);
  }

  Future<void> loginWithGuest() async {
    await _generateRandomCode(13);

    Get.offAllNamed(Routes.HOME);
  }
}
