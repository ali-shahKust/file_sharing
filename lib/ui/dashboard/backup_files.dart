import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/data/extension.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
import 'package:provider/provider.dart';

import '../../data/app_model.dart';
import '../../utills/i_utills.dart';

class BackupFilesScreen extends StatefulWidget {
  static const routeName = 'backup_screen';

  @override
  State<BackupFilesScreen> createState() => _BackupFilesScreenState();
}

class _BackupFilesScreenState extends State<BackupFilesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<DashBoardVm>(context, listen: false).getBackUpFiles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardVm>(builder: (context, vm, _) {
      return Scaffold(
        appBar: AppBar(),
          body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: getScreenWidth(context),
              height: getScreenHeight(context) ,
              child: ListView.builder(
                  itemCount: vm.backupFiles.length,
                  itemBuilder: (context, index) {
                    double sizeInMb =
                        int.parse(vm.backupFiles[index]!.size) / (1024 * 1024);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          if(vm.backFileSelected){
                            if (vm.backupFiles[index]!.isSelected == "1") {
                              vm.unSelectItem(index);
                            } else {
                              vm.selectItem(index);
                            }
                          }
                        },
                        onLongPress: () {
                          vm.backFileSelected = true;
                          if (vm.backupFiles[index]!.isSelected == "1") {
                            vm.unSelectItem(index);
                          } else {
                            vm.selectItem(index);
                          }
                        },
                        selected: vm.backupFiles[index]!.isSelected == "1"
                            ? true
                            : false,
                        minLeadingWidth: 80,
                        trailing: Checkbox(value:vm.backupFiles[index]!.isSelected == "1"
                            ? true
                            : false, onChanged: (bool? value) {
                          if (vm.backupFiles[index]!.isSelected == "1") {
                            vm.unSelectItem(index);
                          } else {
                            vm.selectItem(index);
                          }
                        },),
                        leading: vm.backupFiles[index]!.name.contains(".jpg")
                            ? Image.file(
                                File(vm.backupFiles[index]!.path!),
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.file_present,
                                color: Colors.grey,
                              ),
                        title: Text(vm.backupFiles[index]!.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sizeInMb.toStringAsFixed(3) + " MB "),
                            Text(DateTime.parse(vm.backupFiles[index]!.date)
                                .toddMMMMyyyy()),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ));
    });
  }
}
