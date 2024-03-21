// Author: drunrapakon sangraung 630510620

class User {
  UserData? data;

  User({this.data});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? UserData?.fromJson(json['data']) : null;
  }
}

class UserData {
  String? id;
  String? username;

  UserData({
    this.id,
    this.username,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = username;
    return data;
  }
}
