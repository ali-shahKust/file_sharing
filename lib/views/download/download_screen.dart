import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_file/open_file.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/custom_widgets/loading_widget.dart';
import 'package:quick_backup/data/extension.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import '../../configurations/size_config.dart';
import '../../custom_widgets/app_text_widget.dart';
import '../../utilities/general_utilities.dart';
import '../../utilities/i_utills.dart';
import '../dashboard/dashboard_vm.dart';

class DownloadScreen extends StatefulWidget {
  static const routeName = 'download_screen';
  Map map;

  DownloadScreen({required this.map});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.map['files'] != null && !widget.map['drawer']) {
        Provider.of<DownloadVm>(context, listen: false).downloadFile(widget.map['files'], context).then((value) {
          if (completed == Provider.of<DownloadVm>(context, listen: false).queue.length) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryText(
                          "All Files Downloaded Successfully.",
                          fontSize: SizeConfig.screenHeight! * 0.02,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.053,
                        ),
                        InkWell(
                          onTap: () {
                            completed = 0;
                            Provider.of<DashBoardVm>(context, listen: false).queue.clear();
                            Provider.of<OnlineBackUpVm>(context, listen: false).selectedFiles.clear();
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
      } else {
        if (completed != 0 && completed == Provider.of<DownloadVm>(context, listen: false).queue.length) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryText(
                        "All Files Downloaded Successfully.",
                        fontSize: SizeConfig.screenHeight! * 0.02,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.053,
                      ),
                      InkWell(
                        onTap: () {
                          completed = 0;
                          Provider.of<DashBoardVm>(context, listen: false).queue.clear();
                          Provider.of<OnlineBackUpVm>(context, listen: false).selectedFiles.clear();
                          Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
                        },
                        child: iUtills().gradientButton(
                            width: SizeConfig.screenWidth! * 0.253,
                            height: SizeConfig.screenHeight! * 0.053,
                            child: Center(
                                child: PrimaryText(
                              "OK",
                              fontSize: SizeConfig.screenHeight! * 0.02,
                              fontWeight: FontWeight.w600,
                            ))),
                      )
                    ],
                  ),
                );
              });
        }
      }
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Provider.of<OnlineBackUpVm>(context, listen: false).clearAllSelection();
    return (await Provider.of<DownloadVm>(context, listen: false).queue.isEmpty
            ? true
            : iUtills().exitPopUp(context, 'download')) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Consumer<DownloadVm>(builder: (context, vm, _) {
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
                                      "Transferring",
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
                          )
                        : Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppConstants.transfer_background), fit: BoxFit.cover)),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  iUtills().exitPopUp(context, 'download');
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back_ios,
                                                  size: SizeConfig.screenHeight! * 0.024,
                                                  color: Colors.white,
                                                )),
                                            PrimaryText(
                                              "Transferring",
                                              fontSize: SizeConfig.screenHeight! * 0.020,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              width: 50,
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: SizeConfig.screenHeight! * 0.06,
                                        ).copyWith(bottom: 0),
                                        child: CircularPercentIndicator(
                                          radius: 178.0,
                                          lineWidth: 13.0,
                                          animation: false,
                                          percent: vm.queue.length == 1
                                              ? double.parse(vm.queue[0]!.progress) / 100
                                              : (completed / vm.queue.length).isNaN
                                                  ? 0.0
                                                  : completed / vm.queue.length,
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PrimaryText(
                                                vm.queue.length == 1
                                                    ? "${vm.queue[0]!.progress}%"
                                                    : "${((completed / vm.queue.length) * 100).toStringAsFixed(0)}%",
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
                                        height: SizeConfig.screenHeight! * 0.04,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.05),
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
                                              completed == vm.queue.length
                                                  ? PrimaryText(
                                                      "Downloaded ${vm.queue.length}" +
                                                          "${vm.queue.length == 1 ? " File " : " Files "}",
                                                      fontSize: SizeConfig.screenHeight! * 0.024,
                                                      fontWeight: FontWeight.w600,
                                                    )
                                                  : PrimaryText(
                                                      "Downloading ${vm.queue.length}" +
                                                          "${vm.queue.length == 1 ? " File " : " Files "}",
                                                      fontSize: SizeConfig.screenHeight! * 0.024,
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
                                      padding: EdgeInsets.all(
                                        SizeConfig.screenHeight! * 0.012,
                                      ),
                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: vm.queue.length,
                                        itemBuilder: (context, index) {
                                          String type = "";
                                          if (mime(vm.queue[index]!.name)!.split('/').first == "application") {
                                            if (mime(vm.queue[index]!.name)!.split('/').last ==
                                                "vnd.android.package-archive") {
                                              type = "application";
                                            } else {
                                              type = 'document';
                                            }
                                          } else {
                                            type = mime(vm.queue[index]!.name)!.split('/').first;
                                          }
                                          print("PROGRESS Report :${vm.queue[index]!.progress}");
                                          String size =
                                              FileManagerUtilities.formatBytes(int.parse(vm.queue[index]!.size), 2);
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: SizeConfig.screenHeight! * 0.008,
                                              horizontal: SizeConfig.screenWidth! * 0.05,
                                            ),
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
                                                  width: SizeConfig.screenWidth! * 0.04,
                                                  height: SizeConfig.screenHeight! * 0.04,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.screenWidth! * 0.04,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: SizeConfig.screenWidth! - 160,
                                                      child: PrimaryText(
                                                        vm.queue[index]!.name.split("/").last,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: SizeConfig.screenHeight! * 0.020,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors.kBlackColor,
                                                      ),
                                                    ),
                                                    PrimaryText(
                                                      size,
                                                      fontSize: SizeConfig.screenHeight! * 0.018,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffAFAFAF),
                                                    ),
                                                    PrimaryText(
                                                      DateTime.parse(vm.queue[index]!.date).toddMMMMyyyy(),
                                                      fontSize: SizeConfig.screenHeight! * 0.02,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xffAFAFAF),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.screenWidth!*0.008,
                                                ),
                                                vm.queue[index]!.progress == "100" ||
                                                        vm.queue[index]!.progress == "Exist already"
                                                    ? InkWell(
                                                        onTap: () {
                                                          OpenFile.open(vm.queue[index]!.path);
                                                        },
                                                        child: PrimaryText(
                                                          "Open",
                                                          color: type == "video"
                                                              ? AppColors.kButtonSecondColor
                                                              : type == "audio"
                                                                  ? AppColors.kAudioPinkColor
                                                                  : type == "image"
                                                                      ? AppColors.kImagePeachColor
                                                                      : type == "document"
                                                                          ? AppColors.kDocGreenColor
                                                                          : type == "application"
                                                                              ? AppColors.kPrimaryDarkBlackColor
                                                                              : AppColors.kPrimaryColor,
                                                          fontSize: SizeConfig.screenHeight!*0.018,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      )
                                                    : CircularPercentIndicator(
                                                        radius: 34.0,
                                                        lineWidth: 3.0,
                                                        animation: false,
                                                        percent: vm.queue[index]!.progress == "pending"
                                                            ? 0.0
                                                            : vm.queue[index]!.progress == "Exist already"
                                                                ? 1.0
                                                                : double.parse(vm.queue[index]!.progress) / 100,
                                                        center: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            vm.queue[index]!.progress == "Exist already"
                                                                ? PrimaryText(
                                                                    "Exist already",
                                                                    fontSize: 4,
                                                                    color: Colors.black54,
                                                                    fontWeight: FontWeight.w700,
                                                                  )
                                                                : PrimaryText(
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
                                                                        : type == "application"
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
