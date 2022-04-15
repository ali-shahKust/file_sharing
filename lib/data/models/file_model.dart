import 'dart:io';

class FileMangerModel{

 final  File file;
   bool isSelected =false;
  var thumbNail;
  var imgBytes;
  FileMangerModel({required this.file, required this.isSelected,this.thumbNail,this.imgBytes});
}