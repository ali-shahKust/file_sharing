import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glass_mor/file_manager/custom_widgets/file_manager_custom_widgets/video_thumbnail.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';

class FileIcon extends StatelessWidget {
  final FileSystemEntity file;

  FileIcon({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File f = File(file.path);
    String _extension = extension(f.path).toLowerCase();
    String mimeType = mime(basename(file.path).toLowerCase()) ?? '';
    String type = mimeType.isEmpty ? '' : mimeType.split('/')[0];
    if (_extension == '.apk') {
      return Icon(Icons.android, color: Colors.green);
    } else if (_extension == '.crdownload') {
      return Icon(Icons.download, color: Colors.lightBlue);
    } else if (_extension == '.zip' || _extension.contains('tar')) {
      return Icon(Icons.archive);
    } else if (_extension == '.epub' ||
        _extension == '.pdf' ||
        _extension == '.mobi') {
      return Icon(Icons.file_copy, color: Colors.orangeAccent);
    } else {
      switch (type) {
        case 'image':
          return Container(
            width: 50,
            height: 50,
            child: Image(
              errorBuilder: (b, o, c) {
                return Icon(Icons.image);
              },
              image: ResizeImage(FileImage(File(file.path)),
                  width: 50, height: 50),
            ),
          );
        case 'video':
          return Container(
            height: 100,
            width: 100,
            child: CustomVideoThumbnail(
              path: file.path,
            ),
          );
        case 'audio':
          return Icon(Icons.audiotrack, color: Colors.blue);
        case 'text':
          return Icon(Icons.file_copy_outlined, color: Colors.orangeAccent);
        default:
          return Icon(Icons.file_copy);
      }
    }
  }
}
