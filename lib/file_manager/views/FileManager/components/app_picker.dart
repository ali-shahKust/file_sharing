// //
// //
// import 'dart:io';
//
// import 'package:device_apps/device_apps.dart';
// import 'package:file_sharing_app/Constants/constants.dart';
// import 'package:file_sharing_app/Service/file_extention_type_service.dart';
// import 'package:file_sharing_app/provider/FileManagerProvider/category_provider.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/custom_divider.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/custom_loader.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:provider/provider.dart';
//
// class AppPicker extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Consumer(
//       builder: (BuildContext context, CategoryProvider provider, Widget child) {
//         if (provider.loading) {
//           return Scaffold(
//             body: Center(
//               child: Container(
//                 // width: MediaQuery.of(context).size.width /2 ,
//                 // height: MediaQuery.of(context).size.height / 2,
//                 child: Image.asset("assets/gifs/loader.gif",
//                     height:screenHeight * 0.4,
//                     width: screenWidth * 0.4),
//               ),
//             ),
//           );
//         }
//         return Scaffold(
//           backgroundColor: Colors.white,
//           // appBar: AppBar(
//           //   elevation: 0.0,
//           //   iconTheme: IconThemeData(
//           //     color: Colors.black, //change your color here
//           //   ),
//           //   title: Text(
//           //     'Send Files',
//           //     style: TextStyle(
//           //       color: Colors.black,
//           //       fontSize: 20,
//           //       fontWeight: FontWeight.w700,
//           //     ),
//           //   ),
//           //   actions: [
//           //     Padding(
//           //       padding: const EdgeInsets.only(right: 5.0),
//           //       child: IconButton(
//           //         onPressed: () {},
//           //         icon: Icon(
//           //           Icons.search,
//           //           size: 30,
//           //         ),
//           //       ),
//           //     )
//           //   ],
//           //   backgroundColor: Colors.white,
//           // ),
//           body: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
//             child: Stack(
//               //
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         '${provider.appList.length} Apps',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     Visibility(
//                       visible: provider.appList.isNotEmpty,
//                       replacement: Center(child: Text('No Files Found')),
//                       child: Expanded(
//                         child: ListView.separated(
//                           padding: EdgeInsets.only(left: 10),
//                           itemCount: provider.appList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             // provider.appList[index].apps..sort((app1, app2)=>app1.appName.toLowerCase()
//                             //         .compareTo(app2.appName.toLowerCase()));
//                             Application app = provider.appList[index].apps;
//                             //
//
//                             return ListTile(
//                               leading: app is ApplicationWithIcon
//                                   ? Image.memory(app.icon,
//                                       height: screenHeight*0.1, width: screenWidth*0.1)
//                                   : null,
//                               title: Text(app.appName),
//                               subtitle: Text('${app.packageName}'),
//                               trailing: provider.appList[index].isSelected
//                                   ? Container(
//                                       height: screenHeight*0.1,
//                                       width: screenWidth*0.07,
//                                       decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: kSelectedIconColor),
//                                       child: Padding(
//                                           padding: const EdgeInsets.all(5.0),
//                                           child: Icon(
//                                             Icons.check,
//                                             size: screenHeight * 0.02,
//                                             color: Colors.white,
//                                           )),
//                                     )
//                                   : SizedBox(
//                                       height: 2.0,
//                                     ),
//                               // Container(
//                               //   height: 30,
//                               //   width: 30,
//                               //   decoration: BoxDecoration(
//                               //       shape: BoxShape.circle,
//                               //       color: provider.appList[index].isSelected
//                               //           ? Colors.blue
//                               //           : Colors.black38),
//                               //   child: Padding(
//                               //     padding: const EdgeInsets.all(5.0),
//                               //     child: provider.appList[index].isSelected
//                               //         ? Icon(
//                               //       Icons.check,
//                               //       size: 20.0,
//                               //       color: Colors.white,
//                               //     )
//                               //         : Icon(
//                               //       Icons.check_box_outline_blank,
//                               //       size: 20.0,
//                               //       color: Colors.white,
//                               //     ),
//                               //   ),
//                               // ):SizedBox(height: 2.0,),
//                               // subtitle: Text('${app.packageName}'),
//                               onTap: () {
//                                 provider.changeIsSelectedApp(
//                                     index, provider.appList);
//                                 // File apkFile= File(
//                                 //     provider.appList[index].apps.apkFilePath);
//                                 if (provider.appList[index].isSelected) {
//                                   // provider.selectedFiles.add(File(provider.appList[index].apps.apkFilePath));
//                                     provider.addToSelectedList = File(provider.appList[index].apps.apkFilePath);
//                                     FileExtentionType.getFileName(provider.appList[index].apps.apkFilePath);
//                                   print('length of the list when added  is${provider.selectedFiles.length}');
//                                 }
//                                 else{
//                                   provider.removeFromSelectedList= File(provider.appList[index].apps.apkFilePath);
//                                   print('length of the list when removed  is${provider.selectedFiles.length}');
//                                 }
//
//                             // for(int i=0;i<provider.selectedFilesPathList.length;i++){
//                             //         print('data in the selected list file when added  is${provider.selectedFilesPathList[i]}');}
//                             //       // print('apk path of the app is....${apkFile.path}');
//                             //       // print('apk file of the app is...$apkFile');
//                             //     } else {
//                             //       // print('apk path of the app is....${apkFile.path}');
//                             //       // print('apk file of the app is...$apkFile');
//                             //       // provider.removeFromSelectedPathList = provider.appList[index].apps.apkFilePath;
//                             //       print('length of the list when added  is${provider.selectedFilesPathList.length}');
//                             //
//                             //
//                             //       for(int i=0;i<provider.selectedFilesPathList.length;i++){
//                             //         print('data in the selected list file when added  is${provider.selectedFilesPathList[i]}');}
//                             //     }
//
//                                 // provider.changeIsSelected(index, provider.imageList);
//                                 // if (provider.imageList[index].isSelected) {
//                                 //   provider.addToSelectedList = provider.imageList[index].file;
//                                 // } else {
//                                 //   provider.removeFromSelectedList = provider.imageList[index].file;
//                                 // }
//
//                                 // provider.changeIsSelected(index,provider.audiosList);
//                                 // if (provider.audiosList[index].isSelected) {
//                                 //   provider.addToSelectedList = provider.audiosList[index].file;
//                                 // } else {
//                                 //   provider.removeFromSelectedList = provider.audiosList[index].file;
//                                 // }
//                               },
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) {
//                             return CustomDivider();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Positioned(
//                 //   bottom: 5,
//                 //   left: 50,
//                 //   right: 50,
//                 //   child: RaisedButton(
//                 //     color: Colors.blue,
//                 //     child: Text(
//                 //       "Selected Files ${provider.selectedFiles.length}",
//                 //       style: TextStyle(color: Colors.white, fontSize: 18),
//                 //     ),
//                 //     onPressed: () {
//                 //       for(int i=0;i<provider.selectedFiles.length;i++){
//                 //         print('data in the list is ...${provider.selectedFiles[i]}');
//                 //       }
//                 //     },
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//
//     //   Scaffold(
//     //   backgroundColor: Colors.white,
//     //   appBar: AppBar(
//     //     elevation: 0.0,
//     //     backgroundColor: Colors.white,
//     //     iconTheme: IconThemeData(
//     //       color: Colors.black, //change your color here
//     //     ),
//     //     title: Text('Send Files',style: TextStyle(color: Colors.black),),
//     //   ),
//     //   body: FutureBuilder<List<Application>>(
//     //     future: getAllApps(),
//     //     builder: (context, snapshot) {
//     //       if (snapshot.hasData) {
//     //         List<Application> data = snapshot.data;
//     //         File file = File(data.first.apkFilePath);
//     //         // Sort the App List on Alphabetical Order
//     //         data..sort((app1, app2)=>app1.appName.toLowerCase()
//     //             .compareTo(app2.appName.toLowerCase()));
//     //         return ListView.separated(
//     //           padding: EdgeInsets.only(left: 10),
//     //           itemCount: data.length,
//     //           itemBuilder: (BuildContext context, int index) {
//     //             Application app = data[index];
//     //             return ListTile(
//     //               leading: app is ApplicationWithIcon
//     //                   ? Image.memory(app.icon, height: 40, width: 40)
//     //                   : null,
//     //               title: Text(app.appName),
//     //               subtitle: Text('${app.packageName}'),
//     //               onTap: () => DeviceApps.openApp(app.packageName),
//     //             );
//     //           },
//     //           separatorBuilder: (BuildContext context, int index) {
//     //             return CustomDivider();
//     //           },
//     //         );
//     //       }
//     //       return CustomLoader();
//     //     },
//     //   ),
//     // );
//   }
// }
//
// // import 'dart:io';
// //
// // import 'package:file_sharing_app/Constants/constants.dart';
// // import 'package:file_sharing_app/provider/file_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_file_manager/flutter_file_manager.dart';
// // import 'package:path_provider_ex/path_provider_ex.dart';
// // import 'package:provider/provider.dart';
// // import 'package:video_thumbnail/video_thumbnail.dart';
// //
// // class AppPicker extends StatefulWidget {
// //   // final extention;
// //   // const AppPicker({this.extention});
// //
// //   @override
// //   State<AppPicker> createState() => _AppPickerState();
// // }
// //
// // class _AppPickerState extends State<AppPicker> {
// //   // List files = [];
// //   // bool isSelect = false;
// //   // var videoThumbNail;
// //   // String filePathToShare = '';
// //
// //   // void getFiles() async {
// //   //   //asyn function to get list of files
// //   //   final fileProvider = Provider.of<FileProvider>(context, listen: false);
// //   //   List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
// //   //   var root = storageInfo[0]
// //   //       .rootDir; //storageInfo[1] for SD card, geting the root directory
// //   //   var fm = FileManager(root: Directory(root)); //
// //   //   files = await fm.filesTree(
// //   //       excludedPaths: ["/storage/emulated/0/Android"],
// //   //       sortedBy: FileManagerSorting.Date,
// //   //       extensions:
// //   //       widget.extention //optional, to filter files, list only pdf files
// //   //   );
// //   //   for (int i = 0; i < files.length; i++) {
// //   //     File file = File(files[i].path);
// //   //     String path = (file.path.toString());
// //   //     fileProvider.addtolist(
// //   //         files[i].path.split('/').last, path, categories[0], false);
// //   //     print('files data in the list is  ${files[i]}');
// //   //   }
// //   //   setState(() {}); //update the UI
// //   // }
// //   //
// //   // void getThumbNail(final filepath) async {
// //   //   final thumbnail = await VideoThumbnail.thumbnailData(
// //   //     video: filepath,
// //   //     imageFormat: ImageFormat.PNG,
// //   //     maxWidth: 100,
// //   //     // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
// //   //     quality: 25,
// //   //   ).then((value) => {
// //   //     debugPrint('thumnail from function is $value'),
// //   //   });
// //   //
// //   //   setState(() {
// //   //     videoThumbNail = thumbnail;
// //   //   });
// //   // }
// //   //
// //   // @override
// //   // void initState() {
// //   //   // TODO: implement initState
// //   //   getFiles();
// //   //   super.initState();
// //   // }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final fileProvider = Provider.of<FileProvider>(context, listen: false);
// //     // fileProvider.getlist(w);
// //
// //     return fileProvider.appListData == null
// //         ? CircularProgressIndicator(
// //       color: Colors.green,
// //     )
// //         : ListView.builder(
// //       //if file/folder list is grabbed, then show here
// //       itemCount: fileProvider.appListData.length ?? 0,
// //       itemBuilder: (context, index) {
// //         // File file = File(fileProvider.appListData[index].path);
// //         // String path = (file.path.toString());
// //         // if (widget.isVideo) {
// //         //   print('type of the screen is ${widget.isVideo}');
// //         //
// //         //   getThumbNail(path);
// //         //   print('thumbnail of the video is $videoThumbNail');
// //         // }
// //         return Card(
// //             child: ListTile(
// //               title: Text(fileProvider.appListData[index].name ?? ''),
// //               // leading:
// //               // Padding(
// //               //   padding: const EdgeInsets.symmetric(vertical: 5.0),
// //               //   child: Image.file(
// //               //     File(fileProvider.appListData[index].path),
// //               //     fit: BoxFit.fitWidth,
// //               //     width: 70,
// //               //     height: 70,
// //               //   ),
// //               // ),
// //               // Icon(Icons.picture_as_pdf),
// //               trailing: fileProvider.appListData[index].isSelected?Container(
// //                   height: 30,
// //                   width: 30,
// //                   decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
// //                   child: Padding(
// //                       padding: const EdgeInsets.all(5.0),
// //                       child: Icon(
// //                         Icons.check,
// //                         size: 20.0,
// //                         color: Colors.white,
// //                       ))):SizedBox(height: 2.0,),
// //               // IconButton(
// //               //   icon:Icon(Icons.arrow_forward),
// //               //   color: Colors.redAccent,
// //               //   onPressed: (){
// //               //   List<File> list =   fileProvider.getSelectedList();
// //               //   for(int i =0 ;i<list.length;i++){
// //               //     print('selected list values are...${list[i].path}');
// //               //   }
// //               //   },
// //               // ),
// //               onLongPress: () {
// //                 print(
// //                     'path of the file selected is ....${fileProvider.appListData[index].path}');
// //                 fileProvider.enableSelectMode = true;
// //                 // fileProvider.appListData[index].isSelected = true;
// //                 print('select mode value is ${fileProvider.selectModeValue}');
// //                 // setState(() {
// //                 //   isSelect = true;
// //                 //   // filePathToShare = path;
// //                 // });
// //                 // print('path of the file to share  is ....$path');
// //                 // print('path of the file name  to share  is ....$file');
// //                 // uploadFile(context)
// //                 // uploadFile(context, currentContext: globals.globalContext, path: path, file1: file, sizeDem: 0);
// //               },
// //               onTap: () {
// //                 if(fileProvider.selectModeValue){
// //                   fileProvider.changeIsSelected(true, index);
// //                   // setState(() {
// //                   //
// //                   // });
// //                   print('list is Selected varibale value is ${fileProvider.appListData[index].isSelected}');
// //                   print('list is name varibale value is ${fileProvider.appListData[index].name}');
// //
// //                   fileProvider.addToSelectedList(fileProvider.appListData[index].path);
// //                 }
// //                 else{
// //                 }
// //
// //
// //                 // setState(() {
// //                 //   isSelect = !isSelect;
// //                 // });
// //                 // for(int i =0;i<files.length();i++){
// //                 //   print('item in the list are ...${files[i]}');
// //                 // }
// //                 // OpenFile.open(path);
// //                 // Navigator.push(context, MaterialPageRoute(builder: (context) {
// //                 //   return ViewPDF(pathPDF: files[index].path.toString());
// //                 //open viewPDF page on click
// //               },
// //             )
// //         );
// //       },
// //     );
// //   }
// // }
