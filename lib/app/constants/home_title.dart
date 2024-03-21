// Author: drunrapakon sangraung 630510620

enum HomeTitle {
  calendar,
  achievement,
  home,
  game,
  setting,
}

extension HomeTitleExtension on HomeTitle {
  String get homeTitleName {
    switch (this) {
      case HomeTitle.calendar:
        return "Calendar";
      case HomeTitle.achievement:
        return "Achievement";
      case HomeTitle.home:
        return "Home";
      case HomeTitle.game:
        return "Pokemon Collection";
      case HomeTitle.setting:
        return "Setting";
    }
  }
}
