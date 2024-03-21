// Author: warut ruangvatanasirikul 620510664

import 'package:get/get.dart';
import 'package:taskmaster/app/managers/session_manager.dart';
import 'package:taskmaster/app/routes/app_pages.dart';
import 'package:taskmaster/resources/resources.dart';

class SplashController extends GetxController {
  final SessionManager _sessionManager = Get.find();
  final logoName = ImageName.logo;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _goLogin();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _goLogin() {
    _sessionManager.loadSession();

    Get.offAllNamed(Routes.LOGIN);
  }
}
