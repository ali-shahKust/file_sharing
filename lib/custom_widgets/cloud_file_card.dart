import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/constants/app_strings.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/data/models/download_model.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_apps.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_audios.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_docs.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_images.dart';
import 'package:quick_backup/views/online_backup/compnents/cloud_videos.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';

import '../configurations/size_config.dart';
import '../constants/app_colors.dart';
import '../data/models/queue_model.dart';
import '../views/download/download_screen.dart';

Widget cloudFileCard({required context, icon, title, size, isSelected,type, required DownloadModel item,}) {
  return Container(
    height: SizeConfig.screenHeight! * 0.13,
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
                    icon,
                    height: SizeConfig.screenHeight! * 0.022,
                  ),
                ),
                title: PrimaryText(
                  '${title.split('/').last}',
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    FileManagerUtilities.formatBytes(int.parse(size), 3),
                  ),
                ),
                trailing: FocusedMenuHolder(
                  menuWidth: SizeConfig.screenHeight! * 0.24,
                  blurSize: 0.3,
                  blurBackgroundColor: Colors.black54,
                  openWithTap: true,
                  menuOffset: 5.0,
                  bottomOffsetHeight: 60.0,
                  onPressed: () {},
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(
                        title: PrimaryText(
                          "Restore",
                          fontSize: SizeConfig.screenHeight! * 0.02,
                          color: AppColors.kPrimaryPurpleColor,
                        ),
                        trailingIcon: Icon(
                          Icons.restore_sharp,
                          color: AppColors.kPrimaryPurpleColor,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, DownloadScreen.routeName, arguments: <QueueModel>[
                            QueueModel(
                                key: item.key,
                                name: item.key,
                                size: item.size,
                                date: item.date,
                                status: "pending",
                                progress: "pending")
                          ]);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenTwo()));
                        }),
                    FocusedMenuItem(
                        trailingIcon: Icon(
                          Icons.delete,
                          color: AppColors.kPrimaryColor,
                        ),
                        title: PrimaryText(
                          "Delete",
                          color: AppColors.kPrimaryColor,
                        ),
                        onPressed: () {
                          EasyLoading.show(status: 'Deleting');
                          iUtills.deleteFile(item.key).whenComplete(() {
                            EasyLoading.dismiss();
                            if(type==AppStrings.cloudItemCategories[0]){
                              Provider.of<OnlineBackUpVm>(context,listen: false).images.remove(item);
                              Navigator.pushReplacementNamed(context, CloudImages.routeName, arguments: "Images");
                            }
                            if(type==AppStrings.cloudItemCategories[1]){
                              Provider.of<OnlineBackUpVm>(context,listen: false).videos.remove(item);
                              Navigator.pushReplacementNamed(context, CloudVideos.routeName, arguments: "Images");
                            }
                            if(type==AppStrings.cloudItemCategories[2]){
                              Provider.of<OnlineBackUpVm>(context,listen: false).audios.remove(item);
                              Navigator.pushReplacementNamed(context, CloudAudios.routeName, arguments: "Images");
                            }
                            if(type==AppStrings.cloudItemCategories[3]){
                              Provider.of<OnlineBackUpVm>(context,listen: false).documents.remove(item);
                              Navigator.pushReplacementNamed(context, CloudDocs.routeName, arguments: "Images");
                            }
                            if(type==AppStrings.cloudItemCategories[4]){
                              Provider.of<OnlineBackUpVm>(context,listen: false).apps.remove(item);
                              Navigator.pushReplacementNamed(context, CloudApps.routeName, arguments: "Images");
                            }


                          });
                          print('file to delete with key is ${item.key}');
                          // print('file to delete with url is ${item.url}');
                          print('Delete button pressed');
                        }),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.more_vert),
                  ),
                ),
              ),
            ),
          ),
        ),
        isSelected
            ? Positioned(
                top: SizeConfig.screenHeight! * -0.02,
                right: 0,
                child: Container(
                  height: SizeConfig.screenHeight! * 0.1,
                  width: SizeConfig.screenWidth! * 0.07,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryPurpleColor),
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
}
