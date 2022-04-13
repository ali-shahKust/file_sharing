

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:glass_mor/file_manager/configurations/size_config.dart';
import 'package:glass_mor/file_manager/constants/app_constants.dart';
import 'package:glass_mor/file_manager/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/category_provider.dart';
import 'package:glass_mor/file_manager/views/file_manager_views/components/audio_picker.dart';
import 'package:glass_mor/file_manager/views/file_manager_views/components/files_picker.dart';
import 'package:glass_mor/file_manager/views/file_manager_views/components/images.dart';
import 'package:glass_mor/file_manager/views/file_manager_views/components/videos_picker.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:provider/provider.dart';

import 'components/browse.dart';

class FileManagerHome extends StatefulWidget {
  static const routeName = 'file_manager';
  @override
  _FileManagerHomeState createState() => _FileManagerHomeState();
}

class _FileManagerHomeState extends State<FileManagerHome> {
  // late PageController _pageController;
  // int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        children: <Widget>[
          SizedBox(height: getScreenHeight(context) * 0.04),
          Row(
            children: [],
          ),
          _CategoriesSection(),
          // CustomDivider(),
          SizedBox(height: getScreenHeight(context) * 0.03),

          // _SectionTitle('Recent Files'),
          // _RecentFiles(),
        ],
      ),
      // Browse(),
    );
  }

  // void navigationTapped(int page) {
  //   _pageController.jumpToPage(page);
  // }

  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: 0);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // Provider.of<CoreProvider>(context, listen: false).checkSpace();
      Provider.of<CategoryProvider>(context, listen: false).getDeviceFileManager();
      // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);


    });
  }

  @override
  void dispose() {
    super.dispose();
    // _pageController.dispose();
  }

  // void onPageChanged(int page) {
  //   setState(() {
  //     this._page = page;
  //   });
  // }
}
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
          onTap: () async {
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => Images(
                        title: '${category['title']}',
                        imageList: Provider.of<CategoryProvider>(context, listen: false).imageList,
                      )));
              // Navigate.pushPage(
              //     context, Downloads(title: '${category['title']}'));
            } else if (index == 1) {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideosPicker(
                        title: '',
                        videoList: Provider.of<CategoryProvider>(context, listen: false).videosList,
                      )));
              // }

              //   // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
              //
              //
              // });
              // EasyLoading.show(status: 'Loading....');

            } else if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AudioPicker(
                        title: '',
                      )));
            } else if (index == 3) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FilePicker(
                        title: '',
                      )));
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
