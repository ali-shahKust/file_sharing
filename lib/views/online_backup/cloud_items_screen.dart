import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/custom_appbar.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/utilities/general_utilities.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_apps.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_audios.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_docs.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_images.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_videos.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';

import '../../constants/app_colors.dart';
import '../../custom_widgets/custom_list_tile.dart';

class CloudItemsScreen extends StatefulWidget {
  static const routeName = 'cloud_items';

  @override
  State<CloudItemsScreen> createState() => _CloudItemsScreenState();
}

class _CloudItemsScreenState extends State<CloudItemsScreen> {
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
      print('size of the images on cloud is ${vm.images.length}');
      // String size = FileManagerUtilities.formatBytes(vm.usedSpace, 2);

      return Scaffold(
        backgroundColor: AppColors.kPrimaryPurpleColor,
        body: SafeArea(
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AppConstants.transfer_background), fit: BoxFit.cover),
                gradient: LinearGradient(colors: [
                  Color(0xff7266F8),
                  Color(0xff110D44),
                ], stops: [
                  0.133,
                  0.5
                ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
            child: Stack(
              children: [
                CustomAppBar(
                    title: 'Cloud Document',
                    onTap: () {
                      Navigator.pop(context);
                      vm.clearAllSelection();
                    }),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       IconButton(
                //           onPressed: () {
                //             Navigator.pop(context);
                //             vm.clearAllSelection();
                //           },
                //           icon: Icon(
                //             Icons.arrow_back_ios,
                //             size: SizeConfig.screenHeight! * 0.024,
                //             color: Colors.white,
                //           )),
                //       PrimaryText(
                //         "Cloud Document",
                //         fontSize: SizeConfig.screenHeight! * 0.020,
                //         fontWeight: FontWeight.w500,
                //       ),
                //       SizedBox(
                //         width: 50,
                //       )
                //     ],
                //   ),
                // ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      vm.isLoading
                          ? Container(
                              child: Image.asset(
                                AppConstants.loader_gif,
                                height: SizeConfig.screenHeight! * 0.3,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.screenHeight! * 0.028,
                                  horizontal: SizeConfig.screenWidth! * 0.05),
                              child: CircularPercentIndicator(
                                radius: 178.0,
                                lineWidth: 13.0,
                                animation: false,
                                addAutomaticKeepAlive: false,
                                // animateFromLastPercent: true,
                                percent: (int.parse(AppConstants.allow_space) - vm.usedSpace) /
                                    int.parse(AppConstants.allow_space),
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PrimaryText(
                                      "${(((int.parse(AppConstants.allow_space) - vm.usedSpace) / int.parse(AppConstants.allow_space)) * 100).toStringAsFixed(0)}%",
                                      fontSize: SizeConfig.screenHeight! * 0.034,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    PrimaryText(
                                      "Available",
                                      fontSize: SizeConfig.screenHeight! * 0.02,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                backgroundColor: Color(0xffE7E7E7).withOpacity(0.18),
                                progressColor: Color(0xff74D5DE),
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.screenHeight! * 0.012, horizontal: SizeConfig.screenWidth! * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                vm.isLoading
                                    ? Padding(
                                        padding: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.03),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GeneralUtilities.miniLoader(Color(0xff74D5DE)),
                                          ],
                                        ),
                                       )
                                    : PrimaryText(
                                        FileManagerUtilities.formatBytes(vm.usedSpace, 2),
                                        fontSize: SizeConfig.screenHeight! * 0.024,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff74D5DE),
                                      ),
                                SizedBox(height: SizeConfig.screenHeight! * 0.01),
                                PrimaryText(
                                  "Used",
                                  fontSize: SizeConfig.screenHeight! * 0.022,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  FileManagerUtilities.formatBytes(int.parse(AppConstants.allow_space), 2),
                                  fontSize: SizeConfig.screenHeight! * 0.024,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.kProgressColor,
                                ),
                                SizedBox(height: SizeConfig.screenHeight! * 0.01),
                                PrimaryText(
                                  "Total",
                                  fontSize: SizeConfig.screenHeight! * 0.022,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      iUtills().upperRoundedContainer(context, SizeConfig.screenWidth, SizeConfig.screenHeight! * 0.475,
                          color: AppColors.kWhiteColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight! * 0.02,
                              horizontal: SizeConfig.screenWidth! * 0.06,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, CloudImages.routeName, arguments: "Images");
                                  },
                                  child: customTile(
                                      AppConstants.images_icon,
                                      "Images",
                                      vm.images.length.toString() + " files ",
                                      vm.isLoading,
                                      AppColors.kImageIconDarkColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, CloudVideos.routeName);
                                  },
                                  child: customTile(
                                      AppConstants.videos_icon,
                                      "Videos",
                                      vm.videos.length.toString() + " files ",
                                      vm.isLoading,
                                      AppColors.kVideoIconDarkColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, CloudAudios.routeName);
                                  },
                                  child: customTile(
                                      AppConstants.audio_icon,
                                      "Audios",
                                      vm.audios.length.toString() + " files ",
                                      vm.isLoading,
                                      AppColors.kAudioIconDarkColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, CloudDocs.routeName);
                                  },
                                  child: customTile(
                                    AppConstants.document_icon,
                                    "Documents",
                                    vm.documents.length.toString() + " files ",
                                    vm.isLoading,
                                    AppColors.kDocumentsIconDarkColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, CloudApps.routeName);
                                  },
                                  child: customTile(
                                    AppConstants.apps_icon,
                                    "Apps",
                                    vm.apps.length.toString() + " files ",
                                    vm.isLoading,
                                    AppColors.kAppsIconDarkColor,
                                  ),
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

  Widget customTile(icon, title, fileslength, isLoading, Color color, {progress}) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: SizeConfig.screenWidth! * 0.05,
          height: SizeConfig.screenHeight! * 0.04,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.04,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryText(
              title,
              fontSize: SizeConfig.screenHeight! * 0.024,
              fontWeight: FontWeight.w500,
              color: AppColors.kBlackColor,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.005,
            ),
            isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GeneralUtilities.miniLoader(
                        color,
                      ),
                    ],
                  )
                : PrimaryText(
                    fileslength,
                    fontSize: SizeConfig.screenHeight! * 0.019,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffAFAFAF),
                  ),
          ],
        ),
        // SizedBox(
        //   width: 20,
        // ),
      ],
    );
  }
}
