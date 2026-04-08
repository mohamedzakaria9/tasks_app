class TaskResponse {
  TaskResponse({
      this.id, 
      this.title, 
      this.description, 
      this.status, 
      this.priority, 
      this.dueDate, 
      this.assignedTo,});

  TaskResponse.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    dueDate = json['dueDate'];
    assignedTo = json['assignedTo'];
  }
  int? id;
  String? title;
  String? description;
  String? status;
  String? priority;
  String? dueDate;
  int? assignedTo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    map['priority'] = priority;
    map['dueDate'] = dueDate;
    map['assignedTo'] = assignedTo;
    return map;
  }

}