// Author: drunrapakon sangraung 630510620

import 'package:flutter/widgets.dart';
import 'package:taskmaster/app/constants/app_colors.dart';

enum MainTypeButton {
  create,
  signout,
  delete,
}

extension MainTypeButtonExtension on MainTypeButton {
  String get mainTypeButtonName {
    switch (this) {
      case MainTypeButton.create:
        return 'Create';
      case MainTypeButton.signout:
        return 'Sign out';
      case MainTypeButton.delete:
        return 'Delete task';
    }
  }

  Color get mainTypeButtonColor {
    switch (this) {
      case MainTypeButton.create:
        return AppColors.taskmasterConfirm;
      case MainTypeButton.signout:
        return AppColors.taskmasterAlert;
      case MainTypeButton.delete:
        return AppColors.taskmasterAlert;
    }
  }
}
