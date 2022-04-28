import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_strings.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/custom_appbar.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/data/models/file_model.dart';
import 'package:quick_backup/utilities/general_utilities.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../custom_widgets/upload_screen.dart';

class VideosView extends StatefulWidget {
  static const routeName = 'videos';

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  // void initState() {
  //   SchedulerBinding.instance!.addPostFrameCallback((_) {
  //     // Provider.of<CoreProvider>(context, listen: false).checkSpace();
  //     Provider.of<CategoryVm>(context, listen: false).getVideos();
  //     // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //
  //
  //   });
  //   super.initState();
  // }
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer(
      builder: (BuildContext context, CategoryVm provider, Widget? child) {
        return Scaffold(
          // backgroundColor: Colors.white,
          backgroundColor: AppColors.kPrimaryPurpleColor,
          body: SafeArea(
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryPurpleColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/container_background.webp'),
                  )
                  // Image.asset('assets/container_background.svg'),
                  ),
              child: Column(
                children: [
                  CustomAppBar(
                      title: 'Videos',
                      onTap: () {
                        Navigator.pop(context);
                        //
                      }),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${provider.selectedFiles.length} Selected',
                          style: TextStyle(fontSize: SizeConfig.screenHeight! * 0.024, color: AppColors.kWhiteColor),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 0.3,
                        ),
                        IconButton(
                          onPressed: () {
                            provider.changeIsAllVideosSelected();
                            // provider.selectAllInList(provider.videosList);
                            !provider.isAllVideosSelected
                                ? provider.unselectAllInList(provider.videosList)
                                : provider.selectAllInList(provider.videosList);
                          },
                          icon: Icon(
                            provider.isAllVideosSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight! * 0.82,
                    decoration: BoxDecoration(
                        color: AppColors.kWhiteColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                    child: Stack(
                      //
                      children: [
                        Visibility(
                          visible: provider.videosList.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenHeight! * 0.02,
                                right: SizeConfig.screenHeight! * 0.02,
                                top: SizeConfig.screenHeight! * 0.04),
                            child: PagewiseGridViewExample(),
                          ),
                        ),
                        Visibility(
                          visible: provider.selectedFiles.length > 0 ? true : false,
                          child: Positioned(
                            bottom: SizeConfig.screenHeight! * 0.012,
                            left: SizeConfig.screenWidth! * 0.005,
                            right: SizeConfig.screenWidth! * 0.005,
                            child: BackupButton(
                              text: '${AppStrings.backup}  (${provider.selectedFiles.length})',
                              width: SizeConfig.screenWidth! * 0.58,
                              onTap: () async {
                                //  pd.show(max: 100, msg: 'File Uploading...');
                                if (provider.selectedFiles.length > 0) {
                                  Navigator.pushNamed(context, UploadingScreen.routeName,
                                      arguments: {'files': provider.selectedFiles, "drawer": false}).whenComplete(() {
                                    // provider.selectedFiles.clear();
                                    // provider.clearAllSelectedLists();
                                  });
                                  // Toast('No file Selected', context);
                                }
                              },
                              btnColor: AppColors.kGreyColor,
                              padding: SizeConfig.screenHeight! * 0.02,
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
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
        physics: BouncingScrollPhysics(),
        pageSize: PAGE_SIZE,
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 7.0,
        childAspectRatio: 1,
        padding: EdgeInsets.all(0.0),
        itemBuilder: this._itemBuilder,
        loadingBuilder: (context) {
          // Provider.of<CategoryVm>(context, listen: false).setVideoLoading();
          return Center(child: GeneralUtilities.LoadingFileWidget());
          // return Container(height:300, width:double.infinity,child: gridPlaceHolder());
        },
        pageFuture: (pageIndex) {
          // pageIndex! * PAGE_SIZE, PAGE_SIZE
          return getThumbnails(pageIndex! * PAGE_SIZE, (pageIndex * PAGE_SIZE) + PAGE_SIZE, context);
        });
  }

  Widget _itemBuilder(context, FileMangerModel entry, _) {
    final provider = Provider.of<CategoryVm>(context, listen: false);
    return _MediaTile(
      imgmodel: entry,
      provider: provider,
      index: _,
    );
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[600]!),
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Container(
              height: 150,
              width: 200,
              //   decoration: BoxDecoration(
              //       color: Colors.grey[200],
              //       image: DecorationImage(
              //           image: Image.file(entry.thumbNail!),
              //           fit: BoxFit.fill)),
              // ),
              child: Image.memory(
                entry.thumbNail,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                    height: 30.0,
                    child: SingleChildScrollView(child: Text(entry.file.path, style: TextStyle(fontSize: 12.0))))),
          ),
          SizedBox(height: 8.0),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8.0),
          //   child: Text(
          //     entry.,
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          // ),
          SizedBox(height: 8.0)
        ]));
  }
}

Future<List<FileMangerModel>> getThumbnails(int start, int end, context) async {


  Provider.of<CategoryVm>(context, listen: false).videoTempList.clear();
  if (start < Provider.of<CategoryVm>(context, listen: false).videosList.length) {
    // templist.clear();
    for (int i = start; i < end; i++) {

      try {
        final uint8list = await VideoThumbnail.thumbnailData(
          video: Provider.of<CategoryVm>(context, listen: false).videosList[i].file.path,

          imageFormat: ImageFormat.JPEG,
          maxWidth: 200,
          // // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
          quality: 50,
        );

        FileMangerModel fm = FileMangerModel(
            file: Provider.of<CategoryVm>(context, listen: false).videosList[i].file,
            isSelected: false,
            thumbNail: uint8list);
        Provider.of<CategoryVm>(context, listen: false).videoTempList.add(fm);
      } catch (e) {
      }

      // Provider.of<CategoryVm>(context, listen: false).incrementVideoIndex();

      // }

    }
  } else {
    return [];
  }

  // start = end;
  // end = end*2;
  return Provider.of<CategoryVm>(context, listen: false).videoTempList;
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
  final CategoryVm provider;
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

    return InkWell(
      onTap: () {
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
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(8))),
            // height: screenHeight * 0.15  ,
            // width: screenWidht * 0.47,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.memory(
                imgmodel.thumbNail,
                scale: 1.0,
                width: SizeConfig.screenHeight! * 0.3,
                fit: BoxFit.fitWidth,
                cacheWidth: 100,
                cacheHeight: 110,
              ),
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
            top: SizeConfig.screenHeight! * (-0.034),
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: provider.videosList[index].isSelected
                  ? Container(
                      height: SizeConfig.screenHeight! * 0.1,
                      width: SizeConfig.screenWidth! * 0.07,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryPurpleColor),
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.check,
                            size: SizeConfig.screenHeight! * 0.02,
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

