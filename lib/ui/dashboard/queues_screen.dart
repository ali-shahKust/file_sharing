import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/utills/custom_theme.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:provider/provider.dart';
import 'package:glass_mor/data/extension.dart';

import '../../data/app_model.dart';
import 'dashboard_vm.dart';

class QuesScreen extends StatefulWidget {
  static const routeName = 'queue_screen';

  List<File> files;

  QuesScreen({Key? key, required this.files}) : super(key: key);

  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {
  var queue = GetIt.I.get<AppModel>().queue;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardVm>(builder: (context, vm, _) {
      return SafeArea(
        child: Scaffold(
          body: vm.connectionLost
              ? const Center(
                  child: Text("Connection lost"),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    completed == GetIt.I.get<AppModel>().queue.length
                        ? Container()
                        : const SpinKitCircle(
                            color: CustomTheme.primaryColor,
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: getScreenWidth(context) - 150,
                      height: 250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomTheme.primaryColor),
                      child: Container(
                        width: getScreenWidth(context) - 170,
                        height: 230,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Text(
                              "$completed/${GetIt.I.get<AppModel>().queue.length}"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getScreenWidth(context),
                      height: getScreenHeight(context) * 0.55,
                      child: ListView.builder(
                          itemCount: GetIt.I.get<AppModel>().queue.length,
                          itemBuilder: (context, index) {
                            double sizeInMb =
                                int.parse(queue[index]!.size) / (1024 * 1024);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                    GetIt.I.get<AppModel>().queue[index]!.name),
                                trailing: queue[index]!.progress =="Exist already"?Text("Exist Already"):Text(queue[index]!.progress + "%"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(sizeInMb.toStringAsFixed(3) + " MB "),
                                    Text(DateTime.parse(queue[index]!.date)
                                        .toddMMMMyyyy()),
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
