import 'package:academiapp/app/model/schedule_model.dart';

class UserModel {
  String? uid,
      name,
      status,
      photoUrl,
      creationTime,
      email,
      keyName,
      lastSignInTime;

  List<ScheduleModel>? scheduleModel;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.status,
    this.creationTime,
    this.keyName,
    this.lastSignInTime,
    this.scheduleModel,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
    email = json["email"];
    photoUrl = json["photoUrl"];
    status = json["status"];
    creationTime = json["creationTime"];
    keyName = json["keyName"];
    lastSignInTime = json["lastSignInTime"];
    // scheduleModel = json["scheduleModel"] == 0
    //     ? []
    //     : (json['scheduleModel'] as List)
    //         .map((i) => ScheduleModel.fromJson(i))
    //         .toList();
    scheduleModel = <ScheduleModel>[].length == 0
        ? []
        : List<ScheduleModel>.from(
            json["scheduleModel"].map((x) => ScheduleModel.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["uid"] = this.uid;
    data["email"] = this.email;
    data["name"] = this.name;
    data["photoUrl"] = this.photoUrl;
    data["status"] = this.status;
    data["creationTime"] = this.creationTime;
    data["keyName"] = this.keyName;
    data["lastSignInTime"] = this.lastSignInTime;
    data["scheduleModel"] = this.scheduleModel;
    return data;
  }
}
