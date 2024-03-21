// Author: drunrapakon sangraung 630510620

import 'package:flutter/material.dart';
import 'package:taskmaster/resources/resources.dart';

enum Task {
  wakeUp,
  makeBed,
  drinkwater,
  meditate,
  breakfast,
  lunch,
  dinner,
  readBook,
  shower,
  sleep,
  sleepTime,
  workout,
  brushTooth,
  skincare,
  walk,
  writeDaily,
  cleanRoom,
  watchNews,
  running,
  cycling,
  swimming,
  dancing,
  yoga,
  weightlifting,
  bodyweight,
  training,
  drawing,
  listenMusic,
  playInstrument,
  petCare,
  coffee,
}

extension TaskExtension on Task {
  String get taskName {
    switch (this) {
      case Task.wakeUp:
        return 'Wake up';
      case Task.makeBed:
        return 'Make a bed';
      case Task.drinkwater:
        return 'Drink water';
      case Task.meditate:
        return 'Meditate';
      case Task.breakfast:
        return 'Breakfast';
      case Task.lunch:
        return 'Lunch';
      case Task.dinner:
        return 'Dinner';
      case Task.readBook:
        return 'Read a book';
      case Task.shower:
        return 'Shower';
      case Task.sleep:
        return 'Sleep';
      case Task.sleepTime:
        return 'Sleep time';
      case Task.workout:
        return 'Workout';
      case Task.brushTooth:
        return 'Brush tooth';
      case Task.skincare:
        return 'Skincare';
      case Task.walk:
        return 'Walk';
      case Task.writeDaily:
        return 'Write a daily';
      case Task.cleanRoom:
        return 'Clean room';
      case Task.watchNews:
        return 'Watch News';
      case Task.running:
        return 'Running';
      case Task.cycling:
        return 'Cycling';
      case Task.swimming:
        return 'Swimming';
      case Task.dancing:
        return 'Dancing';
      case Task.yoga:
        return 'Yoga';
      case Task.weightlifting:
        return 'Weightlifting';
      case Task.bodyweight:
        return 'Bodyweight';
      case Task.training:
        return 'Training sport';
      case Task.drawing:
        return 'Drawing';
      case Task.listenMusic:
        return 'ListenMusic';
      case Task.playInstrument:
        return 'Play instrument';
      case Task.petCare:
        return 'Pet care';
      case Task.coffee:
        return 'Coffee';
    }
  }

  int? get defaultTaskTimes {
    switch (this) {
      case Task.wakeUp:
        return 6;
      case Task.makeBed:
        return 1;
      case Task.drinkwater:
        return 8;
      case Task.meditate:
        return 5;
      case Task.breakfast:
        return 1;
      case Task.lunch:
        return 1;
      case Task.dinner:
        return 1;
      case Task.readBook:
        return 5;
      case Task.shower:
        return 2;
      case Task.sleep:
        return 8;
      case Task.sleepTime:
        return 22;
      case Task.workout:
        return 30;
      case Task.brushTooth:
        return 2;
      case Task.skincare:
        return 1;
      case Task.walk:
        return 1500;
      case Task.writeDaily:
        return 1;
      case Task.cleanRoom:
        return 1;
      case Task.watchNews:
        return 15;
      case Task.running:
        return 15;
      case Task.cycling:
        return 15;
      case Task.swimming:
        return 15;
      case Task.dancing:
        return 15;
      case Task.yoga:
        return 15;
      case Task.training:
        return 15;
      case Task.drawing:
        return 15;
      case Task.listenMusic:
        return 15;
      case Task.playInstrument:
        return 15;
      case Task.petCare:
        return 1;
      case Task.coffee:
        return 2;
      default:
        return null;
    }
  }

  String? get taskUnit {
    switch (this) {
      case Task.makeBed:
        return 'Times';
      case Task.drinkwater:
        return 'Glasses';
      case Task.breakfast:
        return 'Times';
      case Task.lunch:
        return 'Times';
      case Task.dinner:
        return 'Times';
      case Task.readBook:
        return 'Pages';
      case Task.shower:
        return 'Times';
      case Task.sleep:
        return 'Hours';
      case Task.brushTooth:
        return 'Times';
      case Task.skincare:
        return 'Times';
      case Task.walk:
        return 'Steps';
      case Task.writeDaily:
        return 'Day';
      case Task.cleanRoom:
        return 'Times';
      case Task.petCare:
        return 'Times';
      case Task.coffee:
        return 'Cup';
      default:
        return "Minutes";
    }
  }

  bool get isTime {
    switch (this) {
      case Task.wakeUp:
        return true;
      case Task.sleep:
        return true;
      default:
        return false;
    }
  }

  bool get isDuration {
    switch (this) {
      case Task.meditate:
        return true;
      case Task.watchNews:
        return true;
      case Task.swimming:
        return true;
      case Task.dancing:
        return true;
      case Task.yoga:
        return true;
      case Task.training:
        return true;
      default:
        return false;
    }
  }

  String get imageName {
    switch (this) {
      case Task.wakeUp:
        return ImageName.wakeUp;
      case Task.makeBed:
        return ImageName.makeBed;
      case Task.drinkwater:
        return ImageName.drinkWater;
      case Task.meditate:
        return ImageName.meditate;
      case Task.breakfast:
        return ImageName.breakfast;
      case Task.lunch:
        return ImageName.lunch;
      case Task.dinner:
        return ImageName.dinner;
      case Task.readBook:
        return ImageName.readBook;
      case Task.shower:
        return ImageName.shower;
      case Task.sleep:
        return ImageName.sleep;
      case Task.sleepTime:
        return ImageName.sleepTime;
      case Task.workout:
        return ImageName.workout;
      case Task.brushTooth:
        return ImageName.toothBrush;
      case Task.skincare:
        return ImageName.skincare;
      case Task.walk:
        return ImageName.walking;
      case Task.writeDaily:
        return ImageName.writeDaily;
      case Task.cleanRoom:
        return ImageName.cleanRoom;
      case Task.watchNews:
        return ImageName.watchNews;
      case Task.running:
        return ImageName.running;
      case Task.cycling:
        return ImageName.cycling;
      case Task.swimming:
        return ImageName.swimming;
      case Task.dancing:
        return ImageName.dancing;
      case Task.yoga:
        return ImageName.yoga;
      case Task.weightlifting:
        return ImageName.weightLifting;
      case Task.bodyweight:
        return ImageName.bodyWeight;
      case Task.training:
        return ImageName.training;
      case Task.drawing:
        return ImageName.drawing;
      case Task.listenMusic:
        return ImageName.listenMusic;
      case Task.playInstrument:
        return ImageName.playInstrument;
      case Task.petCare:
        return ImageName.petCare;
      case Task.coffee:
        return ImageName.coffee;
    }
  }

  Color get taskColor {
    switch (this) {
      default:
        return Colors.blueAccent;
    }
  }
}
