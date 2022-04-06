import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/queue_model.dart';
import 'package:glass_mor/utills/custom_theme.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:provider/provider.dart';

import '../../data/app_model.dart';
import 'dashboard_vm.dart';

class QuesScreen extends StatefulWidget {
  static const routeName = 'queue_screen';

  List<File> files;

  QuesScreen({required this.files});

  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {
  var queue = GetIt.I.get<AppModel>().queue;

  @override
  void initState() {
    //uploadFile(context, widget.files);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = GetIt.I.get<AppModel>();
   return Consumer<DashBoardVm>(builder: (context ,vm , _){
     return model.queue == null
         ? Scaffold(
       body: Column(
         children: [Text("Please wait")],
       ),
     )
         : SafeArea(
       child: Scaffold(
         body: vm.connectionLost?Center(
           child: Text("Connection lost"),
         ):Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             completed==GetIt.I.get<AppModel>().queue.length?Container():SpinKitCircle(
               color: CustomTheme.primaryColor,
             ),
             SizedBox(
               height: 25,
             ),
             Container(
               width: getScreenWidth(context) - 150,
               height: 250,
               decoration: BoxDecoration(
                   shape: BoxShape.circle, color: CustomTheme.primaryColor),
               child: Container(
                 width: getScreenWidth(context) - 170,
                 height: 230,
                 decoration: BoxDecoration(
                     shape: BoxShape.circle, color: Colors.white),
                 child: Center(
                   child: Text("$completed/${GetIt.I.get<AppModel>().queue.length}"),
                 ),
               ),
             ),
             Container(
               width: getScreenWidth(context),
               height: getScreenHeight(context)*0.50,
               child: ListView.builder(
                   itemCount: GetIt.I.get<AppModel>().queue.length,
                   itemBuilder: (context, index) {
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: FittedBox(
                         child: Row(
                           children: [
                             Text(
                                 GetIt.I.get<AppModel>().queue[index]!.name),
                             SizedBox(width: 15,),
                             Text(GetIt.I.get<AppModel>().queue[index]!.progress +"%"),
                           ],
                         ),
                       ),
                     );
                   }),
             )
           ],
         ),
       ),
     );
   });
  }


  // uploadFile(context, List<File> file) async {
  //   queue.clear();
  //   completed = 0;
  //   file.forEach((element) {
  //     String key = element.path.split('/').last;
  //
  //     queue.add(QueueModel(
  //         id: null,
  //         name: key,
  //         date: element.lastModified().toString(),
  //         size: element.lengthSync().toString(),
  //         status: "pending",
  //         progress: "pending"));
  //   });
  //   for (int i = 0; i < file.length; i++) {
  //     String key = file[i].path.split('/').last;
  //
  //     await Amplify.Storage.uploadFile(
  //         local: file[i],
  //         key: "community/" + key,
  //         onProgress: (progress) {
  //           queue[i]!.progress =
  //               (progress.getFractionCompleted() * 100).round().toString();
  //           setState(() {});
  //
  //           print("PROGRESS: ${queue[i]!.progress}");
  //           if( (progress.getFractionCompleted() * 100).round() == 100){
  //             completed=i+1;
  //             setState(() {});
  //
  //           }
  //         });
  //   }
  // }
}
