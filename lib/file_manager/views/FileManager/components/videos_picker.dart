import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:glass_mor/file_manager/configurations/size_config.dart';
import 'package:glass_mor/file_manager/models/file_model.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/category_provider.dart';

import 'package:mime_type/mime_type.dart';

import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideosPicker extends StatelessWidget {
  final String title;

  VideosPicker({
    required this.title,
  });

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget? child) {
        print('loader value from provider is ${provider.videoLoader}');
        // if (provider.videoLoader) {
        //   return Scaffold(
        //     body: Center(
        //       child: Container(
        //         child: Image.asset("assets/gifs/loader.gif",
        //             height: SizeConfig.screenHeight! * 0.4, width: SizeConfig.screenWidth! * 0.4),
        //       ),
        //     ),
        //   );
        // }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.screenHeight! * 0.02, horizontal: SizeConfig.screenWidth! * 0.01),
            child: Stack(
              //
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: SizeConfig.screenWidth! * 0.01,
                    //     vertical: SizeConfig.screenHeight! * 0.008,
                    //   ),
                    //   child: Text(
                    //     '${provider.videosList.length}  $title ',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: SizeConfig.screenHeight! * 0.03,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    Visibility(
                      visible: provider.videosList.isNotEmpty,
                      // replacement: Center(child: Text('No Files Found')),
                      // replacement: Center(child: EasyLoading.show(status: 'Loading...')),
                      child: Expanded(
                          child:
                              // Provider.of<CategoryProvider>(context, listen: false).videoLoader == false
                              //     ?
                              PagewiseGridViewExample()
                          // : GridView.builder(
                          //     addAutomaticKeepAlives: false,
                          //     addRepaintBoundaries: false,
                          //     reverse: false,
                          //     cacheExtent: 15,
                          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 4,
                          //       mainAxisSpacing: 0.0,
                          //       crossAxisSpacing: 0.0,
                          //     ),
                          //     itemCount: provider.videosList.length,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       // File file = File(provider.videosList[index].file.path);
                          //       // String path = file.path;
                          //
                          //       FileMangerModel fmm = provider.videosList[index];
                          //       // if(provider.videosList[provider.videosList.length-1].thumbNail!=null){
                          //       return _MediaTile(
                          //         imgmodel: fmm,
                          //         provider: provider,
                          //         index: index,
                          //         // screenHeight: screenHeight,
                          //         // screenWidht: screenWidth,
                          //       );
                          //
                          //       //     // }
                          //       //     // else{
                          //       //     //   return gridPlaceHolder();
                          //       //     // }
                          //       //
                          //     }
                          //     //   //   GridView.count(
                          //     //   // crossAxisSpacing: 3.0,
                          //     //   // mainAxisSpacing: 3.0,
                          //     //   // crossAxisCount: 3,
                          //     //   //
                          //     //   // children: Constants.map(
                          //     //   //   provider.videosList,
                          //     //   //   (index, item) {
                          //     //   //     File file = File(item[index].fileList[index].path);
                          //     //   //     print('file in the view from model is ....$file');
                          //     //   //     String path = file.path;
                          //     //   //     String mimeType = mime(path) ?? '';
                          //     //   //     return _MediaTile(file: file, mimeType: mimeType);
                          //     //   //   },
                          //     //   // ),
                          //     //   // ),
                          //     //   //   ),
                          //     //   // ],
                          //     ),

                          // GridView.builder(
                          //   reverse: false,
                          //   cacheExtent: 15,
                          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 3,
                          //     mainAxisSpacing: 7.0,
                          //     crossAxisSpacing: 7.0,
                          //   ),
                          //   itemCount:  provider.currentFiles.length ?? 0,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     // ImageModel imageModel = ImageModel.fromJson(list[index]);
                          //     return Container(
                          //       child: Stack(
                          //         alignment: Alignment.bottomCenter,
                          //         children: <Widget>[
                          //           FadeInImage(
                          //             image: FileImage(
                          //               File(fileProvider.photosListData[index].path),
                          //             ),
                          //             placeholder: MemoryImage(kTransparentImage),
                          //             fit: BoxFit.cover,
                          //             width: double.infinity,
                          //             height: double.infinity,
                          //           ),
                          //           // Container(
                          //           //   color: Colors.black.withOpacity(0.7),
                          //           //   height: 30,
                          //           //   width: double.infinity,
                          //           //   child: Center(
                          //           //     child: Text(
                          //           //       fileProvider.photosListData[index].name ?? '',
                          //           //       maxLines: 1,
                          //           //       overflow: TextOverflow.ellipsis,
                          //           //       style: TextStyle(
                          //           //           color: Colors.white,
                          //           //           fontSize: 16,
                          //           //           fontFamily: 'Regular'
                          //           //       ),
                          //           //     ),
                          //           //   ),
                          //           // )
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),

                          // TabBarView(
                          //   children: Constants.map<Widget>(
                          //     provider.imageTabs,
                          //     (index, label) {
                          //       List l = provider.currentFiles;
                          //        print('total images are...${l.length}');
                          //
                          //     },
                          //   ),
                          // ),

                          //
                          ),
                    ),
                  ],
                ),

                // Positioned(
                //   bottom: 5,
                //   left:50,
                //   right: 50,
                //   child: RaisedButton(
                //     color: Colors.blue,
                //     child: Text(
                //       "Selected Files ${provider.selectedFiles.length}",
                //       style: TextStyle(color: Colors.white,fontSize: 18),
                //     ),
                //     onPressed: () {
                //       for (int i = 0; i < provider.selectedFiles.length; i++) {
                //         print(
                //             'files in the selected list are.....${provider.selectedFiles[i]}');
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PagewiseGridViewExample extends StatelessWidget {
  int PAGE_SIZE = 10;

  @override
  Widget build(BuildContext context) {
    return PagewiseGridView.count(
        pageSize: PAGE_SIZE,
        crossAxisCount: 4,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(0.0),
        itemBuilder: this._itemBuilder,
        loadingBuilder: (context) {
          // Provider.of<CategoryProvider>(context, listen: false).setVideoLoading();
          return const Center(child: CircularProgressIndicator());
          // return Container(height:300, width:double.infinity,child: gridPlaceHolder());
        },
        pageFuture: (pageIndex) {
          print('page index is ....$pageIndex');
          // pageIndex! * PAGE_SIZE, PAGE_SIZE
          return getThumbnails(pageIndex! * PAGE_SIZE, (pageIndex * PAGE_SIZE) + PAGE_SIZE, context);
        });
  }

  Widget _itemBuilder(context, FileMangerModel entry, _) {
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    return _MediaTile(
      imgmodel: entry,
      provider: provider,
      index: _,
    );

  }
}

