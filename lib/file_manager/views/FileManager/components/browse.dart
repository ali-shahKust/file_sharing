import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glass_mor/file_manager/configurations/size_config.dart';
import 'package:glass_mor/file_manager/constants/app_constants.dart';
import 'package:glass_mor/file_manager/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:glass_mor/file_manager/views/FileManager/components/audio_picker.dart';
import 'package:glass_mor/file_manager/views/FileManager/components/files_picker.dart';
import 'package:glass_mor/file_manager/views/FileManager/components/images.dart';
import 'package:glass_mor/file_manager/views/FileManager/components/videos_picker.dart';

import 'package:provider/provider.dart';

class Browse extends StatelessWidget {
  refresh(BuildContext context) async {
    // await Provider.of<CoreProvider>(context, listen: false).checkSpace();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          children: <Widget>[
            SizedBox(height: SizeConfig.screenHeight!*0.04),
             Row(
               children: [

               ],
             ),
            _CategoriesSection(),
            // CustomDivider(),
            SizedBox(height: SizeConfig.screenHeight!*0.03),

            // _SectionTitle('Recent Files'),
            // _RecentFiles(),
          ],
        ),
      ),
    );
  }
}

// class _SectionTitle extends StatelessWidget {
//   final String title;
//
//   _SectionTitle(this.title);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title.toUpperCase(),
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 12.0,
//       ),
//     );
//   }
// }

// class _StorageSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CoreProvider>(
//       builder: (BuildContext context, coreProvider, Widget? child) {
//         if (coreProvider.storageLoading) {
//           return Container(height: 100, child: CustomLoader());
//         }
//         return ListView.separated(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: coreProvider.availableStorage.length,
//           itemBuilder: (BuildContext context, int index) {
//             FileSystemEntity item = coreProvider.availableStorage[index];
//
//             String path = item.path.split('Android')[0];
//             double percent = 0;
//
//             if (index == 0) {
//               percent = calculatePercent(coreProvider.usedSpace, coreProvider.totalSpace);
//             } else {
//               percent = calculatePercent(coreProvider.usedSDSpace, coreProvider.totalSDSpace);
//             }
//             return StorageItemView(
//               percent: percent,
//               path: path,
//               title: index == 0 ? 'Device' : 'SD Card',
//               icon: index == 0 ? Icons.smartphone : Icons.sd_storage,
//               color: index == 0 ? Colors.lightBlue : Colors.orange,
//               usedSpace: index == 0 ? coreProvider.usedSpace : coreProvider.usedSDSpace,
//               totalSpace: index == 0 ? coreProvider.totalSpace : coreProvider.totalSDSpace,
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return CustomDivider();
//           },
//         );
//       },
//     );
//   }
//
//   calculatePercent(int usedSpace, int totalSpace) {
//     return double.parse((usedSpace / totalSpace * 100).toStringAsFixed(0)) / 100;
//   }
// }

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: AppConstants.categories.length,
      itemBuilder: (BuildContext context, int index) {
        Map category = AppConstants.categories[index];

        return ListTile(
          onTap: () async{
            // if (index == AppConstants.categories.length - 1) {
            //   // Check if the user has whatsapp installed
            //   if (Directory(FileUtils.waPath).existsSync()) {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => WhatsappStatus(title: '${category['title']}'),
            //         ));
            //   } else {
            //     GeneralUtilities.showToast('Please Install WhatsApp to use this feature');
            //   }
            // } else
              if (index == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Images(title: '${category['title']}')));
              // Navigate.pushPage(
              //     context, Downloads(title: '${category['title']}'));
            }
              else if(index==1)  {

                // SchedulerBinding.instance!.addPostFrameCallback((_) {
                //   // Provider.of<CoreProvider>(context, listen: false).checkSpace();
                // if(Provider.of<CategoryProvider>(context, listen: false).videosList.isEmpty){
                //   EasyLoading.show(status: 'loading...');
                //   print('I am in if condition...');
                //
                //   await   Provider.of<CategoryProvider>(context, listen: false).getVideos().whenComplete(() {
                //     EasyLoading.dismiss();
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => VideosPicker(title: '',)));
                //   });
                // }
                // else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideosPicker(title: '',)));
                // }

                //   // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                //
                //
                // });
                // EasyLoading.show(status: 'Loading....');


              }
              else if (index == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AudioPicker(title: '',)));
              }
              else if (index == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FilePicker(title: '',)));
              }
            // } else {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => index == 1 || index == 2
            //               ? Images(title: '${category['title']}')
            //               : Category(title: '${category['title']}')));
            // }
          },
          contentPadding: EdgeInsets.all(12),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Icon(category['icon'], size: 18, color: category['color']),
          ),
          title: Text('${category['title']}'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return CustomDivider();
      },
    );
  }
}

// class _RecentFiles extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CoreProvider>(
//       builder: (BuildContext context, coreProvider, Widget? child) {
//         if (coreProvider.recentLoading) {
//           return Container(height: 150, child: CustomLoader());
//         }
//         return ListView.separated(
//           padding: EdgeInsets.only(right: 20),
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: coreProvider.recentFiles.length > 5 ? 5 : coreProvider.recentFiles.length,
//           itemBuilder: (BuildContext context, int index) {
//             FileSystemEntity file = coreProvider.recentFiles[index];
//             return file.existsSync() ? FileItem(file: file) : SizedBox();
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return Container(
//               height: 1,
//               color: Theme.of(context).dividerColor,
//             );
//           },
//         );
//       },
//     );
//   }
// }
