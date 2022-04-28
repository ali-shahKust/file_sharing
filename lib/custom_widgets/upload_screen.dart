import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime_type/mime_type.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/custom_widgets/custom_appbar.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/data/extension.dart';
import 'package:quick_backup/utilities/custom_theme.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/utilities/general_utilities.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';

import 'custom_dialog.dart';
import 'loading_widget.dart';

class UploadingScreen extends StatefulWidget {
  static const routeName = 'queue_screen';
  Map map;

  UploadingScreen({required this.map});

  @override
  State<UploadingScreen> createState() => _UploadingScreenState();
}

class _UploadingScreenState extends State<UploadingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.map['files'] != null && !widget.map['drawer']) {
        Provider.of<DashBoardVm>(context, listen: false).completed = 0;
        Provider.of<DashBoardVm>(context, listen: false).uploadFile(widget.map['files'], context).then((value) {
          if (Provider.of<DashBoardVm>(context, listen: false).completed != 0 && Provider.of<DashBoardVm>(context, listen: false).completed == Provider.of<DashBoardVm>(context, listen: false).queue.length) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryText(
                          "All Files Uploaded Successfully.",
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.053,
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<DashBoardVm>(context, listen: false).completed = 0;
                            Provider.of<DashBoardVm>(context, listen: false).queue.clear();
                            Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
                          },
                          child: iUtills().gradientButton(
                              width: SizeConfig.screenWidth! * 0.253,
                              height: SizeConfig.screenHeight! * 0.053,
                              child: Center(
                                  child: PrimaryText(
                                "OK",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ))),
                        )
                      ],
                    ),
                  );
                });
          }
        });
      }
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Provider.of<CategoryVm>(context, listen: false).clearAllSelectedLists();
    return (await Provider.of<DashBoardVm>(context, listen: false).queue.isEmpty ? true : iUtills().exitPopUp(context, 'queue')) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,

      child: Consumer<DashBoardVm>(builder: (context, vm, _) {
        if (vm.completed != 0 && vm.completed == vm.queue.length) {
          vm.queue.clear();
          vm.completed = 0;
          iUtills().showMessage(context: context,title: "Completed", text: "Files Uploaded successfully");
          Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
        }
        return SafeArea(
          child: Scaffold(
            body: vm.isLoading
                ? const Center(
                    child: LoadingWidget(),
                  )
                : vm.connectionLost
                    ? const Center(
                        child: Text("Connection lost"),
                      )
                    : vm.queue.isEmpty
                        ? Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Provider.of<CategoryVm>(context, listen: false).clearAllSelectedLists();
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: SizeConfig.screenHeight! * 0.028,
                                          color: AppColors.kBlackColor,
                                        )),
                                    PrimaryText(
                                      "Uploading",
                                      fontSize: SizeConfig.screenHeight! * 0.028,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kBlackColor,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth! * 0.09,
                                    )
                                  ],
                                ),
                              ),
                              GeneralUtilities.noDataFound(),
                            ],
                          )
                        : Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppConstants.transfer_background), fit: BoxFit.cover)),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      CustomAppBar(
                                        title: "Uploading",
                                        onTap: () {
                                          Provider.of<CategoryVm>(context, listen: false).clearAllSelectedLists();
                                          iUtills().exitPopUp(context, 'queue');
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 90.0,
                                        ).copyWith(bottom: 0),
                                        child: CircularPercentIndicator(
                                          radius: 178.0,
                                          lineWidth: 13.0,
                                          animation: false,
                                          percent: vm.queue.length == 1
                                              ? double.parse(vm.queue[0]!.progress) / 100
                                              : (vm.completed / vm.queue.length).isNaN
                                                  ? 0.0
                                                  : vm.completed / vm.queue.length,
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PrimaryText(
                                                vm.queue.length == 1
                                                    ? "${vm.queue[0]!.progress}%"
                                                    : "${((vm.completed / vm.queue.length) * 100).toStringAsFixed(0)}%",
                                                fontSize: 34,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              PrimaryText(
                                                "Completed",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                          backgroundColor: Color(0xffE7E7E7).withOpacity(0.18),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          linearGradient: LinearGradient(colors: [
                                            Color(0xff765EEF),
                                            Color(0xff74D5DE),
                                          ], stops: [
                                            0.132,
                                            0.3
                                          ]),
                                          rotateLinearGradient: true,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30),
                                        child: Container(
                                          width: SizeConfig.screenWidth,
                                          height: SizeConfig.screenHeight! * 0.104,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                            color: Colors.white.withOpacity(0.08),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SvgPicture.asset(AppConstants.send_file),
                                              vm.completed == vm.queue.length
                                                  ? PrimaryText(
                                                      "Uploaded ${vm.queue.length}" + "${vm.queue.length == 1 ? " File " : " Files "}",
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    )
                                                  : PrimaryText(
                                                      "Uploading ${vm.queue.length}" + "${vm.queue.length == 1 ? " File " : " Files "}",
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: iUtills().upperRoundedContainer(
                                    context,
                                    SizeConfig.screenWidth,
                                    SizeConfig.screenHeight! * 0.393,
                                    color: AppColors.kWhiteColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: vm.queue.length,
                                        itemBuilder: (context, index) {
                                          String type = "";
                                          if (mime(vm.queue[index]!.name)!.split('/').first == "application") {
                                            if (mime(vm.queue[index]!.name)!.split('/').last == "vnd.android.package-archive") {
                                              type = "application";
                                            } else {
                                              type = 'document';
                                            }
                                          } else {
                                            type = mime(vm.queue[index]!.name)!.split('/').first;
                                          }
                                          String size = FileManagerUtilities.formatBytes(int.parse(vm.queue[index]!.size), 2);
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SvgPicture.asset(
                                                  type == "video"
                                                      ? AppConstants.videos_icon
                                                      : type == "audio"
                                                          ? AppConstants.audio_icon
                                                          : type == "image"
                                                              ? AppConstants.images_icon
                                                              : type == "document"
                                                                  ? AppConstants.document_icon
                                                                  : type == "application"
                                                                      ? AppConstants.apps_icon
                                                                      : AppConstants.document_icon,
                                                  width: 32,
                                                  height: 32,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: SizeConfig.screenWidth! - 160,
                                                      child: PrimaryText(
                                                        vm.queue[index]!.name,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: SizeConfig.screenHeight! * 0.020,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors.kBlackColor,
                                                      ),
                                                    ),
                                                    PrimaryText(
                                                      size,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffAFAFAF),
                                                    ),
                                                    PrimaryText(
                                                      DateTime.parse(vm.queue[index]!.date).toddMMMMyyyy(),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffAFAFAF),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircularPercentIndicator(
                                                  radius: 32.0,
                                                  lineWidth: 3.0,
                                                  animation: false,
                                                  percent:
                                                      vm.queue[index]!.progress == "pending" ? 0.0 : double.parse(vm.queue[index]!.progress) / 100,
                                                  center: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      PrimaryText(
                                                        "${vm.queue[index]!.progress}%",
                                                        fontSize: 6,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ],
                                                  ),
                                                  backgroundColor: Color(0xffE7E7E7).withOpacity(0.18),
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  progressColor: type == "video"
                                                      ? AppColors.kButtonSecondColor
                                                      : type == "audio"
                                                          ? AppColors.kAudioPinkColor
                                                          : type == "image"
                                                              ? AppColors.kImagePeachColor
                                                              : type == "document"
                                                                  ? AppColors.kDocGreenColor
                                                                  : type == "apps"
                                                                      ? AppColors.kPrimaryDarkBlackColor
                                                                      : AppColors.kPrimaryColor,
                                                  rotateLinearGradient: true,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return CustomDivider();
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
          ),
        );
      }),
    );
  }
}
