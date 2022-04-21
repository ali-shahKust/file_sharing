import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/constants/app_style.dart';
import 'package:quick_backup/custom_widgets/custom_list_tile.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/utilities/custom_theme.dart';
import 'package:quick_backup/views/device_file_manager/category/audio_view.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quick_backup/views/device_file_manager/category/images_view.dart';
import 'package:quick_backup/views/device_file_manager/category/videos_view.dart';
import 'package:quick_backup/views/device_file_manager/device_apps/app_views.dart';
import 'package:quick_backup/views/device_file_manager/documents/document_view.dart';
import 'package:quick_backup/views/device_file_manager/documents/document_vm.dart';
import 'package:quick_backup/views/device_file_manager/file_manager_home/core_vm.dart';

class FileManagerHome extends StatefulWidget {
  static const routeName = 'device_file_manager';

  @override
  _FileManagerHomeState createState() => _FileManagerHomeState();
}

class _FileManagerHomeState extends State<FileManagerHome> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.kPrimaryPurpleColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.kPrimaryPurpleColor,
        title: Text('Quick Backup'),
        centerTitle: true,
        //TODO uncomment to show premium icon...
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.01),
        //     child: Container(
        //         height: SizeConfig.screenHeight! * 0.15,
        //         width: SizeConfig.screenWidth! * 0.2,
        //         decoration: BoxDecoration(
        //             color: AppColors.kDarkPurpleColor,
        //             borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
        //         child: Align(
        //             alignment: Alignment.centerLeft,
        //             child: Padding(
        //               padding: EdgeInsets.only(left: SizeConfig.screenHeight! * 0.015),
        //               child: Icon(
        //                 Icons.workspace_premium,
        //                 color: Colors.red,
        //               ),
        //             ))
        //         // SvgPicture.asset('assets/premium_icon.svg'),
        //         ),
        //   )
        // ],
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
      body: Column(
        children: <Widget>[
          // SizedBox(height: SizeConfig.screenHeight! * 0.04),
          Expanded(
            flex: 4,
            child: Container(
              color: AppColors.kPrimaryPurpleColor,
              height: SizeConfig.screenHeight! * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeaderContainer(),
                ],
              ),
            ),
          ),
          Expanded(flex: 12, child: _CategoriesSection()),
          // SizedBox(height: SizeConfig.screenHeight! * 0.03),
        ],
      ),
      // Browse(),
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CoreVm>(context, listen: false).checkSpace();
      Provider.of<CategoryVm>(context, listen: false).getDeviceFileManager();
      Provider.of<CategoryVm>(context, listen: false).fetchAllListLength();
      // Provider.of<DocumentVm>(context, listen: false).getTextFile();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

//                        _title("${((provider.freeSpace)/1000000000).round()} GB used  ${((provider.totalSpace)/1000000000).round()}  GB"),
class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('total space from the provider is${Provider.of<CoreVm>(context, listen: false).totalSpace}');
    print('used status from the provider is${Provider.of<CoreVm>(context, listen: false).usedSpace}');
    final categoryVm = Provider.of<CategoryVm>(context, listen: false);
    print('length of video in build function is ${categoryVm.videosList.length}');
    return Container(
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      height: SizeConfig.screenHeight! * 0.8,
      width: SizeConfig.screenWidth! * 1,
      child: ListView.separated(
        padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.03),
        physics: NeverScrollableScrollPhysics(),
        itemCount: AppConstants.categories.length,
        itemBuilder: (BuildContext context, int index) {
          Map category = AppConstants.categories[index];
          // List<int> filesLength = [
          //   categoryVm.imageList.length,
          //   categoryVm.videosList.length,
          //   categoryVm.audiosList.length,
          //   categoryVm.filesList.length,
          //   categoryVm.filesList.length,
          // ];

          return CustomListTile(
            title: category['title'],
            leadingIcon: category['icon'],
            subtitleFileSize: '2 GB',
            leadingColorDark: category['endColor'],
            subtitleFileLenght: ' Files',
            leadingColorLight: category['startColor'],
            onTap: () {
              if (index == 0) {
                print(
                    'image list in function is testing ${Provider.of<CategoryVm>(context, listen: false).imageList.length}');

                Navigator.pushNamed(context, ImagesView.routeName);
              } else if (index == 1) {
                Navigator.pushNamed(context, VideosView.routeName);
              } else if (index == 2) {
                Navigator.pushNamed(context, AudioViews.routeName);
              } else if (index == 3) {
                Navigator.pushNamed(context, DocumentViews.routeName);
              }
              else if (index == 4) {
                Navigator.pushNamed(context, AppViews.routeName);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return CustomDivider();
        },
      ),
    );
  }
}

