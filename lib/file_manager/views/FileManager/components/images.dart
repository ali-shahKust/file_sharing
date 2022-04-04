import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import '../../../../widget/file_manager_custom_widgets/custom_loader.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../models/file_model.dart';
import '../../../provider/FileManagerProvider/category_provider.dart';

class Images extends StatefulWidget {
  final String title;

  Images({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> with SingleTickerProviderStateMixin {
   // TabController? _tabController;
   // int _selectedIndex = 0;
  // @override
  void initState() {
    super.initState();
    // _tabController= TabController(length: Provider.of<CategoryProvider>(context,listen: false).imageTabs.length, vsync: this);
    // _tabController!.addListener(() {
    //   setState(() {
    //     _selectedIndex = _tabController!.index;
    //   });
    //   // provider.imageList, provider.imageTabs[val]);
    //   print("Selected Index: " + _tabController!.index.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget? child) {
        print('all files list length is ${provider.imageList.length}');
        if (provider.loading) {
          return Scaffold(body: CustomLoader());
        }
        return DefaultTabController(
          // initialIndex: _selectedIndex,
          length: provider.imageTabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('${widget.title}'),
              bottom: TabBar(
                // controller: _tabController,
                indicatorColor: AppColors.kBlackColor,
                labelColor: AppColors.kBlackColor,
                unselectedLabelColor: AppColors.kWhiteColor,
                isScrollable: provider.imageTabs.length < 3 ? false : true,
                tabs: AppConstants.map<Widget>(
                  provider.imageTabs,
                  (index, label) {
                    return Tab(text: '$label');
                  },
                ),
                onTap: (val) => provider.switchCurrentFiles(
                    provider.imageList, provider.imageTabs[val]),
              ),
            ),
            body: Visibility(
              visible: provider.imageList.isNotEmpty,
              replacement: Center(child: Text('No Files Found')),
              child: TabBarView(
                children: AppConstants.map<Widget>(
                  provider.imageTabs,
                  (index, label) {
                    provider.currentFiles;
                    // List<FileMangerModel> tempList = provider.currentFiles;
                    // print('sorted files list length is ${tempList.length}');
                    return CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: EdgeInsets.all(10.0),
                          sliver: SliverGrid.count(
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            crossAxisCount: 4,
                            children: AppConstants.map(
                              index == 0
                                  ? provider.imageList
                                  :  provider.currentFiles,
                              (index, item) {
                                // File file = File(item.path);
                                // String path = file.path;
                                // String mimeType = mime(item.path) ?? '';
                                return _MediaTile(
                                  imgmodel: item,
                                  provider: provider,
                                  index: index,
                                  screenHeight: screenHeight,
                                  screenWidht: screenWidth,
                                    // file: item.file
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class _MediaTile extends StatelessWidget {
//   final File file;
//   // final String mimeType;
//
//   _MediaTile({required this.file});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => OpenFile.open(file.path),
//       child: GridTile(
//         header: Container(
//           height: 50,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.black54, Colors.transparent],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child:  Text(
//                       '${FileManagerUtilities.formatBytes(file.lengthSync(), 1)}',
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//             ),
//           ),
//         ),
//         child:Image(
//                 fit: BoxFit.cover,
//                 errorBuilder: (b, o, c) {
//                   return Icon(Icons.image);
//                 },
//                 image: ResizeImage(
//                   FileImage(File(file.path)),
//                   width: 150,
//                   height: 150,
//                 ),
//               ),
//       ),
//     );
//   }
// }

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
            height: screenHeight * 0.15  ,
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