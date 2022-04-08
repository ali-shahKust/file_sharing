import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
import 'package:provider/provider.dart';

class BackupFilesScreen extends StatefulWidget {
  static const routeName = 'backup_screen';

  @override
  State<BackupFilesScreen> createState() => _BackupFilesScreenState();
}

class _BackupFilesScreenState extends State<BackupFilesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<DashBoardVm>(context,listen: false).getBackUpFiles();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardVm>(builder: (context, vm, _) {
      return  Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              for(int i = 0; i<vm.backupFiles.length; i ++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    height: 250,
                    child: InkWell(
                        onTap: (){
                          // vm.downloadFile(vm.pics);
                        },
                        child: Image.file(File(vm.backupFiles[i]!.path!),fit: BoxFit.cover,)),
                  ),
                )
            ],
          ),
        )
      );
    });
  }
}
