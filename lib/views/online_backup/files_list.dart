import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';

class PicturesScreen extends StatefulWidget {
  static const routeName = 'pics';

  @override
  State<PicturesScreen> createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<PicturesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<OnlineBackUpVm>(context, listen: false).listItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnlineBackUpVm>(builder: (context, vm, _) {
      return  Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: () async{
              bool granted = await Permission.manageExternalStorage.isGranted;
              if(granted){
                print("Files ${vm.pics.length}");
                  await Navigator.pushNamed(context, DownloadScreen.routeName,arguments: vm.pics );
              }
              else {
                await Permission.manageExternalStorage.request();
              }
            },
            child:const Text("Restore all"),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for(int i=0; i<vm.pics.length;i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 250,
                    height: 250,
                    child: InkWell(
                        onTap: (){
                          // vm.downloadFile(vm.pics);
                        },
                        child: Image.network(vm.pics[i]['url'],fit: BoxFit.cover,)),
                  ),
                )
            ],
          ),
        ),
      );
    });
  }

}
