import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_file/open_file.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/custom_appbar.dart';
import 'package:quick_backup/custom_widgets/dialoge_cancel.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/custom_widgets/loading_widget.dart';
import 'package:quick_backup/data/extension.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/views/dashboard/dashboard_screen.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import '../../configurations/size_config.dart';
import '../../custom_widgets/app_text_widget.dart';
import '../../utilities/general_utilities.dart';
import '../../utilities/i_utills.dart';

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
        Provider.of<DownloadVm>(context, listen: false).downloadFile(widget.map['files'], context);

        // then((value) {
        //   if (Provider.of<DownloadVm>(context, listen: false).completed == Provider.of<DownloadVm>(context, listen: false).queue.length) {
        //     showDialog(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             content: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 PrimaryText(
        //                   "All Files Downloaded Successfully.",
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.w400,
        //                   color: Colors.black,
        //                 ),
        //                 SizedBox(
        //                   height: SizeConfig.screenHeight! * 0.053,
        //                 ),
        //                 InkWell(
        //                   onTap: () {
        //                     Provider.of<DownloadVm>(context, listen: false).completed = 0;
        //                     Provider.of<DashBoardVm>(context, listen: false).queue.clear();
        //                     Provider.of<OnlineBackUpVm>(context, listen: false).selectedFiles.clear();
        //                     Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
        //                   },
        //                   child: iUtills().gradientButton(
        //                       width: SizeConfig.screenWidth! * 0.253,
        //                       height: SizeConfig.screenHeight! * 0.053,
        //                       child: Center(
        //                           child: PrimaryText(
        //                         "OK",
        //                         fontSize: 18,
        //                         fontWeight: FontWeight.w600,
        //                       ))),
        //                 )
        //               ],
        //             ),
        //           );
        //         });
        //   }
        // });
      }
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
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
        // print('value of double is ....${vm.queue[0]!.progress}');
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
                    : widget.map['drawer'] && vm.queue.isEmpty
                        ? Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // Provider.of<CategoryVm>(context, listen: false).clearAllSelectedLists();
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: SizeConfig.screenHeight! * 0.028,
                                          color: AppColors.kBlackColor,
                                        )),
                                    PrimaryText(
                                      "Downloading",
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
                                  padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.02),
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
                                    "Downloading",
                                    fontSize: SizeConfig.screenHeight! * 0.028,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(right: SizeConfig.screenWidth!*0.04),
                                    child: GestureDetector(
                                      onTap: (){
                                         showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CancelDialoge(
                                                title: "Do you want to Cancel Download?",
                                                description: "",
                                                onOkTap: (){
                                                  vm.queue.clear();
                                                  Navigator.pushNamedAndRemoveUntil(context, DashBoardScreen.routeName, (route) => false);
                                                },
                                              );
                                            });
                                        // iUtills().exitPopUp(context, 'download');
                                      },
                                      child: PrimaryText(
                                        "Cancel",
                                        fontSize: SizeConfig.screenHeight! * 0.02,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.kWhiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                      // CustomAppBar(
                                      //   title: "Downloading",
                                      //   onTap: () {
                                      //     iUtills().exitPopUp(context, 'download');
                                      //   },
                                      // ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: SizeConfig.screenHeight! * 0.06,
                                        ).copyWith(bottom: 0),
                                        child: CircularPercentIndicator(
                                          radius: 178.0,
                                          lineWidth: 13.0,
                                          animation: false,
                                          percent: vm.queue.length == 1
                                              ?  vm.queue[0]!.progress=='pending'
                                                  ?0.0
                                                  :double.parse(vm.queue[0]!.progress) / 100
                                              : (vm.completed / vm.queue.length).isNaN
                                                  ? 0.0
                                                  : vm.completed / vm.queue.length,
                                          center: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PrimaryText(
                                                vm.queue.length == 1
                                                    ? "${vm.queue[0]!.progress}%"
                                                    : (vm.completed / vm.queue.length).isNaN
                                                        ? "0%"
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
                                                      "Downloaded ${vm.queue.length}" +
                                                          "${vm.queue.length == 1 ? " File " : " Files "}",
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600,
                                                    )
                                                  : PrimaryText(
                                                      "Downloading ${vm.queue.length}" +
                                                          "${vm.queue.length == 1 ? " File " : " Files "}",
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
                                            if (mime(vm.queue[index]!.name)!.split('/').last ==
                                                "vnd.android.package-archive") {
                                              type = "application";
                                            } else {
                                              type = 'document';
                                            }
                                          } else {
                                            type = mime(vm.queue[index]!.name)!.split('/').first;
                                          }
                                          String size =
                                              FileManagerUtilities.formatBytes(int.parse(vm.queue[index]!.size), 2);
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
                                                        vm.queue[index]!.name.split("/").last,
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
                                                vm.queue[index]!.progress == "100" ||
                                                        vm.queue[index]!.progress == "Exist already"
                                                    ? InkWell(
                                                        onTap: () async {
                                                          await OpenFile.open(vm.queue[index]!.path);
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
                                                          fontSize: 12,
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
