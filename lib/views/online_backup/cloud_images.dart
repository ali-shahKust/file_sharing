import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/data/extension.dart';
import 'package:quick_backup/data/models/download_model.dart';
import 'package:quick_backup/data/models/queue_model.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';

import '../../custom_widgets/app_text_widget.dart';

class CloudImages extends StatefulWidget {
  static const routeName = 'cloud_backup_screen';
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
                          widget.title,
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
                          '${provider.selectedFiles.length} Selected',
                          style: TextStyle(
                              fontSize: SizeConfig.screenHeight! * 0.024,
                              color: AppColors.kWhiteColor),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth! * 0.3,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            provider.isAllAudioSelected
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
                            padding:
                                EdgeInsets.all(SizeConfig.screenHeight! * 0.02),
                            itemCount: widget.title == "Images"
                                ? provider.images.length
                                : widget.title == "Videos"
                                    ? provider.videos.length
                                    : widget.title == "Audios"
                                        ? provider.audios.length
                                        : widget.title == "Documents"
                                            ? provider.documents.length
                                            : widget.title == "Apps"
                                                ? provider.apps.length
                                                : 0,
                            itemBuilder: (BuildContext context, int index,) {
                              return ItemBuilder(context, index,  widget.title == "Images"
                                  ? provider.images:widget.title == "Videos"
                                  ? provider.videos: widget.title == "Audios"
                                  ? provider.audios:widget.title == "Documents"
                                  ? provider.documents: widget.title == "Apps"
                                  ? provider.apps:[], provider);
                            },
                            // separatorBuilder: (BuildContext context, int index) {
                            //   return CustomDivider();
                            // },
                          ),
                          // Visibility(
                          //   visible: provider.selectedFiles.length > 0 ? true : false,
                          //   child: Positioned(
                          //     bottom: SizeConfig.screenHeight! * 0.012,
                          //     left: SizeConfig.screenWidth! * 0.005,
                          //     right: SizeConfig.screenWidth! * 0.005,
                          //     child: BackupButton(
                          //       text: '${AppStrings.backup}',
                          //       width: SizeConfig.screenWidth! * 0.58,
                          //       onTap: () async {
                          //         //  pd.show(max: 100, msg: 'File Uploading...');
                          //         if (provider.selectedFiles.length > 0) {
                          //           Navigator.pushNamed(context, QuesScreen.routeName,
                          //               arguments: provider.selectedFiles)
                          //               .whenComplete(() {
                          //             print('whencomplete call...');
                          //             provider.selectedFiles.clear();
                          //             provider.clearAllSelectedLists();
                          //           });
                          //         }
                          //       },
                          //       btnColor: AppColors.kGreyColor,
                          //       padding: SizeConfig.screenHeight! * 0.02,
                          //     ),
                          //   ),
                          // ),
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

  Widget ItemBuilder(context, index ,List<DownloadModel> listitems,OnlineBackUpVm provider){
    return Container(
      height: SizeConfig.screenHeight! * 0.15,
      color: AppColors.kWhiteColor,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: SizeConfig.screenHeight! * 0.11,
              child: Card(
                color:
                AppColors.kListTileLightGreyColor,
                shape: RoundedRectangleBorder(
                  // side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius:
                  BorderRadius.circular(12),
                ),
                // margin: EdgeInsets.only(top: 10),
                elevation: 0.0,
                child: ListTile(
                  minVerticalPadding:
                  SizeConfig.screenHeight! *
                      0.035,
                  leading: CircleAvatar(
                    backgroundColor:
                    AppColors.kPrimaryPurpleColor,
                    child: SvgPicture.asset(
                      'assets/images/audio_icon.svg',
                      height:
                      SizeConfig.screenHeight! *
                          0.022,
                    ),
                  ),
                  title: Text(
                      '${listitems[index].key.split('/').last}'),
                  subtitle: Text(
                    FileManagerUtilities.formatBytes(
                        int.parse(listitems[index].size)
                            ,
                        3),
                  ),

                  // subtitle: Text('${app.packageName}'),
                  onTap: () {
                    listitems[index].isSelected = !listitems[index].isSelected;
                    if(listitems[index].isSelected){
                      provider.selectedFiles.add(QueueModel(name: listitems[index].key.split('/').last, size: listitems[index].size, date: listitems[index].date, status: "pending", progress: "pending"));
                    }else {
                      provider.selectedFiles.remove(QueueModel(name: listitems[index].key.split('/').last, size: listitems[index].size, date: listitems[index].date, status: "pending", progress: "pending"));
                    }
                    // provider.changeIsSelected(
                    //     index, provider.audiosList);
                    // if (provider.audiosList[index]
                    //     .isSelected) {
                    //   provider.addToSelectedList =
                    //       provider
                    //           .audiosList[index].file;
                    // } else {
                    //   provider.removeFromSelectedList =
                    //       provider
                    //           .audiosList[index].file;
                    // }
                  },
                ),
              ),
            ),
          ),
          listitems[index].isSelected
              ? Positioned(
            top: SizeConfig.screenHeight! *
                -0.02,
            right: 0,
            child: Container(
              height: SizeConfig.screenHeight! *
                  0.1,
              width: SizeConfig.screenWidth! *
                  0.07,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors
                      .kPrimaryPurpleColor),
              child: Padding(
                  padding:
                  const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.check,
                    size: SizeConfig
                        .screenHeight! *
                        0.02,
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
  }
}
