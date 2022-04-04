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

Future<String> uploadFile(context, File file) async {
  String key = file.path.split('/').last;
  ProgressDialog pd = ProgressDialog(context: context);
  try {
    final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: "community/" + key,
        onProgress: (progress) {
          Provider.of<AppModel>(context,listen: false).queue =QueueModel(status: true, progress: progress.getFractionCompleted().toString());
          // showDialog(context: context, builder: (context){
          //   return Center(child: MaterialButton(onPressed: (){
          //     Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
          //
          //   },child:Text("Cancel")));
          // });
           // GetIt.I.get<AppModel>().queue = QueueModel(status: true, progress: progress.getFractionCompleted().toString());
          //pd.update(value: (progress.getFractionCompleted()).toInt() * 100);
        }).catchError((StorageException err){
      print("Dxdiag: ${err.message}");

    });
  } on StorageException catch (e) {
    print("Dxdiag: ${e.message}");
  }
  return "community/" + key;
}
