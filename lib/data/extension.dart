import 'dart:math';

import 'package:intl/intl.dart';

extension DateTimeExternsion on DateTime {
  String toddMMMMyyyy() {
    return DateFormat("dd MMMM yyyy HH:mm").format(this);
  }
  String toddMMMMhhmm() {
    return DateFormat("dd/MM/HH:mm aa").format(this);
  }
}
getFileSize(bytes) async {

  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(bytes)) + ' ' + suffixes[i];
}