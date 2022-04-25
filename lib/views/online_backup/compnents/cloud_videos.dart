import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/cloud_file_card.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import '../../../custom_widgets/app_text_widget.dart';
import '../../../utilities/general_utilities.dart';

class CloudVideos extends StatefulWidget {
  static const routeName = 'cloud_videos';

  @override
  State<CloudVideos> createState() => _CloudVideosState();
}

class _CloudVideosState extends State<CloudVideos> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<OnlineBackUpVm>(
      builder: (context, vm, _) {
        return Scaffold(
          body: SafeArea(
            child: vm.videos.isEmpty
                ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: SizeConfig.screenHeight! * 0.024,
                            color: Colors.black,
                          )),
                      PrimaryText(
                        "Videos",
                        fontSize: SizeConfig.screenHeight! * 0.020,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
                GeneralUtilities.noDataFound(),
              ],
            ):Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryPurpleColor,
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/container_background.webp'),
                    fit: BoxFit.cover),

                // Image.asset('assets/container_background.svg'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: SizeConfig.screenHeight! * 0.024,
                              color: Colors.white,
                            )),
                        PrimaryText(
                          "Videos",
                          fontSize: SizeConfig.screenHeight! * 0.020,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${vm.selectedFiles.length} Selected',
                          style: TextStyle(
                              fontSize: SizeConfig.screenHeight! * 0.024,
                              color: AppColors.kWhiteColor),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 0.3,
                        ),
                        IconButton(
                          onPressed: () {
                            vm.isAllVideosSelected =
                                !vm.isAllVideosSelected;
                           ! vm.isAllVideosSelected
                                ? vm.unselectAllInList(vm.videos)
                                : vm.selectAllInList(vm.videos);
                          },
                          icon: Icon(
                            vm.isAllVideosSelected
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 17,
                    child: Container(
                      // height: SizeConfig.screenHeight! * 0.82,
                      decoration: BoxDecoration(
                          color: AppColors.kWhiteColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Stack(
                        children: [
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            padding:
                                EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                            itemCount: vm.videos.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return InkWell(
                                onTap: () {
                                  vm.videos[index].isSelected =
                                      !vm.videos[index].isSelected;
                                  if (vm.videos[index].isSelected) {
                                    print("Called if");
                                    vm.addToSelectedList =
                                        vm.videos[index];
                                  } else {
                                    print("Called else");
                                    vm.removeFromSelectedList =
                                        vm.videos[index];
                                  }
                                },
                                child: cloudFileCard(
                                    context: context,
                                    size: vm.videos[index].size,
                                    title: vm.videos[index].key,
                                    icon: AppConstants.videos_icon,
                                    item: vm.videos[index],
                                    isSelected:
                                        vm.videos[index].isSelected),
                              );
                            },
                            // separatorBuilder: (BuildContext context, int index) {
                            //   return CustomDivider();
                            // },
                          ),
                          Visibility(
                            visible: vm.selectedFiles.length > 0
                                ? true
                                : false,
                            child: Positioned(
                              bottom: SizeConfig.screenHeight! * 0.012,
                              left: SizeConfig.screenWidth! * 0.005,
                              right: SizeConfig.screenWidth! * 0.005,
                              child: BackupButton(
                                text: 'Recover Now',
                                width: SizeConfig.screenWidth! * 0.58,
                                onTap: () async {
                                  //  pd.show(max: 100, msg: 'File Uploading...');
                                  if (vm.selectedFiles.length > 0) {
                                    Navigator.pushNamed(
                                      context, DownloadScreen.routeName,
                                      arguments: {'files':vm.selectedFiles,"drawer":false},);
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
