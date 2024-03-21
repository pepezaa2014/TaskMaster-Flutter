// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/app/constants/app_colors.dart';
import 'package:taskmaster/resources/resources.dart';

enum LoginButtonWithIcon {
  facebook,
  google,
  guest,
}

extension LoginButtonExtension on LoginButtonWithIcon {
  String get loginButtonName {
    switch (this) {
      case LoginButtonWithIcon.facebook:
        return 'Facebook';
      case LoginButtonWithIcon.google:
        return 'Google';
      case LoginButtonWithIcon.guest:
        return 'Guest';
    }
  }

  Color get loginButtonColor {
    switch (this) {
      case LoginButtonWithIcon.facebook:
        return AppColors.taskmasterSecondaryColor;
      case LoginButtonWithIcon.google:
        return AppColors.taskmasterAlert;
      case LoginButtonWithIcon.guest:
        return AppColors.taskmasterAchievementSilver;
    }
  }

  String get loginButtonImage {
    switch (this) {
      case LoginButtonWithIcon.facebook:
        return ImageName.facebook;
      case LoginButtonWithIcon.google:
        return ImageName.google;
      case LoginButtonWithIcon.guest:
        return ImageName.user;
    }
  }
}
