class TaskEditRequest {
  String id;
  String image;
  String title;
  String desc;
  String priority;
  String status;

  TaskEditRequest({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
  });

  factory TaskEditRequest.fromJson(Map<String, dynamic> json) {
    return TaskEditRequest(
      id: json['_id'],
      image: json['image'],
      title: json['title'],
      desc: json['desc'],
      priority: json['priority'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'title': title,
      'desc': desc,
      'priority': priority,
      'status': status,
    };
  }
}
