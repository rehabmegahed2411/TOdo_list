

class Task {
  int? id;
  String? title;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;

  Task(  {
    this.id,
    
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color, this.title,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    return data;
  }
}