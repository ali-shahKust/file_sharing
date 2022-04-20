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
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/documents/document_vm.dart';

class DocumentViews extends StatefulWidget {
  static const routeName = 'files';

  @override
  State<DocumentViews> createState() => _DocumentViewsState();
}

class _DocumentViewsState extends State<DocumentViews> {
  String type='PDF';
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
        print('number of ppt in doc are...${provider.pptList.length}');
        return Scaffold(
          backgroundColor: AppColors.kPrimaryPurpleColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.kPrimaryPurpleColor,
            title: Text('Documents '),
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
            mainAxisAlignment: MainAxisAlignment.start ,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryPurpleColor,
                      image: DecorationImage(
                        image: AssetImage('assets/images/container_background.png'),
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
                        style:
                        TextStyle(fontSize: SizeConfig.screenHeight! * 0.024, color: AppColors.kWhiteColor),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.3,
                      ),
                      IconButton(
                        onPressed: () {
                          provider.selectAllInList(provider.audiosList);
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
              Visibility(
                visible: provider.filesList.isNotEmpty,
                replacement: Center(child: Text('No Files Found')),
                child: Expanded(
                  flex: 17,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.kWhiteColor,
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        Expanded(flex:5,child:ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: 10),
                          itemCount:AppConstants.documnetCategories.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map category = AppConstants.documnetCategories[index];
                            // List<int> filesLength = [
                            //   categoryVm.imageList.length,
                            //   categoryVm.videosList.length,
                            //   categoryVm.audiosList.length,
                            //   categoryVm.filesList.length,
                            //   categoryVm.filesList.length,
                            // ];

                            return CustomDocumentCategoryList(
                              type: category['title'],
                              icon: category['icon'],
                              color:  category['startColor'],
                              onTap: () {
                                if (index == 0) {
                                  setState(() {
                                    type = 'PDF';
                                  });
                                  // print(
                                  //     'image list in function is testing ${Provider.of<CategoryVm>(context, listen: false).imageList.length}');
                                  //
                                  // Navigator.pushNamed(context, ImagesView.routeName);
                                } else if (index == 1) {
                                  setState(() {
                                    type = 'Slides';
                                  });
                                  // Navigator.pushNamed(context, VideosView.routeName);
                                } else if (index == 2) {
                                  setState(() {
                                    type = 'DOC';
                                  });
                                  // Navigator.pushNamed(context, AudioViews.routeName);
                                } else if (index == 3) {
                                  setState(() {
                                    type = 'Others';
                                  });
                                  // Navigator.pushNamed(context, DocumentViews.routeName);
                                }
                              },
                            );
                          },

                        ), ),
                        Text('$type Files'),
                        Expanded(
                          flex: 12,
                          child: ListView.separated(
                            padding: EdgeInsets.only(left: 10),
                            itemCount: provider.filesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // return CustomListTile(
                              //   leadingColorLight: null,
                              //   subtitleFileSize: '',
                              //   subtitleFileLenght: '',
                              //   title: '',
                              //   leadingColorDark: null,
                              //   leadingIcon: null,
                              // );
                              return ListTile(
                                leading: Icon(
                                  Feather.file,
                                  color: Colors.orangeAccent,
                                ),
                                title: Text('${provider.filesList[index].file.path.split('/').last}'),
                                trailing: provider.filesList[index].isSelected
                                    ? Container(
                                        height: SizeConfig.screenHeight! * 0.1,
                                        width: SizeConfig.screenWidth! * 0.07,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
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
                                onTap: () {
                                  provider.changeIsSelected(index, provider.filesList);
                                  if (provider.filesList[index].isSelected) {
                                    provider.addToSelectedList = provider.filesList[index].file;
                                  } else {
                                    provider.removeFromSelectedList = provider.filesList[index].file;
                                  }
                                },
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return CustomDivider();
                            },
                          ),
                        ),
                      ],
                    ),
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
