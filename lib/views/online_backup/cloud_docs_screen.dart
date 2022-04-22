import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_apps.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_audios.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_images.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_videos.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';

import '../../constants/app_colors.dart';
import '../../custom_widgets/custom_list_tile.dart';

class CloudDocsScreen extends StatefulWidget {
  static const routeName = 'pics';

  @override
  State<CloudDocsScreen> createState() => _CloudDocsScreenState();
}

class _CloudDocsScreenState extends State<CloudDocsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<OnlineBackUpVm>(context, listen: false).listItems(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnlineBackUpVm>(builder: (context, vm, _) {
      String size = FileManagerUtilities.formatBytes(vm.usedSpace, 2);

      return Scaffold(
        backgroundColor: AppColors.kPrimaryPurpleColor,
        // bottomNavigationBar: BottomAppBar(
        //   child: ElevatedButton(
        //     onPressed: () async {
        //       bool granted = await Permission.manageExternalStorage.isGranted;
        //       if (granted) {
        //         print("Files ${vm.pics.length}");
        //         await Navigator.pushNamed(context, DownloadScreen.routeName,
        //             arguments: vm.pics);
        //       } else {
        //         await Permission.manageExternalStorage.request();
        //       }
        //     },
        //     child: const Text("Restore all"),
        //   ),
        // ),
        body: SafeArea(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppConstants.transfer_background),
                    fit: BoxFit.cover),
                gradient: LinearGradient(colors: [
                  Color(0xff7266F8),
                  Color(0xff110D44),
                ], stops: [
                  0.133,
                  0.5
                ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            vm.clearAllSelection();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: SizeConfig.screenHeight! * 0.024,
                            color: Colors.white,
                          )),
                      PrimaryText(
                        "Cloud Document",
                        fontSize: SizeConfig.screenHeight! * 0.020,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  size,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff74D5DE),
                                ),
                                PrimaryText(
                                  "Used",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  AppConstants.allow_space,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff74D5DE),
                                ),
                                PrimaryText(
                                  "Total",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      iUtills().upperRoundedContainer(
                          context,
                          SizeConfig.screenWidth,
                          SizeConfig.screenHeight! * 0.475,
                          color: AppColors.kWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 22),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CloudImages.routeName,
                                        arguments: "Images");
                                  },
                                  child: customTile(
                                      AppConstants.images_icon,
                                      "Images",
                                      vm.images.length.toString() + " files "),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CloudVideos.routeName);
                                  },
                                  child: customTile(
                                      AppConstants.videos_icon,
                                      "Videos",
                                      vm.videos.length.toString() + " files "),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CloudAudios.routeName);
                                  },
                                  child: customTile(
                                      AppConstants.audio_icon,
                                      "Audios",
                                      vm.audios.length.toString() + " files "),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CloudDocsScreen.routeName);
                                  },
                                  child: customTile(
                                      AppConstants.document_icon,
                                      "Documents",
                                      vm.documents.length.toString() +
                                          " files "),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CloudApps.routeName);
                                  },
                                  child: customTile(
                                      AppConstants.apps_icon,
                                      "Apps",
                                      vm.apps.length.toString() + " files "),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget customTile(icon, title, fileslength, {progress}) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 32,
          height: 32,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            PrimaryText(
              title,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.kBlackColor,
            ),
            PrimaryText(
              fileslength,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xffAFAFAF),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
