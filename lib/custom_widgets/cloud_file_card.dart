import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:quick_backup/custom_widgets/app_text_widget.dart';
import 'package:quick_backup/data/models/download_model.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';

import '../configurations/size_config.dart';
import '../constants/app_colors.dart';
import '../data/models/queue_model.dart';
import '../views/download/download_screen.dart';

Widget cloudFileCard({required context, icon, title, size, isSelected, required DownloadModel item}) {
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
                  onPressed: () {
                    print('menu is tapped.....');
                  },
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
                    // FocusedMenuItem(
                    //     trailingIcon: Icon(Icons.share,color: AppColors.kPrimaryColor,),
                    //     title: PrimaryText("Share",color: AppColors.kPrimaryColor,),
                    //     onPressed: () {}),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.more_vert),
                  ),
                ),

                // subtitle: Text('${app.packageName}'),
                // onTap: () {
                //   listitems[index].isSelected = !listitems[index].isSelected;
                //   setState(() {});
                //   if (listitems[index].isSelected) {
                //     print("Called if");
                //
                //     provider.selectedFiles.add(QueueModel(
                //       id: null,
                //       name: listitems[index].key.split('/').last,
                //       size: listitems[index].size,
                //       date: listitems[index].date,
                //       status: "pending",
                //       progress: "pending",
                //       key: listitems[index].key,
                //     ));
                //     provider.selectedFiles.forEach((element) {
                //       print(element.name);
                //     });
                //   } else {
                //     print("Called else");
                //     provider.removeFromSelectedList = QueueModel(
                //       id: null,
                //       name: listitems[index].key.split('/').last,
                //       size: listitems[index].size,
                //       date: listitems[index].date,
                //       status: "pending",
                //       progress: "pending",
                //       key: listitems[index].key,
                //     );
                //   }
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
                // },
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