Future<List<FileMangerModel>> getThumbnails(int start, int end, context) async {
  print('start value is $start');
  print('END value is $end');

  Provider.of<CategoryProvider>(context, listen: false).videoTempList.clear();
  if (start < Provider.of<CategoryProvider>(context, listen: false).videosList.length) {
    // templist.clear();
    for (int i = start; i < end; i++) {
      // print('I  value is $i');
      // print('start   value  in loop is $start');
      // print('end value is $end');
      // for(int i=0;i<Provider.of<CategoryProvider>(context, listen: false).videosList.length;i++)
      //   {
      try {
        print(
            'Creating Thumbnail for: ${Provider.of<CategoryProvider>(context, listen: false).videosList[i].file.path}');

        final uint8list = await VideoThumbnail.thumbnailData(
          video: Provider.of<CategoryProvider>(context, listen: false).videosList[i].file.path,

          imageFormat: ImageFormat.JPEG,
           maxWidth: 200,
          // // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
           quality: 25,
        );

        // print('thumbnail is $uint8list');
        FileMangerModel fm = FileMangerModel(
            file: Provider.of<CategoryProvider>(context, listen: false).videosList[i].file,
            isSelected: false,
            thumbNail: uint8list);
        Provider.of<CategoryProvider>(context, listen: false).videoTempList.add(fm);
      } catch (e) {
        print('Cant create Thumbnail : $e');
      }

      // Provider.of<CategoryProvider>(context, listen: false).incrementVideoIndex();

      // }

    }
  } else {
    return [];
  }

  // start = end;
  // end = end*2;
  print('length of primary list is ${Provider.of<CategoryProvider>(context, listen: false).videoTempList.length}');
  return Provider.of<CategoryProvider>(context, listen: false).videoTempList;
}

Widget gridPlaceHolder() {
  return Expanded(
    flex: 5,
    child: GridView.builder(
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        reverse: false,
        // cacheExtent: 15,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          // File file = File(provider.videosList[index].file.path);
          // String path = file.path;
          // if(provider.videosList[provider.videosList.length-1].thumbNail!=null){
          return Image.asset(
            'assets/file_manager_assets/video-placeholder.png',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          );
        }),
  );
  // return  Container(
  //   padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.003),
  //   decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(8))),
  //   // height: screenHeight * 0.15  ,
  //   // width: screenWidht * 0.47,
  //   child: ClipRRect(
  //     borderRadius: BorderRadius.all(Radius.circular(8)),
  //     child: Container(
  //       color: Colors.black26,
  //       width: SizeConfig.screenHeight! * 0.3,
  //     )
  //   ),
  // );
}

