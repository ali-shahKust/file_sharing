import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/custom_document_category_list.dart';
import 'package:quick_backup/custom_widgets/custom_list_tile.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/documents/document_vm.dart';

import '../../../custom_widgets/file_manager_custom_widgets/custom_document_list_tiles.dart';

class DocumentViews extends StatefulWidget {
  static const routeName = 'files';

  @override
  State<DocumentViews> createState() => _DocumentViewsState();
}

class _DocumentViewsState extends State<DocumentViews> {
  String type = 'PDF';
  bool isSelected = false;

  // void initState() {
  //   SchedulerBinding.instance!.addPostFrameCallback((_) {
  //     // Provider.of<CoreProvider>(context, listen: false).checkSpace();
  //     Provider.of<DocumentVm>(context, listen: false).getTextFile();
  //     // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //
  //
  //   });
  //   super.initState();
  // }
//   final String title;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CategoryVm provider, Widget? child) {
        print('i im in build function of type ${provider.getDocCurrentSelection(type)}');
        print('number of ppt in doc are...${provider.pptList.length}');
        return Scaffold(
          backgroundColor: AppColors.kPrimaryPurpleColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.kPrimaryPurpleColor,
            title: Text('Documents '),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kWhiteColor,
              ),
            ),
          ),
          body: provider.loading
              ? Container(
                  // width: MediaQuery.of(context).size.width /2 ,
                  // height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: Image.asset("assets/gifs/loader.gif",
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryPurpleColor,
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/container_background.webp',
                                ),
                                fit: BoxFit.cover)
                            // Image.asset('assets/container_background.svg'),
                            ),
                        // height: SizeConfig.screenHeight! * 0.15,
                        //  child:Image.asset(''),
                      ),
                    ),
                    Expanded(
                      flex: 17,
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.kWhiteColor,
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 10),
                                itemCount: AppConstants.documnetCategories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final documentVm = Provider.of<DocumentVm>(context, listen: false);
                                  // Map category = AppConstants.documnetCategories[index];

                                  return CustomDocumentCategoryList(
                                    type: documentVm.fileCategoryList[index]['title'],
                                    isSelected: documentVm.fileCategoryList[index]['isSelected'],
                                    icon: documentVm.fileCategoryList[index]['icon'],
                                    color: documentVm.fileCategoryList[index]['startColor'],
                                    onTap: () {
                                      if (index == 0) {
                                        setState(() {
                                          type = AppConstants.docCategories[0];
                                          documentVm.changeIsSelected(index);
                                          // documentVm.unSelectAll(index);
                                        });
                                        // print(
                                        //     'image list in function is testing ${Provider.of<CategoryVm>(context, listen: false).imageList.length}');
                                        //
                                        // Navigator.pushNamed(context, ImagesView.routeName);
                                      } else if (index == 1) {
                                        setState(() {
                                          type = AppConstants.docCategories[1];
                                          documentVm.changeIsSelected(index);
                                          // documentVm.unSelectAll(index);
                                          // category['isSelected']=='1';
                                          // isSelected=!isSelected;
                                        });
                                        // Navigator.pushNamed(context, VideosView.routeName);
                                      } else if (index == 2) {
                                        setState(() {
                                          type = AppConstants.docCategories[2];
                                          documentVm.changeIsSelected(index);
                                          // documentVm.unSelectAll(index);
                                        });
                                        // Navigator.pushNamed(context, AudioViews.routeName);
                                      } else if (index == 3) {
                                        setState(() {
                                          type = AppConstants.docCategories[3];
                                          documentVm.changeIsSelected(index);
                                          // documentVm.unSelectAll(index);
                                          // isSelected=!isSelected;
                                        });
                                        // Navigator.pushNamed(context, DocumentViews.routeName);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.06),
                              child: Text(
                                '$type Files',
                                style: TextStyle(
                                  fontSize: SizeConfig.screenHeight! * 0.023,
                                  color: AppColors.kPrimaryPurpleColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${provider.selectedFiles.length} Selected',
                                  style: TextStyle(
                                    fontSize: SizeConfig.screenHeight! * 0.024,
                                    color: AppColors.kBlackColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth! * 0.3,
                                ),
                                IconButton(
                                  onPressed: () {
                                    provider.ChangeDocSelection(type);

                                    provider.selectAllInList(FileManagerUtilities.getDocList(type, context));
                                  },
                                  icon: Icon(
                                    provider.getDocCurrentSelection(type)
                                        ? Icons.check_box_outlined
                                        : Icons.check_box_outline_blank,
                                    color: AppColors.kBlackColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            Expanded(
                              flex: 12,
                              child: CustomDocumentListTile(
                                type: type,
                                list: FileManagerUtilities.getDocList(type, context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
