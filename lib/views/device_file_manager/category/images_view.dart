import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';

import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_strings.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/custom_widgets/queues_screen.dart';
import 'package:quick_backup/data/models/file_model.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';

class ImagesView extends StatefulWidget {
  static const routeName = 'images';

  ImagesView({
    Key? key,
  }) : super(key: key);

  @override
  _ImagesViewState createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> with SingleTickerProviderStateMixin {
  // final provider = GetIt.I.get<CategoryVm>();
  @override
  Widget build(BuildContext context) {
    print('image list length is ${Provider.of<CategoryVm>(context, listen: false).imageList.length}');
    SizeConfig().init(context);
    // print('all files list length is ${Provider.of<CategoryVm>(context,listen: false).imageList.length}');

    return Consumer<CategoryVm>(
      builder: (context, provider, _) {
        return Scaffold(
            backgroundColor: AppColors.kPrimaryPurpleColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.kPrimaryPurpleColor,
              title: Text('Photos'),
              centerTitle: true,
              leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.kWhiteColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: [
                // SizedBox(
                //   height: SizeConfig.screenHeight! * 0.01,
                // ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.kPrimaryPurpleColor,
                        image: DecorationImage(
                          image: AssetImage('assets/images/container_background.svg'),
                        )
                        // Image.asset('assets/container_background.svg'),
                        ),
                    // height: SizeConfig.screenHeight! * 0.15,
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
                            provider.selectAllInList(provider.imageList);
                          },
                          icon: Icon(
                            provider.selectedFiles.length > 0
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight! * 0.82,
                  decoration: BoxDecoration(
                      color: AppColors.kWhiteColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenHeight! * 0.02,
                            right: SizeConfig.screenHeight! * 0.02,
                            top: SizeConfig.screenHeight! * 0.04),
                        child: GridView.builder(
                            addAutomaticKeepAlives: false,
                            addRepaintBoundaries: false,
                            reverse: false,
                            cacheExtent: 50,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 7.0,
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
                      ),
                      Visibility(
                        visible: provider.selectedFiles.length > 0 ? true : false,
                        child: Positioned(
                          bottom: SizeConfig.screenHeight! * 0.012,
                          left: SizeConfig.screenWidth! * 0.005,
                          right: SizeConfig.screenWidth! * 0.005,
                          child: BackupButton(
                            text: '${AppStrings.backup}',
                            width: SizeConfig.screenWidth! * 0.58,
                            onTap: () async {
                              //  pd.show(max: 100, msg: 'File Uploading...');
                              if (provider.selectedFiles.length > 0) {
                                Navigator.pushNamed(context, QuesScreen.routeName, arguments: provider.selectedFiles)
                                    .whenComplete(() {
                                  print('whencomplete call...');
                                  provider.selectedFiles.clear();
                                });
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
  }
}

class _MediaTile extends StatelessWidget {
  final FileMangerModel imgmodel;
  final CategoryVm provider;
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
            top: SizeConfig.screenHeight! * (-0.034),
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: provider.imageList[index].isSelected
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
                  //     : Container(
                  //   height: SizeConfig.screenHeight! * 0.1,
                  //   width: SizeConfig.screenWidth! * 0.07,
                  //
                  //   // decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kBlueColor),
                  //   child: Icon(
                  //     Icons.check_box_outline_blank,
                  //     size: SizeConfig.screenHeight! * 0.03,
                  //     color: Colors.grey,
                  //   ),
                  // )
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