class _MediaTile extends StatelessWidget {
  final FileMangerModel imgmodel;
  final CategoryProvider provider;
  final index;

  _MediaTile({
    required this.imgmodel,
    required this.provider,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    File file = File(imgmodel.file.path);
    String path = file.path;
    String mimeType = mime(path) ?? '';
    // if (imgmodel.imgBytes != null) {
    //   print('byte code of the image is...${imgmodel.imgBytes}');
    // }
    return InkWell(
      onTap: () {
        print('tapped index is $index');
        provider.changeIsSelected(index, provider.videosList);
        if (provider.videosList[index].isSelected) {
          provider.addToSelectedList = provider.videosList[index].file;
        } else {
          provider.removeFromSelectedList = provider.videosList[index].file;
        }
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.003),
            // decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(8))),
            // height: screenHeight * 0.15  ,
            // width: screenWidht * 0.47,
            child: Image.memory(
                imgmodel.thumbNail,
                scale: 1.0,
                width: SizeConfig.screenHeight! * 0.3,
                fit: BoxFit.fitWidth,
                 cacheWidth: 100,
                 cacheHeight: 110,
              ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Padding(
                padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.002),
                child: Icon(
                  Icons.play_circle,
                  size: SizeConfig.screenHeight! * 0.03,
                  color: Colors.white,
                )),
          ),
          Positioned(
            top: SizeConfig.screenHeight! * (-0.032),
            // left:50,
            // bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.005),
              child: provider.videosList[index].isSelected
                  ? Container(
                      height: SizeConfig.screenHeight! * 0.1,
                      width: SizeConfig.screenWidth! * 0.07,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                      child: Icon(
                        Icons.check,
                        size: SizeConfig.screenHeight! * 0.02,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(
                      height: 2.0,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

//
//
// import 'dart:io';
//
// import 'package:file_sharing_app/provider/file_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:transparent_image/transparent_image.dart';
//
// class PhotosPicker extends StatelessWidget {
//   const PhotosPicker({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final fileProvider = Provider.of<FileProvider>(context, listen: false);
//     // fileProvider.getlist(w);
//
//     return fileProvider.photosListData == null
//         ? CircularProgressIndicator(
//       color: Colors.green,
//     )
//       //   : ListView.builder(
//       // //if file/folder list is grabbed, then show here
//       // itemCount: fileProvider.photosListData.length ?? 0,
//       // itemBuilder: (context, index) {
//         // File file = File(fileProvider.photosListData[index].path);
//         // String path = (file.path.toString());
//         // if (widget.isVideo) {
//         //   print('type of the screen is ${widget.isVideo}');
//         //
//         //   getThumbNail(path);
//         //   print('thumbnail of the video is $videoThumbNail');
//         // }
//     :Container(
//           child: GridView.builder(
//             reverse: false,
//             cacheExtent: 15,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               mainAxisSpacing: 7.0,
//               crossAxisSpacing: 7.0,
//             ),
//             itemCount: fileProvider.photosListData.length ?? 0,
//             itemBuilder: (BuildContext context, int index) {
//               // ImageModel imageModel = ImageModel.fromJson(list[index]);
//               return Container(
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: <Widget>[
//                     FadeInImage(
//                       image: FileImage(
//                         File(fileProvider.photosListData[index].path),
//                       ),
//                       placeholder: MemoryImage(kTransparentImage),
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                     // Container(
//                     //   color: Colors.black.withOpacity(0.7),
//                     //   height: 30,
//                     //   width: double.infinity,
//                     //   child: Center(
//                     //     child: Text(
//                     //       fileProvider.photosListData[index].name ?? '',
//                     //       maxLines: 1,
//                     //       overflow: TextOverflow.ellipsis,
//                     //       style: TextStyle(
//                     //           color: Colors.white,
//                     //           fontSize: 16,
//                     //           fontFamily: 'Regular'
//                     //       ),
//                     //     ),
//                     //   ),
//                     // )
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//         // return Card(
//         //     child: ListTile(
//         //       title: Text(fileProvider.photosListData[index].name ?? ''),
//         //       // leading:
//         //       // Padding(
//         //       //   padding: const EdgeInsets.symmetric(vertical: 5.0),
//         //       //   child: Image.file(
//         //       //     File(fileProvider.photosListData[index].path),
//         //       //     fit: BoxFit.fitWidth,
//         //       //     width: 70,
//         //       //     height: 70,
//         //       //   ),
//         //       // ),
//         //       // Icon(Icons.picture_as_pdf),
//         //       trailing: fileProvider.photosListData[index].isSelected?Container(
//         //           height: 30,
//         //           width: 30,
//         //           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//         //           child: Padding(
//         //               padding: const EdgeInsets.all(5.0),
//         //               child: Icon(
//         //                 Icons.check,
//         //                 size: 20.0,
//         //                 color: Colors.white,
//         //               ))):SizedBox(height: 2.0,),
//         //       // IconButton(
//         //       //   icon:Icon(Icons.arrow_forward),
//         //       //   color: Colors.redAccent,
//         //       //   onPressed: (){
//         //       //   List<File> list =   fileProvider.getSelectedList();
//         //       //   for(int i =0 ;i<list.length;i++){
//         //       //     print('selected list values are...${list[i].path}');
//         //       //   }
//         //       //   },
//         //       // ),
//         //       onLongPress: () {
//         //         print(
//         //             'path of the file selected is ....${fileProvider.photosListData[index].path}');
//         //         fileProvider.enableSelectMode = true;
//         //         // fileProvider.photosListData[index].isSelected = true;
//         //         print('select mode value is ${fileProvider.selectModeValue}');
//         //         // setState(() {
//         //         //   isSelect = true;
//         //         //   // filePathToShare = path;
//         //         // });
//         //         // print('path of the file to share  is ....$path');
//         //         // print('path of the file name  to share  is ....$file');
//         //         // uploadFile(context)
//         //         // uploadFile(context, currentContext: globals.globalContext, path: path, file1: file, sizeDem: 0);
//         //       },
//         //       onTap: () {
//         //         if(fileProvider.selectModeValue){
//         //           fileProvider.changeIsSelected(true, index);
//         //           // setState(() {
//         //           //
//         //           // });
//         //           print('list is Selected varibale value is ${fileProvider.photosListData[index].isSelected}');
//         //           print('list is name varibale value is ${fileProvider.photosListData[index].name}');
//         //
//         //           fileProvider.addToSelectedList(fileProvider.photosListData[index].path);
//         //         }
//         //         else{
//         //         }
//         //
//         //
//         //         // setState(() {
//         //         //   isSelect = !isSelect;
//         //         // });
//         //         // for(int i =0;i<files.length();i++){
//         //         //   print('item in the list are ...${files[i]}');
//         //         // }
//         //         // OpenFile.open(path);
//         //         // Navigator.push(context, MaterialPageRoute(builder: (context) {
//         //         //   return ViewPDF(pathPDF: files[index].path.toString());
//         //         //open viewPDF page on click
//         //       },
//         //     )
//         // );
//     //   },
//     // );
//   }
// }

//
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:file_sharing_app/provider/file_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:transparent_image/transparent_image.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
//
// class VideosPicker extends StatelessWidget {
//   const VideosPicker({Key key}) : super(key: key);
//
//   //   Future<String> getThumbNail(final filepath) async {
//   //   String thumbnail = await VideoThumbnail.thumbnailData(
//   //     video: filepath,
//   //     imageFormat: ImageFormat.PNG,
//   //     maxWidth: 100,
//   //     // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//   //     quality: 25,
//   //   ).toString();
//   //   return thumbnail;
//   //   // setState(() {
//   //   //   videoThumbNail = thumbnail;
//   //   // });
//   // }
//   @override
//   Widget build(BuildContext context) {
//     final fileProvider = Provider.of<FileProvider>(context, listen: false);
//     // fileProvider.getlist(w);
//
//     return fileProvider.videosListData == null
//         ? CircularProgressIndicator(
//       color: Colors.green,
//     )
//         :Container(
//       child: GridView.builder(
//         reverse: false,
//         cacheExtent: 15,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           mainAxisSpacing: 7.0,
//           crossAxisSpacing: 7.0,
//         ),
//         itemCount: fileProvider.videosListData.length ?? 0,
//         itemBuilder: (BuildContext context, int index) {
//           // ImageModel imageModel = ImageModel.fromJson(list[index]);
//           return Container(
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: <Widget>[
//               Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 5.0),
//                           child: Container(
//                               child: Image.memory(
//                                 fileProvider.videosListData[index].thumbNail,
//                                 height: 200,
//                                 width: 200,
//                                 fit: BoxFit.cover,
//                               ),
//                           ),
//                         ),
//                 // Container(
//                 //   color: Colors.black.withOpacity(0.7),
//                 //   height: 30,
//                 //   width: double.infinity,
//                 //   child: Center(
//                 //     child: Text(
//                 //       fileProvider.photosListData[index].name ?? '',
//                 //       maxLines: 1,
//                 //       overflow: TextOverflow.ellipsis,
//                 //       style: TextStyle(
//                 //           color: Colors.white,
//                 //           fontSize: 16,
//                 //           fontFamily: 'Regular'
//                 //       ),
//                 //     ),
//                 //   ),
//                 // )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//     //     : ListView.builder(
//     //   //if file/folder list is grabbed, then show here
//     //   itemCount: fileProvider.videosListData.length ?? 0,
//     //   itemBuilder: (context, index) {
//     //     // File file = File(fileProvider.videosListData[index].path);
//     //     // String path = (file.path.toString());
//     //     // if (widget.isVideo) {
//     //     //   print('type of the screen is ${widget.isVideo}');
//     //     //
//     //     //   getThumbNail(path);
//     //     //   print('thumbnail of the video is $videoThumbNail');
//     //     // }
//     //
//     //     // dynamic thumnail =  getThumbNail(fileProvider.videosListData[index].path);
//     //
//     //     return Card(
//     //         child: ListTile(
//     //           title: Text(fileProvider.videosListData[index].name ?? ''),
//     //           leading:
//     //           Padding(
//     //             padding: const EdgeInsets.symmetric(vertical: 5.0),
//     //             child: Container(
//     //                 child: Image.memory(
//     //                   fileProvider.videosListData[index].thumbNail,
//     //                   height: 200,
//     //                   width: 200,
//     //                   fit: BoxFit.cover,
//     //                 ),
//     //             ),
//     //           ),
//     //           //   child: Image.file(
//     //           //     File(fileProvider.videosListData[index].path),
//     //           //     fit: BoxFit.fitWidth,
//     //           //     width: 70,
//     //           //     height: 70,
//     //           //   ),
//     //           // ),
//     //           // Icon(Icons.picture_as_pdf),
//     //           trailing: fileProvider.videosListData[index].isSelected?Container(
//     //               height: 30,
//     //               width: 30,
//     //               decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//     //               child: Padding(
//     //                   padding: const EdgeInsets.all(5.0),
//     //                   child: Icon(
//     //                     Icons.check,
//     //                     size: 20.0,
//     //                     color: Colors.white,
//     //                   ))):SizedBox(height: 2.0,),
//     //           // IconButton(
//     //           //   icon:Icon(Icons.arrow_forward),
//     //           //   color: Colors.redAccent,
//     //           //   onPressed: (){
//     //           //   List<File> list =   fileProvider.getSelectedList();
//     //           //   for(int i =0 ;i<list.length;i++){
//     //           //     print('selected list values are...${list[i].path}');
//     //           //   }
//     //           //   },
//     //           // ),
//     //           onLongPress: () {
//     //             print(
//     //                 'path of the file selected is ....${fileProvider.videosListData[index].path}');
//     //             fileProvider.enableSelectMode = true;
//     //             // fileProvider.videosListData[index].isSelected = true;
//     //             print('select mode value is ${fileProvider.selectModeValue}');
//     //             // setState(() {
//     //             //   isSelect = true;
//     //             //   // filePathToShare = path;
//     //             // });
//     //             // print('path of the file to share  is ....$path');
//     //             // print('path of the file name  to share  is ....$file');
//     //             // uploadFile(context)
//     //             // uploadFile(context, currentContext: globals.globalContext, path: path, file1: file, sizeDem: 0);
//     //           },
//     //           onTap: () {
//     //             if(fileProvider.selectModeValue){
//     //               fileProvider.changeIsSelected(true, index);
//     //               // setState(() {
//     //               //
//     //               // });
//     //               print('list is Selected varibale value is ${fileProvider.videosListData[index].isSelected}');
//     //               print('list is name varibale value is ${fileProvider.videosListData[index].name}');
//     //
//     //               fileProvider.addToSelectedList(fileProvider.videosListData[index].path);
//     //             }
//     //             else{
//     //             }
//     //
//     //
//     //             // setState(() {
//     //             //   isSelect = !isSelect;
//     //             // });
//     //             // for(int i =0;i<files.length();i++){
//     //             //   print('item in the list are ...${files[i]}');
//     //             // }
//     //             // OpenFile.open(path);
//     //             // Navigator.push(context, MaterialPageRoute(builder: (context) {
//     //             //   return ViewPDF(pathPDF: files[index].path.toString());
//     //             //open viewPDF page on click
//     //           },
//     //         )
//     //     );
//     //   },
//     // );
//   }
// }