class HeaderContainer extends StatelessWidget {
  HeaderContainer({Key? key}) : super(key: key);
  int _totalSpace = 0;
  int _usedSpace = 0;
  int _percentageUse = 0;


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, CoreVm provider, Widget? child) {
      if (provider.storageLoading) {
        return Container(
          height: MediaQuery.of(context).size.height / 5,
          child: Image.asset("assets/gifs/loader.gif",
              height: MediaQuery.of(context).size.height * 0.4, width: MediaQuery.of(context).size.width * 0.4),
        );
      } else {
        _totalSpace = ((provider.totalSpace) / 1000000000).round();
        _usedSpace = ((provider.usedSpace) / 1000000000).round();
        _percentageUse = ((_usedSpace / _totalSpace) * 100).round();
        return Container(
          height: SizeConfig.screenHeight! * 0.14,
          width: SizeConfig.screenWidth! * 0.85,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenHeight! * 0.03, vertical: SizeConfig.screenHeight! * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: AppColors.kWhiteColor,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Used: ${((provider.usedSpace) / 1000000000).round()}  GB',
                    style: AppStyle.kStorageTextStyle,
                  ),
                  Text(
                    'Total: ${((provider.totalSpace) / 1000000000).round()} GB',
                    style: AppStyle.kStorageTextStyle,
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              LinearPercentIndicator(
                width: SizeConfig.screenWidth! * 0.7,
                lineHeight: SizeConfig.screenHeight! * 0.015,
                percent: _percentageUse / 100,
                // progressColor: Colors.orange,
                linearGradient: LinearGradient(
                  colors: [
                    AppColors.kSliderGradientFirstColor,
                    AppColors.kSliderGradientSecondColor,
                    AppColors.kSliderGradientThirdColor,
                    AppColors.kSliderGradientFourthColor
                  ],
                  // begin: Alignment.topLeft,
                  // end: Alignment.bottomRight,
                ),
                // linearGradientBackgroundColor: LinearGradient(
                //   colors: [
                //     Color.fromRGBO(252, 106, 119, 1),
                //     Color.fromRGBO(188, 96, 227, 1),
                //   ],
                //   // begin: Alignment.topLeft,
                //   // end: Alignment.bottomRight,
                // ),
              ),
            ],
          ),
        );
      }
    });
    // return Container(
    //   height: SizeConfig.screenHeight! * 0.14,
    //   width: SizeConfig.screenWidth! * 0.85,
    //   padding:
    //       EdgeInsets.symmetric(horizontal: SizeConfig.screenHeight! * 0.03, vertical: SizeConfig.screenHeight! * 0.04),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(25),
    //     color: AppColors.kWhiteColor,
    //   ),
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             'Used: ${((provider.freeSpace)/1000000000).round()}',
    //             style: TextStyle(color: AppColors.kBlackColor),
    //           ),
    //           Text(
    //             'Total: 256 GB',
    //             style: TextStyle(color: AppColors.kBlackColor),
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: SizeConfig.screenHeight! * 0.02,
    //       ),
    //       LinearPercentIndicator(
    //         width: SizeConfig.screenWidth! * 0.7,
    //         lineHeight: SizeConfig.screenHeight! * 0.015,
    //         percent: 0.7,
    //         // progressColor: Colors.orange,
    //         linearGradient: LinearGradient(
    //           colors: [
    //             Color.fromRGBO(59, 192, 227, 1),
    //             Color.fromRGBO(73, 185, 215, 1),
    //             Color.fromRGBO(252, 106, 119, 1),
    //             Color.fromRGBO(188, 96, 227, 1),
    //           ],
    //           // begin: Alignment.topLeft,
    //           // end: Alignment.bottomRight,
    //         ),
    //         linearGradientBackgroundColor: LinearGradient(
    //           colors: [
    //             Colors.red,
    //             Colors.orangeAccent,
    //           ],
    //           // begin: Alignment.topLeft,
    //           // end: Alignment.bottomRight,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
