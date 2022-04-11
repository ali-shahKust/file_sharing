
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:glass_mor/file_manager/constants/app_colors.dart';
import 'package:glass_mor/file_manager/models/file_model.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/category_provider.dart';
import 'package:mime_type/mime_type.dart';

import 'package:provider/provider.dart';


class ImagesPicker extends StatelessWidget {
  final String title;

  ImagesPicker({

    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget? child) {
        if (provider.loading) {
          return Scaffold(
            body: Center(
              child: Container(
                // width: MediaQuery.of(context).size.width /2 ,
                // height: MediaQuery.of(context).size.height / 2,
                child: Image.asset("assets/gifs/loader.gif", height: screenHeight * 0.4, width: screenWidth * 0.4),
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
                        '${provider.imageList.length} $title',
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
                      visible: provider.imageList.isNotEmpty,
                      replacement: Center(child: Text('No Files Found')),
                      child: Expanded(
                        child: GridView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            reverse: false,
                            cacheExtent: 50,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                            ),
                            itemCount: provider.imageList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // File file = File(provider.imageList[index].file.path);
                              // String path = file.path;

                              FileMangerModel fmm = provider.imageList[index];
                              return _MediaTile(
                                imgmodel: fmm,
                                provider: provider,
                                index: index,
                                screenHeight: screenHeight,
                                screenWidht: screenWidth,
                              );
                            }),
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

class _MediaTile extends StatelessWidget {
  final FileMangerModel imgmodel;
  final CategoryProvider provider;
  final index;
  final double screenHeight;
  final double screenWidht;

  _MediaTile({required  this.imgmodel,required this.provider, this.index,required this.screenHeight, required this.screenWidht});

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
        provider.changeIsSelected(index, provider.imageList);
        if (provider.imageList[index].isSelected) {
          provider.addToSelectedList = provider.imageList[index].file;
        } else {
          provider.removeFromSelectedList = provider.imageList[index].file;
        }
      },
      child: Stack(
        children: [
          Container(
            height: screenHeight * 0.15,
            width: screenWidht * 0.47,
            child: Image.file(
              imgmodel.file,
              scale: 1.0,
              width: screenWidht * 0.3,
              fit: BoxFit.fill,
              cacheWidth: 100,
              cacheHeight: 110,
            ),
            // imgmodel.imgBytes != null
            //     ? Image.memory(
            //         base64Decode(imgmodel.imgBytes),
            //         height: screenHeight * 0.20,
            //         width: screenWidht * 0.4,
            //         fit: BoxFit.fill,
            //       )
            //     :
            // FadeInImage(
            //         placeholder: MemoryImage(kTransparentImage),
            //         fit: BoxFit.fill,
            //         width: double.infinity,
            //         height: double.infinity,
            //         image: FileImage(File(file.path,)),
            //       ),
          ),
          Positioned(
            top: screenHeight * (-0.032),
            // left:50,
            // bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: provider.imageList[index].isSelected
                  ? Container(
                      height: screenHeight * 0.1,
                      width: screenWidht * 0.07,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kBlueColor),
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
            ),
          ),
        ],
      ),
    );
  }
}

// GridTile(
//   header: Align(
//     alignment: Alignment.topRight,
//     child: Padding(
//       padding: EdgeInsets.all(8.0),
//       child: provider.imageList[index].isSelected
//           ? Container(
//         height: screenHeight*0.1,
//         width: screenWidht*0.07,
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: kSelectedIconColor),
//         child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Icon(
//               Icons.check,
//               size: 20.0,
//               color: Colors.white,
//             )),
//       )
//           : SizedBox(
//         height: 2.0,
//       ),
//       // child:  Container(
//       //         height: 30,
//       //         width: 30,
//       //         decoration: BoxDecoration(
//       //             shape: BoxShape.circle, color: Colors.black38),
//       //         child: Padding(
//       //           padding: const EdgeInsets.all(5.0),
//       //           child: provider.imageList[index].isSelected
//       //               ? Icon(
//       //                   Icons.check,
//       //                   size: 20.0,
//       //                   color: Colors.blue,
//       //                 )
//       //               : Icon(
//       //                   Icons.check_box_outline_blank,
//       //                   size: 20.0,
//       //                   color: Colors.white,
//       //                 ),
//       //         ),
//       //       ),
//       // Text(
//       //         '${FileUtils.formatBytes(file.lengthSync(), 1)}',
//       //         style: TextStyle(
//       //           fontSize: 12,
//       //           color: Colors.deepOrange,
//       //         ),
//       //       ),
//     ),
//   ),
//   child
//       : FadeInImage(
//     placeholder: MemoryImage(kTransparentImage),
//                 fit: BoxFit.fill,
//                 width: double.infinity,
//                 height: double.infinity,
//           // fit: BoxFit.fill,
//           // errorBuilder: (b, o, c) {
//           //   return Icon(Icons.image);
//           // },
//           image:
//               // ResizeImage(
//               FileImage(File(file.path)),
//           // width: 150,
//           // height: 150,
//          ),
//   // ),
//   // FadeInImage(
//   //             image: FileImage(
//   //               File(fileProvider.photosListData[index].path),
//   //             ),
//   //             placeholder: MemoryImage(kTransparentImage),
//   //             fit: BoxFit.cover,
//   //             width: double.infinity,
//   //             height: double.infinity,
//   //           ),
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
