
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/file_model.dart';
import '../../../provider/FileManagerProvider/category_provider.dart';
// import 'package:file_sharing_app/Service/Globals.dart' as globals;


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


