// Author: warut ruangvatanasirikul 620510664

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taskmaster/app/constants/app_constants.dart';
import 'package:taskmaster/app/constants/login_button_with_icon.dart';
import 'package:taskmaster/app/global_widgets/buttons/login_button.dart';
import 'package:taskmaster/app/utils/loading_indicator.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: _body(
              context: context,
            ),
          ),
        ),
        Obx(
          () {
            return LoadingIndicator(
              isLoading: controller.isLoading.value,
              current: controller.pokemon.length,
              all: AppConstants.maxPokemonIndexNow,
            );
          },
        ),
      ],
    );
  }

  Widget _body({
    required BuildContext context,
  }) {
    final imageLogo = controller.imageLogo;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imageLogo,
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 32,
            ),
            // LoginButton(
            //   loginType: LoginButtonWithIcon.google,
            //   goWhere: () => controller.goHome(),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            // LoginButton(
            //   loginType: LoginButtonWithIcon.facebook,
            //   goWhere: () => controller.goHome(),
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            LoginButton(
              loginType: LoginButtonWithIcon.guest,
              goWhere: () => controller.goCreateNewTask(),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '204311 - MOBILE APP DEV FRAMEWORKS',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
