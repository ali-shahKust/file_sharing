class QueueModel {
  int? id;
  String status = "pending";
  String name, size, date;
  String progress = "0.00";

  QueueModel(
      {this.id,
      required this.name,
      required this.size,
      required this.date,
      required this.status,
      required this.progress});

  // QueueModel.fromJson(Map<String, dynamic> json){
  //   id = json['id'];
  //   status = json['status'];
  //   name = json['name'];
  //
  // }
}
