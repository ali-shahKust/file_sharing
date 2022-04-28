import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/cloud_file_card.dart';
import 'package:quick_backup/custom_widgets/custom_appbar.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import '../../../utilities/general_utilities.dart';

class CloudAudios extends StatefulWidget {
  static const routeName = 'cloud_audios';

  @override
  State<CloudAudios> createState() => _CloudAudiosState();
}

class _CloudAudiosState extends State<CloudAudios> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<OnlineBackUpVm>(
      builder: (context, vm, _) {
        return Scaffold(
          body: SafeArea(
            child: vm.audios.isEmpty
                ? Stack(
              children: [
                CustomAppBar(
                    title: 'Apps',
                    onTap: () {
                      Navigator.pop(context);

                    }),
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                      title: 'Audios',
                      onTap: () {
                        Navigator.pop(context);

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
                              fontSize: SizeConfig.screenHeight! * 0.024,
                              color: AppColors.kWhiteColor),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 0.3,
                        ),
                        IconButton(
                          onPressed: () {
                            vm.isAllAudioSelected =
                                !vm.isAllAudioSelected;
                            !vm.isAllAudioSelected
                                ? vm.unselectAllInList(vm.audios)
                                : vm.selectAllInList(vm.audios);
                          },
                          icon: Icon(
                            vm.isAllAudioSelected
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
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.screenHeight!*0.02,),
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding:
                                  EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                              itemCount: vm.audios.length,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return InkWell(
                                  onTap: () {
                                    vm.audios[index].isSelected =
                                        !vm.audios[index].isSelected;
                                    if (vm.audios[index].isSelected) {
                                      print("Called if");
                                      vm.addToSelectedList =
                                          vm.audios[index];
                                    } else {
                                      print("Called else");
                                      vm.removeFromSelectedList =
                                          vm.audios[index];
                                    }
                                  },
                                  child: cloudFileCard(
                                      context: context,
                                      size: vm.audios[index].size,
                                      title: vm.audios[index].key,
                                      icon: AppConstants.audio_icon,
                                      item: vm.audios[index],
                                      isSelected:
                                          vm.audios[index].isSelected),
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
                  Visibility(
                    visible: vm.selectedFiles.length > 0 ? true : false,
                    child: Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.white,
                        // width: SizeConfig.screenWidth!*1,
                        // height: SizeConfig.screenHeight!*0.1,
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
