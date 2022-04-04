import 'package:flutter/material.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
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
  
      return  Scaffold(
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
                          vm.downloadFile(vm.pics[i]['key']);
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
