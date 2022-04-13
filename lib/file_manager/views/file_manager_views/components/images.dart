import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:glass_mor/file_manager/configurations/size_config.dart';
import 'package:glass_mor/file_manager/constants/app_colors.dart';
import 'package:glass_mor/file_manager/custom_widgets/file_manager_custom_widgets/custom_loader.dart';
import 'package:glass_mor/file_manager/models/file_model.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/category_provider.dart';
import 'package:glass_mor/widget/queues_screen.dart';
import 'package:glass_mor/widget/restore_button.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';

class Images extends StatefulWidget {
  final String title;
  final List<FileMangerModel> imageList;

  Images({
    Key? key,
    required this.title,
    required this.imageList,
  }) : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> with SingleTickerProviderStateMixin {
  // TabController? _tabController;
  // int _selectedIndex = 0;
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // Provider.of<CoreProvider>(context, listen: false).checkSpace();
      Provider.of<CategoryProvider>(context, listen: false).getImages();
      // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer(builder: (BuildContext context, CategoryProvider provider, Widget? child) {
      print('all files list length is ${provider.imageList.length}');
      if (provider.loading) {
        return Scaffold(body: CustomLoader());
      }
      return Consumer(
        builder: (BuildContext context, CategoryProvider provider, Widget? child) {
          print('all files list length is ${provider.imageList.length}');

          return Scaffold(
              body: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight!*0.01,),
              Container(
                color: Colors.grey[200],
                height: SizeConfig.screenHeight!*0.15,
                child: Center(
                  child: Text('Ad Space..',style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),),
                ),
              ),
              Container(
                // color: AppColors.kBlueColor,
                height: SizeConfig.screenHeight!*0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.kGreyColor,
                        )),
                    // Spacer(flex: 12,),

                    Text(
                      'Images',
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight! * 0.024,
                        color: AppColors.kGreyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth!*0.4,),
                    // Spacer(),
                  ],
                ),
              ),
              Container(
                height: SizeConfig.screenHeight! * 0.75,
                child: Stack(
                  children: [
                    GridView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        reverse: false,
                        cacheExtent: 50,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 2.0,
                        ),
                        itemCount: provider.imageList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          FileMangerModel fmm = provider.imageList[index];
                          return _MediaTile(
                            imgmodel: fmm,
                            provider: provider,
                            index: index,
                            // file: item.file
                          );
                        }),
                    Visibility(
                      visible: provider.selectedFiles.length > 0 ? true : false,
                      child: Positioned(
                        bottom: 12,
                        left: 50,
                        right: 50,
                        child: RestoreButton(
                          text: 'Upload Files ( ${provider.selectedFiles.length} )',
                          width: SizeConfig.screenWidth! * 0.58,
                          onTap: () async {
                            //  pd.show(max: 100, msg: 'File Uploading...');
                            if (provider.selectedFiles.length > 0) {
                              Navigator.pushNamed(context, QuesScreen.routeName,arguments: provider.selectedFiles);

                            }
                          },
                          btnColor: AppColors.kBlueColor,
                          padding: SizeConfig.screenHeight! * 0.02,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
              //   CustomScrollView(
              //   primary: false,
              //   slivers: <Widget>[
              //     SliverPadding(
              //       padding: EdgeInsets.all(10.0),
              //       sliver: SliverGrid.count(
              //         crossAxisSpacing: 5.0,
              //         mainAxisSpacing: 5.0,
              //         crossAxisCount: 4,
              //         children: AppConstants.map(
              //           index == 0
              //               ? provider.imageList
              //               :  provider.currentFiles,
              //               (index, item) {
              //             // File file = File(item.path);
              //             // String path = file.path;
              //             // String mimeType = mime(item.path) ?? '';
              //             return _MediaTile(
              //               imgmodel: item,
              //               provider: provider,
              //               index: index,
              //               screenHeight: screenHeight,
              //               screenWidht: screenWidth,
              //               // file: item.file
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // )
              );
        },
      );
    });
  }
}

class _MediaTile extends StatelessWidget {
  final FileMangerModel imgmodel;
  final CategoryProvider provider;
  final index;

  _MediaTile({required this.imgmodel, required this.provider, this.index});

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
            padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.003),
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(8))),
            // height: screenHeight * 0.15  ,
            // width: screenWidht * 0.47,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.file(
                imgmodel.file,
                scale: 1.0,
                width: SizeConfig.screenHeight! * 0.3,
                fit: BoxFit.fill,
                cacheWidth: 100,
                cacheHeight: 110,
              ),
            ),
          ),
          Positioned(
            // top: SizeConfig.screenHeight! * (-0.032),
            // left:50,
            bottom:  SizeConfig.screenHeight! * (-0.032),
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: provider.imageList[index].isSelected
                  ? Container(
                      height: SizeConfig.screenHeight! * 0.1,
                      width: SizeConfig.screenWidth! * 0.07,
                      // decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kBlueColor),
                      child: Icon(
                        Icons.check_box_outlined,
                        size: SizeConfig.screenHeight! * 0.03,
                        color: Colors.grey,
                        // Icons.check,
                        // size: SizeConfig.screenHeight! * 0.02,
                        // color: Colors.white,
                      ),
                    )
                  : Container(
                height: SizeConfig.screenHeight! * 0.1,
                width: SizeConfig.screenWidth! * 0.07,

                // decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kBlueColor),
                child: Icon(
                  Icons.check_box_outline_blank,
                  size: SizeConfig.screenHeight! * 0.03,
                  color: Colors.grey,
                ),
              )
              // SizedBox(
              //         height: 2.0,
              //       ),
            ),
          ),
        ],
      ),
    );
  }
}
