class ScheduleModel {
  String? course,
      classCourse,
      date,
      startTime,
      endTime,
      id,
      descriptionCourse,
      status;

  ScheduleModel({
    this.id,
    this.course,
    this.classCourse,
    this.date,
    this.startTime,
    this.endTime,
    this.descriptionCourse,
    this.status,
  });

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    course = json["course"];
    classCourse = json["classCourse"];
    date = json["date"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    descriptionCourse = json["descriptionCourse"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["course"] = this.course;
    data["classCourse"] = this.classCourse;
    data["date"] = this.date;
    data["startTime"] = this.startTime;
    data["endTime"] = this.endTime;
    data["descriptionCourse"] = this.descriptionCourse;
    data["status"] = this.status;
    return data;
  }
}
