
import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';

class FileViews extends StatefulWidget {
  static const routeName = 'files';



  @override
  State<FileViews> createState() => _FileViewsState();
}

class _FileViewsState extends State<FileViews> {
  // void initState() {
  //   SchedulerBinding.instance!.addPostFrameCallback((_) {
  //     // Provider.of<CoreProvider>(context, listen: false).checkSpace();
  //     Provider.of<CategoryVm>(context, listen: false).getTextFile();
  //     // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //
  //
  //   });
  //   super.initState();
  // }
//   final String title;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryVm provider, Widget? child) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        if (provider.loading) {
          return Scaffold(
            body: Center(
              child: Container(

                child: Image.asset("assets/gifs/loader.gif",
                    height: MediaQuery.of(context).size.height * 0.4, width: MediaQuery.of(context).size.width * 0.4),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
            child: Stack(
              //
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     '${provider.filesList.length}  ${widget.title} ',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Visibility(
                      visible: provider.filesList.isNotEmpty,
                      replacement: Center(child: Text('No Files Found')),
                      child: Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 10),
                          itemCount: provider.filesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Icon(
                                Feather.file,
                                color: Colors.orangeAccent,
                              ),
                              title: Text('${provider.filesList[index].file.path.split('/').last}'),
                              trailing: provider.filesList[index].isSelected
                                  ? Container(
                                      height: screenHeight * 0.1,
                                      width: screenWidth * 0.07,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                                      child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.check,
                                            size: screenHeight * 0.02,
                                            color: Colors.white,
                                          )),
                                    )
                                  : SizedBox(
                                      height: 2.0,
                                    ),
                              onTap: () {
                                provider.changeIsSelected(index, provider.filesList);
                                if (provider.filesList[index].isSelected) {
                                  provider.addToSelectedList = provider.filesList[index].file;
                                } else {
                                  provider.removeFromSelectedList = provider.filesList[index].file;
                                }
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return CustomDivider();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

