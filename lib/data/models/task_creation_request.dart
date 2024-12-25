class TaskCreationRequest {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? dueDate;

  TaskCreationRequest(
      {this.image, this.title, this.desc, this.priority, this.dueDate});

  TaskCreationRequest.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    priority = json['priority'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['image'] = image;
    data['title'] = title;
    data['desc'] = desc;
    data['priority'] = priority;
    data['dueDate'] = dueDate;
    return data;
  }
}
