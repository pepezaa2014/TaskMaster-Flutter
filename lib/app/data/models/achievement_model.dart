// Author: drunrapakon sangraung 630510620

class AchievementModel {
  String? achievementName;
  String? date;

  AchievementModel({
    this.achievementName,
    this.date,
  });

  AchievementModel.fromJson(Map<String, dynamic> json) {
    achievementName = json['achievementName'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['achievementName'] = achievementName;
    data['date'] = date;
    return data;
  }
}
