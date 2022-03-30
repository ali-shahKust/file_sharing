import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

Future<String> uploadFile(context, File file) async {
  String key = file.path.split('/').last;
  ProgressDialog pd = ProgressDialog(context: context);
  pd.show(max: 100, msg: 'File Sharing...');
  try {
    final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: "sharedfiles/" + key,
        onProgress: (progress) {
          pd.update(value:( progress.getFractionCompleted()).toInt() * 100 );

        });
  } on StorageException catch (e) {
  }
  return "sharedfiles/" + key;
}