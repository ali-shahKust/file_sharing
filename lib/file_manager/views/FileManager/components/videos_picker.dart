// import 'dart:io';
// import 'dart:typed_data';
// import 'package:file_sharing_app/Constants/constants.dart';
// import 'package:file_sharing_app/Utits/FileMangerUtils/consts.dart';
// import 'package:file_sharing_app/Utits/FileMangerUtils/file_utils.dart';
// import 'package:file_sharing_app/models/file_model.dart';
// import 'package:file_sharing_app/provider/FileManagerProvider/category_provider.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/custom_loader.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/file_icon.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/video_thumbnail.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:mime_type/mime_type.dart';
// import 'package:open_file/open_file.dart';
// import 'package:provider/provider.dart';
// import 'package:transparent_image/transparent_image.dart';
// // import 'package:video_thumbnail/video_thumbnail.dart';
//
// class VideosPicker extends StatelessWidget {
//   final String title;
//
//   VideosPicker({
//     Key key,
//     this.title,
//   }) : super(key: key);
//
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Consumer(
//       builder: (BuildContext context, CategoryProvider provider, Widget child) {
//         if (provider.loading) {
//           return Scaffold(
//             body: Center(
//               child: Container(
//                 child: Image.asset("assets/gifs/loader.gif",
//                     height: MediaQuery.of(context).size.height * 0.4, width: MediaQuery.of(context).size.width * 0.4),
//               ),
//             ),
//           );
//         }
//         return Scaffold(
//           backgroundColor: Colors.white,
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
//                         '${provider.videosList.length}  $title ',
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
//                       visible: provider.videosList.isNotEmpty,
//                       replacement: Center(child: Text('No Files Found')),
//                       child: Expanded(
//                         child: GridView.builder(
//                             reverse: false,
//                             cacheExtent: 15,
//                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 4,
//                               mainAxisSpacing: 2.0,
//                               crossAxisSpacing: 2.0,
//                             ),
//                             itemCount: provider.videosList.length ?? 0,
//                             itemBuilder: (BuildContext context, int index) {
//                               // File file = File(provider.videosList[index].file.path);
//                               // String path = file.path;
//
//                               FileMangerModel fmm = provider.videosList[index];
//                               return _MediaTile(
//                                 imgmodel: fmm,
//                                 provider: provider,
//                                 index: index,
//                                 screenHeight: screenHeight,
//                                 screenWidth: screenWidth,
//                               );
//                             }
//                             //   GridView.count(
//                             // crossAxisSpacing: 3.0,
//                             // mainAxisSpacing: 3.0,
//                             // crossAxisCount: 3,
//                             //
//                             // children: Constants.map(
//                             //   provider.videosList,
//                             //   (index, item) {
//                             //     File file = File(item[index].fileList[index].path);
//                             //     print('file in the view from model is ....$file');
//                             //     String path = file.path;
//                             //     String mimeType = mime(path) ?? '';
//                             //     return _MediaTile(file: file, mimeType: mimeType);
//                             //   },
//                             // ),
//                             // ),
//                             //   ),
//                             // ],
//                             ),
//
//                         // GridView.builder(
//                         //   reverse: false,
//                         //   cacheExtent: 15,
//                         //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         //     crossAxisCount: 3,
//                         //     mainAxisSpacing: 7.0,
//                         //     crossAxisSpacing: 7.0,
//                         //   ),
//                         //   itemCount:  provider.currentFiles.length ?? 0,
//                         //   itemBuilder: (BuildContext context, int index) {
//                         //     // ImageModel imageModel = ImageModel.fromJson(list[index]);
//                         //     return Container(
//                         //       child: Stack(
//                         //         alignment: Alignment.bottomCenter,
//                         //         children: <Widget>[
//                         //           FadeInImage(
//                         //             image: FileImage(
//                         //               File(fileProvider.photosListData[index].path),
//                         //             ),
//                         //             placeholder: MemoryImage(kTransparentImage),
//                         //             fit: BoxFit.cover,
//                         //             width: double.infinity,
//                         //             height: double.infinity,
//                         //           ),
//                         //           // Container(
//                         //           //   color: Colors.black.withOpacity(0.7),
//                         //           //   height: 30,
//                         //           //   width: double.infinity,
//                         //           //   child: Center(
//                         //           //     child: Text(
//                         //           //       fileProvider.photosListData[index].name ?? '',
//                         //           //       maxLines: 1,
//                         //           //       overflow: TextOverflow.ellipsis,
//                         //           //       style: TextStyle(
//                         //           //           color: Colors.white,
//                         //           //           fontSize: 16,
//                         //           //           fontFamily: 'Regular'
//                         //           //       ),
//                         //           //     ),
//                         //           //   ),
//                         //           // )
//                         //         ],
//                         //       ),
//                         //     );
//                         //   },
//                         // ),
//
//                         // TabBarView(
//                         //   children: Constants.map<Widget>(
//                         //     provider.imageTabs,
//                         //     (index, label) {
//                         //       List l = provider.currentFiles;
//                         //        print('total images are...${l.length}');
//                         //
//                         //     },
//                         //   ),
//                         // ),
//
//                         //
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 // Positioned(
//                 //   bottom: 5,
//                 //   left:50,
//                 //   right: 50,
//                 //   child: RaisedButton(
//                 //     color: Colors.blue,
//                 //     child: Text(
//                 //       "Selected Files ${provider.selectedFiles.length}",
//                 //       style: TextStyle(color: Colors.white,fontSize: 18),
//                 //     ),
//                 //     onPressed: () {
//                 //       for (int i = 0; i < provider.selectedFiles.length; i++) {
//                 //         print(
//                 //             'files in the selected list are.....${provider.selectedFiles[i]}');
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
//   }
// }
//
// class _MediaTile extends StatelessWidget {
//   final FileMangerModel imgmodel;
//   final CategoryProvider provider;
//   final index;
//   final double screenHeight;
//   final double screenWidth;
//
//   // final String mimeType;
//
//   _MediaTile({this.imgmodel, this.provider, this.index, this.screenHeight, this.screenWidth});
//
//   // getThumb(String videoPath) async{
//   //   Uint8List uint8list = await VideoThumbnail.thumbnailData(
//   //     video:videoPath,
//   //     imageFormat: ImageFormat.JPEG,
//   //     maxWidth: 200, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//   //     quality: 50,
//   //   );
//   //   return uint8list;
//   // }
//   @override
//   Widget build(BuildContext context) {
//     File file = File(imgmodel.file.path);
//     String path = file.path;
//     String mimeType = mime(path) ?? '';
//     // Uint8List  thumb=  getThumb(path);
//     return InkWell(
//       onTap: () {
//         provider.changeIsSelected(index, provider.videosList);
//         if (provider.videosList[index].isSelected) {
//           provider.addToSelectedList = provider.videosList[index].file;
//         } else {
//           provider.removeFromSelectedList = provider.videosList[index].file;
//         }
//         // imgmodel.isSelected = true;
//         // print(
//         //     'is selected of${provider.videosList[index].file.path} value  in the model is ${provider.videosList[index].isSelected}');
//       },
//       child: Stack(
//         children: [
//           Container(
//               height: screenHeight * 0.15,
//               width: screenWidth * 0.47,
//               child: imgmodel.thumbNail == null
//                   ? Image.asset(
//                       'assets/images/video-placeholder.png',
//                       height: screenHeight * 0.04,
//                       width: screenWidth * 0.047,
//                       fit: BoxFit.cover,
//                     )
//                   : Image.memory(
//                       imgmodel.thumbNail,
//                       fit: BoxFit.fill,
//                       scale: 1.0,
//                       width: screenWidth * 0.3,
//                       cacheWidth: 100,
//                       cacheHeight: 110,
//                     )
//               // FileIcon(file: file),
//               // child: FadeInImage(
//               //   placeholder: MemoryImage(kTransparentImage),
//               //   fit: BoxFit.fill,
//               //   width: double.infinity,
//               //   height: double.infinity,
//               //   image: FileImage(File(file.path)),
//               // ),
//               ),
//           Positioned(
//             top: 50,
//             left: 50,
//             bottom: 50,
//             right: 50,
//             child: Icon(
//               Icons.play_circle,
//               size: screenHeight * 0.035,
//               color: Colors.grey[300],
//             ),
//             // child: Image.asset(
//             //   'assets/images/video-placeholder.png',
//             //   height: 100,
//             //   width: 100,
//             //   fit: BoxFit.cover,
//             // ),
//           ),
//           Positioned(
//             top: screenHeight * (-0.032),
//             // left:50,
//             // bottom: 0,
//             right: 0,
//             child: Padding(
//               padding: EdgeInsets.all(5.0),
//               child: provider.videosList[index].isSelected
//                   ? Container(
//                       height: screenHeight * 0.1,
//                       width: screenWidth * 0.07,
//                       decoration: BoxDecoration(shape: BoxShape.circle, color: kSelectedIconColor),
//                       child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Icon(
//                             Icons.check,
//                             size: screenHeight * 0.02,
//                             color: Colors.white,
//                           )),
//                     )
//                   : SizedBox(
//                       height: 2.0,
//                     ),
//             ),
//           ),
//         ],
//       ),
//
//       // GridTile(
//       //   header: Container(
//       //     // height: 30,
//       //     decoration: BoxDecoration(
//       //       gradient: LinearGradient(
//       //         colors: [Colors.black54, Colors.transparent],
//       //         begin: Alignment.topCenter,
//       //         end: Alignment.bottomCenter,
//       //       ),
//       //     ),
//       //     child: Align(
//       //       alignment: Alignment.topRight,
//       //       child: Padding(
//       //         padding: EdgeInsets.all(8.0),
//       //         child: mimeType.split('/')[0] == 'video'
//       //             ? Row(
//       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //           mainAxisSize: MainAxisSize.min,
//       //           children: <Widget>[
//       //             // Text(
//       //             //   '${FileUtils.formatBytes(file.lengthSync(), 1)}',
//       //             //   style: TextStyle(
//       //             //     fontSize: 12,
//       //             //     color: Colors.deepOrange,
//       //             //   ),
//       //             // ),
//       //             Icon(
//       //               Icons.play_circle_filled,
//       //               color: Colors.white,
//       //               size: 16,
//       //             ),
//       //             // SizedBox(
//       //             //   width: 5,
//       //             // ),
//       //             Container(
//       //               height: 30,
//       //               width: 30,
//       //               decoration: BoxDecoration(
//       //                   shape: BoxShape.circle, color: Colors.black38),
//       //               child: Padding(
//       //                 padding: const EdgeInsets.all(5.0),
//       //                 child: provider.videosList[index].isSelected
//       //                     ? Icon(
//       //                   Icons.check,
//       //                   size: 20.0,
//       //                   color: Colors.blue,
//       //                 )
//       //                     : Icon(
//       //                   Icons.check_box_outline_blank,
//       //                   size: 20.0,
//       //                   color: Colors.white,
//       //                 ),
//       //               ),
//       //             ),
//       //
//       //           ],
//       //         )
//       //             : Container(
//       //           height: 30,
//       //           width: 30,
//       //           decoration: BoxDecoration(
//       //               shape: BoxShape.circle, color: Colors.black38),
//       //           child: Padding(
//       //             padding: const EdgeInsets.all(5.0),
//       //             child: provider.videosList[index].isSelected
//       //                 ? Icon(
//       //               Icons.check,
//       //               size: 20.0,
//       //               color: Colors.blue,
//       //             )
//       //                 : Icon(
//       //               Icons.check_box_outline_blank,
//       //               size: 20.0,
//       //               color: Colors.white,
//       //             ),
//       //           ),
//       //         ),
//       //         // Text(
//       //         //         '${FileUtils.formatBytes(file.lengthSync(), 1)}',
//       //         //         style: TextStyle(
//       //         //           fontSize: 12,
//       //         //           color: Colors.deepOrange,
//       //         //         ),
//       //         //       ),
//       //       ),
//       //     ),
//       //   ),
//       //   child: mimeType.split('/')[0] == 'video'
//       //       ? FileIcon(file: file)
//       //       : Image(
//       //     fit: BoxFit.fill,
//       //     errorBuilder: (b, o, c) {
//       //       return Icon(Icons.image);
//       //     },
//       //     image:
//       //     // ResizeImage(
//       //     FileImage(File(file.path)),
//       //     width: 150,
//       //     height: 150,
//       //   ),
//       //   // ),
//       //   // FadeInImage(
//       //   //             image: FileImage(
//       //   //               File(fileProvider.photosListData[index].path),
//       //   //             ),
//       //   //             placeholder: MemoryImage(kTransparentImage),
//       //   //             fit: BoxFit.cover,
//       //   //             width: double.infinity,
//       //   //             height: double.infinity,
//       //   //           ),
//       // ),
//     );
//   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer(
// //       builder: (BuildContext context, CategoryProvider provider, Widget child) {
// //         if (provider.loading) {
// //           return Scaffold(body: CustomLoader());
// //         }
// //         return Scaffold(
// //           backgroundColor: Colors.white,
// //           appBar: AppBar(
// //             elevation: 0.0,
// //             iconTheme: IconThemeData(
// //               color: Colors.black, //change your color here
// //             ),
// //             title: Text(
// //               'Send Files',
// //               style: TextStyle(
// //                 color: Colors.black,
// //               ),
// //             ),
// //             backgroundColor: Colors.white,
// //           ),
// //           //   bottom: TabBar(
// //           //     indicatorColor: Theme.of(context).accentColor,
// //           //     labelColor: Theme.of(context).accentColor,
// //           //     unselectedLabelColor: Theme.of(context).textTheme.caption.color,
// //           //     isScrollable: provider.imageTabs.length < 3 ? false : true,
// //           //     tabs: Constants.map<Widget>(
// //           //       provider.imageTabs,
// //           //       (index, label) {
// //           //         return Tab(text: '$label');
// //           //       },
// //           //     ),
// //           //     onTap: (val) => provider.switchCurrentFiles(
// //           //         provider.images, provider.imageTabs[val]),
// //           //   ),
// //           // ),
// //           body: Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 3.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Text(
// //                     '${provider.videosList.length} ${widget.title} ',
// //                     style: TextStyle(
// //                       color: Colors.black,
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(height: 10.0,),
// //                 Visibility(
// //                   visible: provider.videosList.isNotEmpty,
// //                   replacement: Center(child: Text('No Files Found')),
// //                   child: Expanded(
// //                       child: GridView.count(
// //                         crossAxisSpacing: 3.0,
// //                         mainAxisSpacing: 3.0,
// //                         crossAxisCount: 3,
// //
// //                         children: Constants.map(
// //                           provider.videosList,
// //                               (index, item) {
// //                             File file = File(item.path);
// //                             String path = file.path;
// //                             String mimeType = mime(path) ?? '';
// //                             return _MediaTile(file: file, mimeType: mimeType);
// //                           },
// //                         ),
// //                         // ),
// //                         //   ),
// //                         // ],
// //                       )
// //
// //                     // GridView.builder(
// //                     //   reverse: false,
// //                     //   cacheExtent: 15,
// //                     //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     //     crossAxisCount: 3,
// //                     //     mainAxisSpacing: 7.0,
// //                     //     crossAxisSpacing: 7.0,
// //                     //   ),
// //                     //   itemCount:  provider.currentFiles.length ?? 0,
// //                     //   itemBuilder: (BuildContext context, int index) {
// //                     //     // ImageModel imageModel = ImageModel.fromJson(list[index]);
// //                     //     return Container(
// //                     //       child: Stack(
// //                     //         alignment: Alignment.bottomCenter,
// //                     //         children: <Widget>[
// //                     //           FadeInImage(
// //                     //             image: FileImage(
// //                     //               File(fileProvider.photosListData[index].path),
// //                     //             ),
// //                     //             placeholder: MemoryImage(kTransparentImage),
// //                     //             fit: BoxFit.cover,
// //                     //             width: double.infinity,
// //                     //             height: double.infinity,
// //                     //           ),
// //                     //           // Container(
// //                     //           //   color: Colors.black.withOpacity(0.7),
// //                     //           //   height: 30,
// //                     //           //   width: double.infinity,
// //                     //           //   child: Center(
// //                     //           //     child: Text(
// //                     //           //       fileProvider.photosListData[index].name ?? '',
// //                     //           //       maxLines: 1,
// //                     //           //       overflow: TextOverflow.ellipsis,
// //                     //           //       style: TextStyle(
// //                     //           //           color: Colors.white,
// //                     //           //           fontSize: 16,
// //                     //           //           fontFamily: 'Regular'
// //                     //           //       ),
// //                     //           //     ),
// //                     //           //   ),
// //                     //           // )
// //                     //         ],
// //                     //       ),
// //                     //     );
// //                     //   },
// //                     // ),
// //
// //                     // TabBarView(
// //                     //   children: Constants.map<Widget>(
// //                     //     provider.imageTabs,
// //                     //     (index, label) {
// //                     //       List l = provider.currentFiles;
// //                     //        print('total images are...${l.length}');
// //                     //
// //                     //     },
// //                     //   ),
// //                     // ),
// //
// //                     //
// //
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class _MediaTile extends StatelessWidget {
// //   final File file;
// //   final String mimeType;
// //
// //   _MediaTile({this.file, this.mimeType});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: () => OpenFile.open(file.path),
// //       child: GridTile(
// //         header: Container(
// //           // height: 30,
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [Colors.black54, Colors.transparent],
// //               begin: Alignment.topCenter,
// //               end: Alignment.bottomCenter,
// //             ),
// //           ),
// //           child: Align(
// //             alignment: Alignment.topRight,
// //             child: Padding(
// //               padding: EdgeInsets.all(8.0),
// //               child: mimeType.split('/')[0] == 'video'
// //                   ? Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: <Widget>[
// //                   Text(
// //                     '${FileUtils.formatBytes(file.lengthSync(), 1)}',
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       color: Colors.deepOrange,
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 5,
// //                   ),
// //                   Icon(
// //                     Icons.play_circle_filled,
// //                     color: Colors.white,
// //                     size: 16,
// //                   ),
// //                 ],
// //               )
// //                   : Text(
// //                 '${FileUtils.formatBytes(file.lengthSync(), 1)}',
// //                 style: TextStyle(
// //                   fontSize: 12,
// //                   color: Colors.deepOrange,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //         child: mimeType.split('/')[0] == 'video'
// //             ? FileIcon(file: file)
// //             : Image(
// //           fit: BoxFit.fill,
// //           errorBuilder: (b, o, c) {
// //             return Icon(Icons.image);
// //           },
// //           image:
// //           // ResizeImage(
// //           FileImage(File(file.path)),
// //           width: 150,
// //           height: 150,
// //         ),
// //         // ),
// //         // FadeInImage(
// //         //             image: FileImage(
// //         //               File(fileProvider.photosListData[index].path),
// //         //             ),
// //         //             placeholder: MemoryImage(kTransparentImage),
// //         //             fit: BoxFit.cover,
// //         //             width: double.infinity,
// //         //             height: double.infinity,
// //         //           ),
// //       ),
// //     );
// //   }
// }
//
// //
// //
// // import 'dart:io';
// //
// // import 'package:file_sharing_app/provider/file_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:transparent_image/transparent_image.dart';
// //
// // class PhotosPicker extends StatelessWidget {
// //   const PhotosPicker({Key key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final fileProvider = Provider.of<FileProvider>(context, listen: false);
// //     // fileProvider.getlist(w);
// //
// //     return fileProvider.photosListData == null
// //         ? CircularProgressIndicator(
// //       color: Colors.green,
// //     )
// //       //   : ListView.builder(
// //       // //if file/folder list is grabbed, then show here
// //       // itemCount: fileProvider.photosListData.length ?? 0,
// //       // itemBuilder: (context, index) {
// //         // File file = File(fileProvider.photosListData[index].path);
// //         // String path = (file.path.toString());
// //         // if (widget.isVideo) {
// //         //   print('type of the screen is ${widget.isVideo}');
// //         //
// //         //   getThumbNail(path);
// //         //   print('thumbnail of the video is $videoThumbNail');
// //         // }
// //     :Container(
// //           child: GridView.builder(
// //             reverse: false,
// //             cacheExtent: 15,
// //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 3,
// //               mainAxisSpacing: 7.0,
// //               crossAxisSpacing: 7.0,
// //             ),
// //             itemCount: fileProvider.photosListData.length ?? 0,
// //             itemBuilder: (BuildContext context, int index) {
// //               // ImageModel imageModel = ImageModel.fromJson(list[index]);
// //               return Container(
// //                 child: Stack(
// //                   alignment: Alignment.bottomCenter,
// //                   children: <Widget>[
// //                     FadeInImage(
// //                       image: FileImage(
// //                         File(fileProvider.photosListData[index].path),
// //                       ),
// //                       placeholder: MemoryImage(kTransparentImage),
// //                       fit: BoxFit.cover,
// //                       width: double.infinity,
// //                       height: double.infinity,
// //                     ),
// //                     // Container(
// //                     //   color: Colors.black.withOpacity(0.7),
// //                     //   height: 30,
// //                     //   width: double.infinity,
// //                     //   child: Center(
// //                     //     child: Text(
// //                     //       fileProvider.photosListData[index].name ?? '',
// //                     //       maxLines: 1,
// //                     //       overflow: TextOverflow.ellipsis,
// //                     //       style: TextStyle(
// //                     //           color: Colors.white,
// //                     //           fontSize: 16,
// //                     //           fontFamily: 'Regular'
// //                     //       ),
// //                     //     ),
// //                     //   ),
// //                     // )
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         );
// //         // return Card(
// //         //     child: ListTile(
// //         //       title: Text(fileProvider.photosListData[index].name ?? ''),
// //         //       // leading:
// //         //       // Padding(
// //         //       //   padding: const EdgeInsets.symmetric(vertical: 5.0),
// //         //       //   child: Image.file(
// //         //       //     File(fileProvider.photosListData[index].path),
// //         //       //     fit: BoxFit.fitWidth,
// //         //       //     width: 70,
// //         //       //     height: 70,
// //         //       //   ),
// //         //       // ),
// //         //       // Icon(Icons.picture_as_pdf),
// //         //       trailing: fileProvider.photosListData[index].isSelected?Container(
// //         //           height: 30,
// //         //           width: 30,
// //         //           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
// //         //           child: Padding(
// //         //               padding: const EdgeInsets.all(5.0),
// //         //               child: Icon(
// //         //                 Icons.check,
// //         //                 size: 20.0,
// //         //                 color: Colors.white,
// //         //               ))):SizedBox(height: 2.0,),
// //         //       // IconButton(
// //         //       //   icon:Icon(Icons.arrow_forward),
// //         //       //   color: Colors.redAccent,
// //         //       //   onPressed: (){
// //         //       //   List<File> list =   fileProvider.getSelectedList();
// //         //       //   for(int i =0 ;i<list.length;i++){
// //         //       //     print('selected list values are...${list[i].path}');
// //         //       //   }
// //         //       //   },
// //         //       // ),
// //         //       onLongPress: () {
// //         //         print(
// //         //             'path of the file selected is ....${fileProvider.photosListData[index].path}');
// //         //         fileProvider.enableSelectMode = true;
// //         //         // fileProvider.photosListData[index].isSelected = true;
// //         //         print('select mode value is ${fileProvider.selectModeValue}');
// //         //         // setState(() {
// //         //         //   isSelect = true;
// //         //         //   // filePathToShare = path;
// //         //         // });
// //         //         // print('path of the file to share  is ....$path');
// //         //         // print('path of the file name  to share  is ....$file');
// //         //         // uploadFile(context)
// //         //         // uploadFile(context, currentContext: globals.globalContext, path: path, file1: file, sizeDem: 0);
// //         //       },
// //         //       onTap: () {
// //         //         if(fileProvider.selectModeValue){
// //         //           fileProvider.changeIsSelected(true, index);
// //         //           // setState(() {
// //         //           //
// //         //           // });
// //         //           print('list is Selected varibale value is ${fileProvider.photosListData[index].isSelected}');
// //         //           print('list is name varibale value is ${fileProvider.photosListData[index].name}');
// //         //
// //         //           fileProvider.addToSelectedList(fileProvider.photosListData[index].path);
// //         //         }
// //         //         else{
// //         //         }
// //         //
// //         //
// //         //         // setState(() {
// //         //         //   isSelect = !isSelect;
// //         //         // });
// //         //         // for(int i =0;i<files.length();i++){
// //         //         //   print('item in the list are ...${files[i]}');
// //         //         // }
// //         //         // OpenFile.open(path);
// //         //         // Navigator.push(context, MaterialPageRoute(builder: (context) {
// //         //         //   return ViewPDF(pathPDF: files[index].path.toString());
// //         //         //open viewPDF page on click
// //         //       },
// //         //     )
// //         // );
// //     //   },
// //     // );
// //   }
// // }
//
// //
// //
// // import 'dart:convert';
// // import 'dart:io';
// //
// // import 'package:file_sharing_app/provider/file_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:transparent_image/transparent_image.dart';
// // import 'package:video_thumbnail/video_thumbnail.dart';
// //
// // class VideosPicker extends StatelessWidget {
// //   const VideosPicker({Key key}) : super(key: key);
// //
// //   //   Future<String> getThumbNail(final filepath) async {
// //   //   String thumbnail = await VideoThumbnail.thumbnailData(
// //   //     video: filepath,
// //   //     imageFormat: ImageFormat.PNG,
// //   //     maxWidth: 100,
// //   //     // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
// //   //     quality: 25,
// //   //   ).toString();
// //   //   return thumbnail;
// //   //   // setState(() {
// //   //   //   videoThumbNail = thumbnail;
// //   //   // });
// //   // }
// //   @override
// //   Widget build(BuildContext context) {
// //     final fileProvider = Provider.of<FileProvider>(context, listen: false);
// //     // fileProvider.getlist(w);
// //
// //     return fileProvider.videosListData == null
// //         ? CircularProgressIndicator(
// //       color: Colors.green,
// //     )
// //         :Container(
// //       child: GridView.builder(
// //         reverse: false,
// //         cacheExtent: 15,
// //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 3,
// //           mainAxisSpacing: 7.0,
// //           crossAxisSpacing: 7.0,
// //         ),
// //         itemCount: fileProvider.videosListData.length ?? 0,
// //         itemBuilder: (BuildContext context, int index) {
// //           // ImageModel imageModel = ImageModel.fromJson(list[index]);
// //           return Container(
// //             child: Stack(
// //               alignment: Alignment.bottomCenter,
// //               children: <Widget>[
// //               Padding(
// //                           padding: const EdgeInsets.symmetric(vertical: 5.0),
// //                           child: Container(
// //                               child: Image.memory(
// //                                 fileProvider.videosListData[index].thumbNail,
// //                                 height: 200,
// //                                 width: 200,
// //                                 fit: BoxFit.cover,
// //                               ),
// //                           ),
// //                         ),
// //                 // Container(
// //                 //   color: Colors.black.withOpacity(0.7),
// //                 //   height: 30,
// //                 //   width: double.infinity,
// //                 //   child: Center(
// //                 //     child: Text(
// //                 //       fileProvider.photosListData[index].name ?? '',
// //                 //       maxLines: 1,
// //                 //       overflow: TextOverflow.ellipsis,
// //                 //       style: TextStyle(
// //                 //           color: Colors.white,
// //                 //           fontSize: 16,
// //                 //           fontFamily: 'Regular'
// //                 //       ),
// //                 //     ),
// //                 //   ),
// //                 // )
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //     //     : ListView.builder(
// //     //   //if file/folder list is grabbed, then show here
// //     //   itemCount: fileProvider.videosListData.length ?? 0,
// //     //   itemBuilder: (context, index) {
// //     //     // File file = File(fileProvider.videosListData[index].path);
// //     //     // String path = (file.path.toString());
// //     //     // if (widget.isVideo) {
// //     //     //   print('type of the screen is ${widget.isVideo}');
// //     //     //
// //     //     //   getThumbNail(path);
// //     //     //   print('thumbnail of the video is $videoThumbNail');
// //     //     // }
// //     //
// //     //     // dynamic thumnail =  getThumbNail(fileProvider.videosListData[index].path);
// //     //
// //     //     return Card(
// //     //         child: ListTile(
// //     //           title: Text(fileProvider.videosListData[index].name ?? ''),
// //     //           leading:
// //     //           Padding(
// //     //             padding: const EdgeInsets.symmetric(vertical: 5.0),
// //     //             child: Container(
// //     //                 child: Image.memory(
// //     //                   fileProvider.videosListData[index].thumbNail,
// //     //                   height: 200,
// //     //                   width: 200,
// //     //                   fit: BoxFit.cover,
// //     //                 ),
// //     //             ),
// //     //           ),
// //     //           //   child: Image.file(
// //     //           //     File(fileProvider.videosListData[index].path),
// //     //           //     fit: BoxFit.fitWidth,
// //     //           //     width: 70,
// //     //           //     height: 70,
// //     //           //   ),
// //     //           // ),
// //     //           // Icon(Icons.picture_as_pdf),
// //     //           trailing: fileProvider.videosListData[index].isSelected?Container(
// //     //               height: 30,
// //     //               width: 30,
// //     //               decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
// //     //               child: Padding(
// //     //                   padding: const EdgeInsets.all(5.0),
// //     //                   child: Icon(
// //     //                     Icons.check,
// //     //                     size: 20.0,
// //     //                     color: Colors.white,
// //     //                   ))):SizedBox(height: 2.0,),
// //     //           // IconButton(
// //     //           //   icon:Icon(Icons.arrow_forward),
// //     //           //   color: Colors.redAccent,
// //     //           //   onPressed: (){
// //     //           //   List<File> list =   fileProvider.getSelectedList();
// //     //           //   for(int i =0 ;i<list.length;i++){
// //     //           //     print('selected list values are...${list[i].path}');
// //     //           //   }
// //     //           //   },
// //     //           // ),
// //     //           onLongPress: () {
// //     //             print(
// //     //                 'path of the file selected is ....${fileProvider.videosListData[index].path}');
// //     //             fileProvider.enableSelectMode = true;
// //     //             // fileProvider.videosListData[index].isSelected = true;
// //     //             print('select mode value is ${fileProvider.selectModeValue}');
// //     //             // setState(() {
// //     //             //   isSelect = true;
// //     //             //   // filePathToShare = path;
// //     //             // });
// //     //             // print('path of the file to share  is ....$path');
// //     //             // print('path of the file name  to share  is ....$file');
// //     //             // uploadFile(context)
// //     //             // uploadFile(context, currentContext: globals.globalContext, path: path, file1: file, sizeDem: 0);
// //     //           },
// //     //           onTap: () {
// //     //             if(fileProvider.selectModeValue){
// //     //               fileProvider.changeIsSelected(true, index);
// //     //               // setState(() {
// //     //               //
// //     //               // });
// //     //               print('list is Selected varibale value is ${fileProvider.videosListData[index].isSelected}');
// //     //               print('list is name varibale value is ${fileProvider.videosListData[index].name}');
// //     //
// //     //               fileProvider.addToSelectedList(fileProvider.videosListData[index].path);
// //     //             }
// //     //             else{
// //     //             }
// //     //
// //     //
// //     //             // setState(() {
// //     //             //   isSelect = !isSelect;
// //     //             // });
// //     //             // for(int i =0;i<files.length();i++){
// //     //             //   print('item in the list are ...${files[i]}');
// //     //             // }
// //     //             // OpenFile.open(path);
// //     //             // Navigator.push(context, MaterialPageRoute(builder: (context) {
// //     //             //   return ViewPDF(pathPDF: files[index].path.toString());
// //     //             //open viewPDF page on click
// //     //           },
// //     //         )
// //     //     );
// //     //   },
// //     // );
// //   }
// // }
