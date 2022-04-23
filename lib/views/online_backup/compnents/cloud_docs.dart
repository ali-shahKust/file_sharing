import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_colors.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/cloud_file_card.dart';
import 'package:quick_backup/custom_widgets/custom_backup_button.dart';
import 'package:quick_backup/views/download/download_screen.dart';
import 'package:quick_backup/views/online_backup/online_backup_vm.dart';
import '../../../custom_widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class CloudDocs extends StatefulWidget {
  static const routeName = 'cloud_docs';

  @override
  State<CloudDocs> createState() => _CloudDocsState();
}

class _CloudDocsState extends State<CloudDocs> {
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
                          "Documents",
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
                          onPressed: () {
                            provider.isAllDocSelected =
                                !provider.isAllDocSelected;
                            !provider.isAllDocSelected
                                ? provider.unselectAllInList(provider.documents)
                                : provider.selectAllInList(provider.documents);
                          },
                          icon: Icon(
                            provider.isAllDocSelected
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
                            itemCount: provider.documents.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return InkWell(
                                onTap: () {
                                  provider.documents[index].isSelected =
                                      !provider.documents[index].isSelected;
                                  if (provider.documents[index].isSelected) {
                                    print("Called if");
                                    provider.addToSelectedList =
                                        provider.documents[index];
                                  } else {
                                    print("Called else");
                                    provider.removeFromSelectedList =
                                        provider.documents[index];
                                  }
                                },
                                child: cloudFileCard(
                                    context: context,
                                    size: provider.documents[index].size,
                                    title: provider.documents[index].key,
                                    icon: AppConstants.document_icon,
                                    item: provider.documents[index],
                                    isSelected:
                                        provider.documents[index].isSelected),
                              );
                            },
                            // separatorBuilder: (BuildContext context, int index) {
                            //   return CustomDivider();
                            // },
                          ),
                          Visibility(
                            visible: provider.selectedFiles.length > 0
                                ? true
                                : false,
                            child: Positioned(
                              bottom: SizeConfig.screenHeight! * 0.012,
                              left: SizeConfig.screenWidth! * 0.005,
                              right: SizeConfig.screenWidth! * 0.005,
                              child: BackupButton(
                                text: 'Recover Now',
                                width: SizeConfig.screenWidth! * 0.58,
                                onTap: () async {
                                  //  pd.show(max: 100, msg: 'File Uploading...');
                                  if (provider.selectedFiles.length > 0) {
                                    Navigator.pushNamed(
                                        context, DownloadScreen.routeName,
                                        arguments: provider.selectedFiles);
                                  }
                                },
                                btnColor: AppColors.kGreyColor,
                                padding: SizeConfig.screenHeight! * 0.02,
                              ),
                            ),
                          ),
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
}
