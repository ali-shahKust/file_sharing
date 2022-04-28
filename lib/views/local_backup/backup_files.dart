// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:quick_backup/data/extension.dart';
// import 'package:provider/provider.dart';
//
// import '../../utilities/i_utills.dart';
// import 'backup_vm.dart';
//
// class BackupFilesScreen extends StatefulWidget {
//   static const routeName = 'backup_screen';
//
//   @override
//   State<BackupFilesScreen> createState() => _BackupFilesScreenState();
// }
//
// class _BackupFilesScreenState extends State<BackupFilesScreen> {
//   @override
//   void initState() {
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       Provider.of<BackUpVm>(context, listen: false).getBackUpFiles();
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BackUpVm>(builder: (context, vm, _) {
//       vm.getBackUpFiles();
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromRGBO(64, 75, 96, .9),
//         ),
//           body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               width: getScreenWidth(context),
//               height: getScreenHeight(context) ,
//               child: ListView.builder(
//                   itemCount: vm.backupFiles.length,
//                   itemBuilder: (context, index) {
//                     double sizeInMb =
//                         int.parse(vm.backupFiles[index]!.size) / (1024 * 1024);
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         elevation: 8.0,
//                         margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//                         child: Container(
//                           decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
//                           child: ListTile(
//                               // onTap: () {
//                               //   if(vm.backFileSelected){
//                               //     if (vm.backupFiles[index]!.isSelected == "1") {
//                               //       vm.unSelectItem(index);
//                               //     } else {
//                               //       vm.selectItem(index);
//                               //     }
//                               //   }
//                               // },
//                               // onLongPress: () {
//                               //   vm.backFileSelected = true;
//                               //   if (vm.backupFiles[index]!.isSelected == "1") {
//                               //     vm.unSelectItem(index);
//                               //   } else {
//                               //     vm.selectItem(index);
//                               //   }
//                               // },
//                               contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                               leading: Container(
//                                 padding: EdgeInsets.only(right: 12.0),
//                                 decoration: new BoxDecoration(
//                                     border: new Border(
//                                         right: new BorderSide(width: 1.0, color: Colors.white24))),
//                                 child: vm.backupFiles[index]!.name.contains(".jpg")
//                                     ? Image.file(
//                                   File(vm.backupFiles[index]!.path!),
//                                   fit: BoxFit.cover,
//                                 )
//                                     : const Icon(
//                                   Icons.file_present,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               selected: vm.backupFiles[index]!.isSelected == "1"
//                                   ? true
//                                   : false,
//                               title: Text(
//                                 vm.backupFiles[index]!.name,
//                                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                               ),
//                               // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
//
//                               subtitle: Column(
//                                 children: [
//                                   Row(
//                                     children: <Widget>[
//
//                                       Icon(Icons.adjust, color: Colors.yellowAccent),
//                                       Text(sizeInMb.toStringAsFixed(3) + " MB ", style: TextStyle(color: Colors.white))
//                                     ],
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//
//                                       Icon(Icons.date_range, color: Colors.yellowAccent),
//                                       Text(DateTime.parse(vm.backupFiles[index]!.date)
//                                           .toddMMMMyyyy(), style: TextStyle(color: Colors.white))
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               trailing:
//                               Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
//                         ),
//                       )
//
//                     );
//                   }),
//             )
//           ],
//         ),
//       ));
//     });
//   }
// }
