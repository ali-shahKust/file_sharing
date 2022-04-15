import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/configurations/size_config.dart';
import 'package:quick_backup/constants/app_constants.dart';
import 'package:quick_backup/custom_widgets/file_manager_custom_widgets/custom_divider.dart';
import 'package:quick_backup/views/device_file_manager/category/audio_view.dart';
import 'package:quick_backup/views/device_file_manager/category/category_vm.dart';
import 'package:quick_backup/views/device_file_manager/category/files_view.dart';
import 'package:quick_backup/views/device_file_manager/category/images_view.dart';
import 'package:quick_backup/views/device_file_manager/category/videos_view.dart';

class FileManagerHome extends StatefulWidget {
  static const routeName = 'device_file_manager';

  @override
  _FileManagerHomeState createState() => _FileManagerHomeState();
}

class _FileManagerHomeState extends State<FileManagerHome> {
  // late PageController _pageController;
  // int _page = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        children: <Widget>[
          SizedBox(height: SizeConfig.screenHeight! * 0.04),
          Row(
            children: [],
          ),
          _CategoriesSection(),
          // CustomDivider(),
          SizedBox(height: SizeConfig.screenHeight! * 0.03),

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
      Provider.of<CategoryVm>(context, listen: false).getDeviceFileManager();
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
              print(
                  'image list in function is testing ${Provider.of<CategoryVm>(context, listen: false).imageList.length}');

              Navigator.pushNamed(context, ImagesView.routeName);
            } else if (index == 1) {
              Navigator.pushNamed(context, VideosView.routeName);
            } else if (index == 2) {
              Navigator.pushNamed(context, AudioViews.routeName);
            } else if (index == 3) {
              Navigator.pushNamed(context, FileViews.routeName);
            }
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
