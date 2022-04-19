import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/data/extension.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';

class CloudImages extends StatefulWidget {
  static const routeName = 'cloud_backup_screen';

  @override
  State<CloudImages> createState() => _CloudImagesState();
}

class _CloudImagesState extends State<CloudImages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnlineBackUpVm>(builder: (context, vm, _) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(64, 75, 96, .9),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight! ,
                  child: ListView.builder(
                      itemCount: vm.images.length,
                      itemBuilder: (context, index) {
                        double sizeInMb =
                            int.parse(vm.images[index]!['size'].toString()) / (1024 * 1024);
                        double sizeInKb =
                            int.parse(vm.images[index]!['size'].toString()) / (1024);
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                                child: ListTile(
                                  // onTap: () {
                                  //   if(vm.backFileSelected){
                                  //     if (vm.backupFiles[index]!.isSelected == "1") {
                                  //       vm.unSelectItem(index);
                                  //     } else {
                                  //       vm.selectItem(index);
                                  //     }
                                  //   }
                                  // },
                                  // onLongPress: () {
                                  //   vm.backFileSelected = true;
                                  //   if (vm.backupFiles[index]!.isSelected == "1") {
                                  //     vm.unSelectItem(index);
                                  //   } else {
                                  //     vm.selectItem(index);
                                  //   }
                                  // },
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    leading: SvgPicture.asset(AppConstants.images_icon),
                                    title: Text(
                                      vm.images[index]!['key'].split("/").last,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: <Widget>[

                                            Icon(Icons.adjust, color: Colors.yellowAccent),
                                            Text(sizeInMb<1?sizeInKb.toStringAsFixed(2)+ " KB ":sizeInMb.toStringAsFixed(2) + " MB ", style: TextStyle(color: Colors.white))
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[

                                            Icon(Icons.date_range, color: Colors.yellowAccent),
                                            Text(DateTime.parse(vm.images[index]!['date'].toString())
                                                .toddMMMMyyyy(), style: TextStyle(color: Colors.white))
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing:
                                    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
                              ),
                            )

                        );
                      }),
                )
              ],
            ),
          ));
    });
  }
}
