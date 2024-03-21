// Author: drunrapakon sangraung 630510620

class TaskModel {
  List<GetListTask>? task;
  String? date;

  TaskModel({
    this.task,
    this.date,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    if (json['task'] != null) {
      task = <GetListTask>[];
      json['task'].forEach((v) {
        task?.add(GetListTask.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (task != null) {
      data['task'] = task?.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    return data;
  }
}

class GetListTask {
  List<CheckTask>? taskList;
  String? taskType;
  bool? isGetItem;

  GetListTask({
    this.taskList,
    this.taskType,
    this.isGetItem,
  });

  GetListTask.fromJson(Map<String, dynamic> json) {
    if (json['taskList'] != null) {
      taskList = <CheckTask>[];
      json['taskList'].forEach((v) {
        taskList?.add(CheckTask.fromJson(v));
      });
    }
    taskType = json['taskType'];
    isGetItem = json['isGetItem'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (taskList != null) {
      data['taskList'] = taskList?.map((v) => v.toJson()).toList();
    }
    data['taskType'] = taskType;
    data['isGetItem'] = isGetItem;
    return data;
  }
}

class CheckTask {
  String? task;
  bool? isClear;

  CheckTask({
    this.task,
    this.isClear,
  });

  CheckTask.fromJson(Map<String, dynamic> json) {
    //decode
    task = json['task'];
    isClear = json['isClear'];
  }

  Map<String, dynamic> toJson() {
    //encode
    final data = <String, dynamic>{};
    data['task'] = task;
    data['isClear'] = isClear;
    return data;
  }
}
