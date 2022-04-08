import 'package:flutter/material.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
import 'package:glass_mor/ui/dashboard/queues_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PicturesScreen extends StatefulWidget {
  static const routeName = 'pics';

  @override
  State<PicturesScreen> createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<PicturesScreen> {
  @override
  void initState() {
    getPics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardVm>(builder: (context, vm, _) {
      vm.getBackUpFiles();

      return  Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: () async{
              bool granted = await Permission.manageExternalStorage.isGranted;
              if(granted){
                vm.downloadFile(vm.pics);

                  Navigator.pushNamed(context, QuesScreen.routeName);
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
  
  getPics()async {
    await Future.delayed(Duration(seconds: 1));
   Provider.of<DashBoardVm>(context,listen: false).listItems();
  }
}
