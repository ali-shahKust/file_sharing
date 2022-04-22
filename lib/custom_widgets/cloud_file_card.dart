import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';

import '../configurations/size_config.dart';
import '../constants/app_colors.dart';

Widget cloudFileCard({icon,title,size,isSelected}){
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
                    icon,
                    height: SizeConfig.screenHeight! * 0.022,
                  ),
                ),
                title: Text('${title.split('/').last}'),
                subtitle: Text(
                  FileManagerUtilities.formatBytes(
                      int.parse(size), 3),
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
}