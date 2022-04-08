class QueueModel {
  int? id;
  String status = "pending";
  String name, size, date;
  String? path, key, isSelected;
  String progress = "0.00";

  QueueModel(
      {this.id,
      this.path,
      this.key,
      this.isSelected,
      required this.name,
      required this.size,
      required this.date,
      required this.status,
      required this.progress});
  factory QueueModel.fromMap(Map<dynamic, dynamic> map) {
    return QueueModel(
      id: map['fileId'],
      name: map['fileName'].toString(),
      path: map['filePath'],
      key: map['fileKey'],
      size: map['fileSize'],
      isSelected: map['fileSelected'],
      date: map['fileDate'],
      progress: '', status: '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'fileName': name,
      'filePath': path,
      'fileKey': key,
      'fileSize': size,
      'fileSelected': isSelected,
      'fileDate': date,

    };
  }

// QueueModel.fromJson(Map<String, dynamic> json){
//   id = json['id'];
//   status = json['status'];
//   name = json['name'];
//
// }
}
