import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_strings.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/custom_appbar.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/views/dashboard/upload_screen.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/utilities/general_utilities.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';

class AudioViews extends StatefulWidget {
  static const routeName = 'audios';

  @override
  _AudioViewsState createState() => _AudioViewsState();
}

class _AudioViewsState extends State<AudioViews> {
  // void initState() {
  //   SchedulerBinding.instance!.addPostFrameCallback((_) {
  //     // Provider.of<CoreProvider>(context, listen: false).checkSpace();
  //     Provider.of<CategoryProvider>(context, listen: false).getAudios();
  //     // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //
  //
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    SizeConfig().init(context);
    return Consumer<CategoryVm>(
      builder: (context, provider, _) {
        return Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                      title: 'Audios',
                      onTap: () {
                        Navigator.pop(context);
                        //
                      }),
                  Expanded(
                    flex: 2,
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
                            provider.changeIsAllAudioSelected();
                            // provider.selectAllInList(provider.audiosList);
                            !provider.isAllAudioSelected
                                ? provider.unselectAllInList(provider.audiosList)
                                : provider.selectAllInList(provider.audiosList);
                          },
                          icon: Icon(
                            provider.isAllAudioSelected ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: provider.audiosList.isNotEmpty,
                    replacement: Center(child: Text('No Files Found')),
                    child: Expanded(
                      flex: 17,
                      child: provider.loading == true
                          ? GeneralUtilities.LoadingFileWidget()
                          : Container(
                            // height: SizeConfig.screenHeight! * 0.82,
                            decoration: BoxDecoration(
                                color: AppColors.kWhiteColor,
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                SizedBox(height: SizeConfig.screenHeight!*0.02,),
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                                    itemCount: provider.audiosList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        height: SizeConfig.screenHeight! * 0.15,
                                        color: AppColors.kWhiteColor,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                height: SizeConfig.screenHeight! * 0.11,
                                                child: Card(
                                                  color: AppColors.kListTileLightGreyColor,
                                                  shape: RoundedRectangleBorder(
                                                    // side: BorderSide(color: Colors.white70, width: 1),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  // margin: EdgeInsets.only(top: 10),
                                                  elevation: 0.0,
                                                  child: ListTile(
                                                    minVerticalPadding: SizeConfig.screenHeight! * 0.035,
                                                    leading: CircleAvatar(
                                                      backgroundColor: AppColors.kPrimaryPurpleColor,
                                                      child: SvgPicture.asset(
                                                        'assets/images/audio_icon.svg',
                                                        height: SizeConfig.screenHeight! * 0.022,
                                                      ),
                                                    ),
                                                    title: Text(
                                                        '${provider.audiosList[index].file.path.split('/').last}'),
                                                    subtitle: Text(
                                                      FileManagerUtilities.formatBytes(
                                                          provider.audiosList[index].file.lengthSync(), 3),
                                                    ),

                                                    // subtitle: Text('${app.packageName}'),
                                                    onTap: () {
                                                      provider.changeIsSelected(index, provider.audiosList);
                                                      if (provider.audiosList[index].isSelected) {
                                                        provider.addToSelectedList = provider.audiosList[index].file;
                                                      } else {
                                                        provider.removeFromSelectedList =
                                                            provider.audiosList[index].file;
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            provider.audiosList[index].isSelected
                                                ? Positioned(
                                                    top: SizeConfig.screenHeight! * -0.02,
                                                    right: 0,
                                                    child: Container(
                                                      height: SizeConfig.screenHeight! * 0.1,
                                                      width: SizeConfig.screenWidth! * 0.07,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: AppColors.kPrimaryPurpleColor),
                                                      child: Padding(
                                                          padding: const EdgeInsets.all(5.0),
                                                          child: Icon(
                                                            Icons.check,
                                                            size: SizeConfig.screenHeight! * 0.02,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 2.0,
                                                  ),
                                          ],
                                        ),
                                      );
                                    },
                                    // separatorBuilder: (BuildContext context, int index) {
                                    //   return CustomDivider();
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ),
                  ),
                  Visibility(
                    visible: provider.selectedFiles.length > 0 ? true : false,
                    child: Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                        // width: SizeConfig.screenWidth!*1,
                        // height: SizeConfig.screenHeight!*0.1,
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
