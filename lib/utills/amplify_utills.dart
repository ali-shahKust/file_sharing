import 'dart:collection';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/app_model.dart';
import 'package:glass_mor/data/queue_model.dart';
import 'package:glass_mor/ui/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

 uploadFile(context, List<File> file) async {

   file.forEach((element) {
     String key = element.path.split('/').last;

     GetIt.I.get<AppModel>().queue.add(QueueModel(
         id: 1,
         name: key,
         date: element.lastModified().toString(),
         size: element.lengthSync().toString(),
         status: "pending",
         progress:"pending"));
   });
  for (int i = 0; i < file.length; i++) {

    String key = file[i].path.split('/').last;
    print("Dxdiag: ${key}");

     await Amplify.Storage.uploadFile(
          local: file[i],
          key: "community/" + key,
          onProgress: (progress) {
            GetIt.I.get<AppModel>().queue[i]!.name = key;
            GetIt.I.get<AppModel>().queue[i]!.progress = progress.getFractionCompleted().toString();

          });
    print("Dxdiag: ${key}");


  }


}
