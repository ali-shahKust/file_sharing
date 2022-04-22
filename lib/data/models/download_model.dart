class DownloadModel {
  late String url,key,date,size;
  bool isSelected = false;

  DownloadModel({required this.url,required this.key,required this.date,required this.size,required this.isSelected});

  DownloadModel.fromJson(Map<String, dynamic>json){
    url = json['url'];
    key = json['key'];
    date = json['date'];
    size = json['size'];
  }

// "url": result.url,
  // "key": items[i].key,
  // 'date': items[i].lastModified,
  // 'size': items[i].size
}