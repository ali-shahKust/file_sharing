

import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:glass_mor/file_manager/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/category_provider.dart';
import 'package:provider/provider.dart';

class FilePicker extends StatelessWidget {
  final String title;

  FilePicker({

    required this.title,
  }) ;

//   final String title;
//
//   FilePicker({
//     Key key,
//     this.title,
//   }) : super(key: key);
//
//   @override
//   _FilePickerState createState() => _FilePickerState();
// }
//
// class _FilePickerState extends State<FilePicker> {
//   @override
//   void initState() {
//     super.initState();
//     // SchedulerBinding.instance.addPostFrameCallback((_) {
//     //       Provider.of<CategoryProvider>(context, listen: false)
//     //           .getAudios();
//     // });
//   }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget? child) {
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${provider.filesList.length}  $title ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
// @override
// State<StatefulWidget> createState() {
//   // TODO: implement createState
//   throw UnimplementedError();
// }

//
//
// import 'dart:io';
//
// import 'package:file_sharing_app/provider/file_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class FilePicker extends StatefulWidget {
//   const FilePicker({Key? key}) : super(key: key);
//
//   @override
//   _FilePickerState createState() => _FilePickerState();
// }
//
// class _FilePickerState extends State<FilePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
//
// class FilePicker extends StatelessWidget {
//   const FilePicker({Key key}) : super(key: key);
//
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   final fileProvider = Provider.of<FileProvider>(context, listen: false);
//   //   // fileProvider.getlist(w);
//   //
//   //   return fileProvider.filesListData == null
//   //       ? CircularProgressIndicator(
//   //     color: Colors.green,
//   //   )
//   //       : ListView.builder(
//   //     //if file/folder list is grabbed, then show here
//   //     itemCount: fileProvider.filesListData.length ?? 0,
//   //     itemBuilder: (context, index) {
//   //       // File file = File(fileProvider.filesListData[index].path);
//   //       // String path = (file.path.toString());
//   //       // if (widget.isVideo) {
//   //       //   print('type of the screen is ${widget.isVideo}');
//   //       //
//   //       //   getThumbNail(path);
//   //       //   print('thumbnail of the video is $videoThumbNail');
//   //       // }
//   //       return Card(
//   //           child: ListTile(
//   //             title: Text(fileProvider.filesListData[index].name ?? ''),
//   //             leading:
//   //             Padding(
//   //               padding: const EdgeInsets.symmetric(vertical: 5.0),
//   //               child: Image.file(
//   //                 File(fileProvider.filesListData[index].path),
//   //                 fit: BoxFit.fitWidth,
//   //                 width: 70,
//   //                 height: 70,
//   //               ),
//   //             ),
//   //             // Icon(Icons.picture_as_pdf),
//   //             trailing: fileProvider.filesListData[index].isSelected?Container(
//   //                 height: 30,
//   //                 width: 30,
//   //                 decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//   //                 child: Padding(
//   //                     padding: const EdgeInsets.all(5.0),
//   //                     child: Icon(
//   //                       Icons.check,
//   //                       size: 20.0,
//   //                       color: Colors.white,
//   //                     ))):SizedBox(height: 2.0,),
//   //             // IconButton(
//   //             //   icon:Icon(Icons.arrow_forward),
//   //             //   color: Colors.redAccent,
//   //             //   onPressed: (){
//   //             //   List<File> list =   fileProvider.getSelectedList();
//   //             //   for(int i =0 ;i<list.length;i++){
//   //             //     print('selected list values are...${list[i].path}');
//   //             //   }
//   //             //   },
//   //             // ),
//   //             onLongPress: () {
//   //               print(
//   //                   'path of the file selected is ....${fileProvider.filesListData[index].path}');
//   //               fileProvider.enableSelectMode = true;
//   //               // fileProvider.filesListData[index].isSelected = true;
//   //               print('select mode value is ${fileProvider.selectModeValue}');
//   //               // setState(() {
//   //               //   isSelect = true;
//   //               //   // filePathToShare = path;
//   //               // });
//   //               // print('path of the file to share  is ....$path');
//   //               // print('path of the file name  to share  is ....$file');
//   //               // uploadFile(context)
//   //               // uploadFile(context, currentContext: globals.globalContext, path: path, file1: file, sizeDem: 0);
//   //             },
//   //             onTap: () {
//   //               if(fileProvider.selectModeValue){
//   //                 fileProvider.changeIsSelected(true, index);
//   //                 // setState(() {
//   //                 //
//   //                 // });
//   //                 print('list is Selected varibale value is ${fileProvider.filesListData[index].isSelected}');
//   //                 print('list is name varibale value is ${fileProvider.filesListData[index].name}');
//   //
//   //                 fileProvider.addToSelectedList(fileProvider.filesListData[index].path);
//   //               }
//   //               else{
//   //               }
//   //
//   //
//   //               // setState(() {
//   //               //   isSelect = !isSelect;
//   //               // });
//   //               // for(int i =0;i<files.length();i++){
//   //               //   print('item in the list are ...${files[i]}');
//   //               // }
//   //               // OpenFile.open(path);
//   //               // Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //               //   return ViewPDF(pathPDF: files[index].path.toString());
//   //               //open viewPDF page on click
//   //             },
//   //           )
//   //       );
//   //     },
//   //   );
//   // }
// }
