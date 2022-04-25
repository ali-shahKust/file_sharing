import 'package:flutter/material.dart';
import 'package:flutter_icons_nullsafty/flutter_icons_nullsafty.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/constants/app_strings.dart';
import 'package:quick_backup/constants/app_style.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/custom_widgets/upload_screen.dart';
import 'package:quick_backup/data/models/file_model.dart';
import 'package:quick_backup/utilities/file_manager_utilities.dart';
import 'package:quick_backup/utilities/general_utilities.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';

class CustomDocumentListTile extends StatelessWidget {
  final type;
  final List<FileMangerModel> list;

  const CustomDocumentListTile({
    Key? key,
    required this.type,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryVm>(context, listen: false);
    print('Length of the file is ${list.length}');
    return list.length == 0
        ? GeneralUtilities.noDataFound()
        : Stack(
            children: [
              ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 10),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  final fileModel = list[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth! * 0.015, vertical: SizeConfig.screenHeight! * 0.014),
                    child: InkWell(
                      onTap: () {
                        provider.changeIsSelected(index, list);
                        if (fileModel.isSelected) {
                          provider.addToSelectedList = fileModel.file;
                        } else {
                          provider.removeFromSelectedList = fileModel.file;
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.032),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.04, 0.4],
                                  colors: [
                                    type == AppConstants.docCategories[0]
                                        ? AppConstants.documnetCategories[0]['startColor']
                                        : type == AppConstants.docCategories[1]
                                            ? AppConstants.documnetCategories[1]['startColor']
                                            : type == AppConstants.docCategories[2]
                                                ? AppConstants.documnetCategories[2]['startColor']
                                                : AppConstants.documnetCategories[3]['startColor'],
                                    type == AppConstants.docCategories[0]
                                        ? AppConstants.documnetCategories[0]['endColor']
                                        : type == AppConstants.docCategories[1]
                                            ? AppConstants.documnetCategories[1]['endColor']
                                            : type == AppConstants.docCategories[2]
                                                ? AppConstants.documnetCategories[2]['endColor']
                                                : AppConstants.documnetCategories[3]['endColor'],
                                  ],
                                ),
                              ),
                              height: SizeConfig.screenHeight! * 0.1,
                              width: SizeConfig.screenWidth! * 0.2,
                              // fixed width and height
                              // SizeConfig.screenHeight!*0.05
                              child: FileManagerUtilities.getLogoFromExtension(type)),
                          Expanded(
                            flex: 14,
                            child: Padding(
                              padding: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.05),
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${fileModel.file.path.split('/').last}',
                                      style: TextStyle(
                                          color: AppColors.kBlackColor,
                                          fontSize: SizeConfig.screenHeight! * 0.02,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.screenHeight! * 0.012,
                                    ),
                                    RichText(
                                      textScaleFactor: 1.2,
                                      text: TextSpan(
                                        style: DefaultTextStyle.of(context).style,
                                        children: [
                                          TextSpan(
                                              text:
                                                  '${FileManagerUtilities.formatBytes(fileModel.file.lengthSync(), 3)}',
                                              style: TextStyle(color: AppColors.kGreyColor)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          fileModel.isSelected
                              ? Container(
                                  height: SizeConfig.screenHeight! * 0.1,
                                  width: SizeConfig.screenWidth! * 0.06,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryPurpleColor),
                                  child: Icon(
                                    Icons.check,
                                    size: SizeConfig.screenHeight! * 0.02,
                                    color: Colors.white,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return CustomDivider();
                },
              ),
              Visibility(
                visible: provider.selectedFiles.length > 0 ? true : false,
                child: Positioned(
                  bottom: SizeConfig.screenHeight! * 0.012,
                  left: SizeConfig.screenWidth! * 0.005,
                  right: SizeConfig.screenWidth! * 0.005,
                  child: BackupButton(
                    text: '${AppStrings.backup}',
                    width: SizeConfig.screenWidth! * 0.58,
                    onTap: () async {
                      //  pd.show(max: 100, msg: 'File Uploading...');
                      if (provider.selectedFiles.length > 0) {
                        Navigator.pushNamed(context, UploadingScreen.routeName, arguments: {'files': provider.selectedFiles, "drawer": false})
                            .whenComplete(() {
                          print('whencomplete call...');
                          // provider.selectedFiles.clear();
                          // provider.clearAllSelectedLists();

                        });
                      }
                    },
                    btnColor: AppColors.kGreyColor,
                    padding: SizeConfig.screenHeight! * 0.02,
                  ),
                ),
              ),
            ],
          );

    // return Padding(
    //   padding:
    //       EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.015, vertical: SizeConfig.screenHeight! * 0.014),
    //   child: InkWell(
    //     onTap: onTap,
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Container(
    //             padding: EdgeInsets.all(SizeConfig.screenHeight! * 0.032),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(20),
    //               gradient: LinearGradient(
    //                 begin: Alignment.topLeft,
    //                 end: Alignment.bottomRight,
    //                 stops: [0.04, 0.4],
    //                 colors: [
    //                   type == AppConstants.docCategories[0]
    //                       ? AppConstants.documnetCategories[0]['startColor']
    //                       : type == AppConstants.docCategories[1]
    //                           ? AppConstants.documnetCategories[1]['startColor']
    //                           : type == AppConstants.docCategories[2]
    //                               ? AppConstants.documnetCategories[2]['startColor']
    //                               : AppConstants.documnetCategories[3]['startColor'],
    //                   type == AppConstants.docCategories[0]
    //                       ? AppConstants.documnetCategories[0]['endColor']
    //                       : type == AppConstants.docCategories[1]
    //                           ? AppConstants.documnetCategories[1]['endColor']
    //                           : type == AppConstants.docCategories[2]
    //                               ? AppConstants.documnetCategories[2]['endColor']
    //                               : AppConstants.documnetCategories[3]['endColor'],
    //                 ],
    //               ),
    //             ),
    //             height: SizeConfig.screenHeight! * 0.1,
    //             width: SizeConfig.screenWidth! * 0.2,
    //             // fixed width and height
    //             // SizeConfig.screenHeight!*0.05
    //             child: FileManagerUtilities.getLogoFromExtension(type)),
    //         // child: SvgPicture.asset(
    //         //   leadingIcon,
    //         //   // height: 70,
    //         //   // width: 20,
    //         //   fit: BoxFit.contain,
    //         // )),
    //         // CircleAvatar(
    //         //   radius: 20,
    //         //   backgroundImage: AssetImage('assets/avatar1.jpg'),
    //         // ),
    //         Expanded(
    //           flex: 14,
    //           child: Padding(
    //             padding: EdgeInsets.only(left: SizeConfig.screenWidth! * 0.05),
    //             child: Container(
    //               color: Colors.transparent,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: <Widget>[
    //                   Text(
    //                     title,
    //                     style: TextStyle(
    //                         color: AppColors.kBlackColor,
    //                         fontSize: SizeConfig.screenHeight! * 0.02,
    //                         fontWeight: FontWeight.normal),
    //                   ),
    //                   SizedBox(
    //                     height: SizeConfig.screenHeight! * 0.012,
    //                   ),
    //                   RichText(
    //                     textScaleFactor: 1.2,
    //                     text: TextSpan(
    //                       style: DefaultTextStyle.of(context).style,
    //                       children: [
    //                         TextSpan(text: subtitleFileLenght + "   ", style: TextStyle(color: AppColors.kGreyColor)),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         isSelected
    //             ? Expanded(flex: 1, child: SvgPicture.asset('assets/file_manager_assets/filemanager_home_forward.svg'))
    //             : SizedBox(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
