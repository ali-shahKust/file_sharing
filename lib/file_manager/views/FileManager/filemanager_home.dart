
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/category_provider.dart';
import 'package:glass_mor/file_manager/views/FileManager/components/browse.dart';
import 'package:provider/provider.dart';

class FileManagerHome extends StatefulWidget {
  static const routeName = 'file_manager';

  @override
  _FileManagerHomeState createState() => _FileManagerHomeState();
}

class _FileManagerHomeState extends State<FileManagerHome> {
  late PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Browse(),
          // Share(),
          // Settings(),
        ],
      ),

    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // Provider.of<CoreProvider>(context, listen: false).checkSpace();
      Provider.of<CategoryProvider>(context, listen: false).getDeviceFileManager();
      // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);


    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
