import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/constants/app_strings.dart';
import 'package:quick_backup/custom_widgets/cloud_file_card.dart';
import 'package:quick_backup/custom_widgets/custom_appbar.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/online_backup/cloud_items_screen.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import '../../../custom_widgets/app_text_widget.dart';
import '../../../utilities/general_utilities.dart';

class CloudImages extends StatefulWidget {
  static const routeName = 'cloud_images';
  String title;

  CloudImages({required this.title});

  @override
  State<CloudImages> createState() => _CloudImagesState();
}

class _CloudImagesState extends State<CloudImages> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<OnlineBackUpVm>(
      builder: (context, vm, _) {
        return Scaffold(
          body: SafeArea(
            child: vm.isLoading
                ? Stack(
              children: [
                // CustomAppBar(
                //     title: 'Images',
                //     onTap: () {
                //       Navigator.pop(context);
                //
                //     }),
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
                        "Images",
                        fontSize: SizeConfig.screenHeight! * 0.025,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: SizeConfig.screenHeight! * 0.055,
                      )
                    ],
                  ),
                ),
                GeneralUtilities.LoadingFileWidget(),
              ],
            ):vm.images.isEmpty
                ? Stack(
                    children: [
                      // CustomAppBar(
                      //     title: 'Images',
                      //     onTap: () {
                      //       Navigator.pop(context);
                      //
                      //     }),
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
                              "Images",
                              fontSize: SizeConfig.screenHeight! * 0.025,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: SizeConfig.screenHeight! * 0.055,
                            )
                          ],
                        ),
                      ),
                      GeneralUtilities.noDataFound(),
                    ],
                  )
                :
                     Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryPurpleColor,
                          image: DecorationImage(
                              image: AssetImage('assets/images/container_background.webp'), fit: BoxFit.cover),

                          // Image.asset('assets/container_background.svg'),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAppBar(
                                title: 'Images',
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, CloudItemsScreen.routeName);
                                }),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${vm.selectedFiles.length} Selected',
                                    style: TextStyle(
                                        fontSize: SizeConfig.screenHeight! * 0.024, color: AppColors.kWhiteColor),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.screenWidth! * 0.3,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      vm.isAllImagesSelected = !vm.isAllImagesSelected;
                                      !vm.isAllImagesSelected
                                          ? vm.unselectAllInList(vm.images)
                                          : vm.selectAllInList(vm.images);
                                    },
                                    icon: Icon(
                                      vm.isAllImagesSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
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
                                    borderRadius:
                                        BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: SizeConfig.screenHeight! * 0.02,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),

                                        padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                                        itemCount: vm.images.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return InkWell(
                                            onTap: () {
                                              vm.images[index].isSelected = !vm.images[index].isSelected;
                                              if (vm.images[index].isSelected) {
                                                vm.addToSelectedList = vm.images[index];
                                              } else {
                                                vm.removeFromSelectedList = vm.images[index];
                                              }
                                            },
                                            child: cloudFileCard(
                                                context: context,
                                                size: vm.images[index].size,
                                                title: vm.images[index].key,
                                                item: vm.images[index],
                                                icon: AppConstants.images_icon,
                                                type: AppStrings.cloudItemCategories[0],
                                                isSelected: vm.images[index].isSelected),
                                          );
                                        },
                                        // separatorBuilder: (BuildContext context, int index) {
                                        //   return CustomDivider();
                                        // },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: vm.selectedFiles.length > 0 ? true : false,
                              child: Expanded(
                                flex: 3,
                                child: Container(
                                  color: Colors.white,
                                  // width: SizeConfig.screenWidth!*1,
                                  // height: SizeConfig.screenHeight!*0.1,
                                  child: BackupButton(
                                    text: 'Recover Now ',
                                    width: SizeConfig.screenWidth! * 0.58,
                                    onTap: () async {
                                      //  pd.show(max: 100, msg: 'File Uploading...');
                                      if (vm.selectedFiles.length > 0) {
                                        Navigator.pushNamed(
                                          context,
                                          DownloadScreen.routeName,
                                          arguments: {'files': vm.selectedFiles, "drawer": false},
                                        );
                                      }
                                    },
                                    btnColor: AppColors.kGreyColor,
                                    padding: SizeConfig.screenHeight! * 0.02,
                                  ),
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
