import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../provider/FileManagerProvider/category_provider.dart';
import 'components/images.dart';


class FileManagerHome extends StatefulWidget {
  static const routeName = 'file_manager';

  @override
  _FileManagerHomeState createState() => _FileManagerHomeState();
}

class _FileManagerHomeState extends State<FileManagerHome> with SingleTickerProviderStateMixin {
  // static const adUnitID = "ca-app-pub-7758351380904501/7575413471";
  // static const adUnitIDTest = "ca-app-pub-3940256099942544/2247696110";
  int _selectedIndex = 0;

  // final _nativeAdController = NativeAdmobController();
  static List<Widget> _pages = <Widget>[
    // AppPicker(),
    Images(title: 'Images'),
    Images(title: 'Images'),
    Images(title: 'Images'),
    Images(title: 'Images'),
    Images(title: 'Images'),
    // ImagesPicker(title: 'Images'),
    // ImagesPicker(title: 'Images'),
    // ImagesPicker(title: 'Images'),
    // ImagesPicker(title: 'Images'),
    // ImagesPicker(title: 'Images'),
    // VideosPicker(title: 'Videos'),
    // FilePicker(title: 'Files'),
    // AudioPicker(title: 'Audio'),
  ];

  // List appfiles = [];
  // List photosfiles = [];
  // List videosfile = [];
  // List files = [];
  // List giffiles = [];
  // Future<bool> checkInternetConnection() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     print("I am connected to a mobile network.");
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     print("I am connected to a mobile network.");
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.none) {
  //     print("I am not connected");
  //     return null;
  //   } else
  //     return null;
  // }
  // void getThumbNail(final filepath) async {
  //    final thumbnail = await VideoThumbnail.thumbnailData(
  //      video: filepath,
  //      imageFormat: ImageFormat.PNG,
  //      maxWidth: 100,
  //      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
  //      quality: 25,
  //    );
  //    print('thumnail is $thumbnail');
  //
  //    //   videoThumbNail = thumbnail;
  //    // });
  //  }
  @override
  void initState() {
    // globals.showAds ? myInterstitial.load() : null;
    // TODO: implement initState
    // populateList();
    // checkStorageStatus();
    // checkVersion();
    // permissionHandler();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).getDeviceFileManager();
    });
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //     Provider.of<CoreProvider>(context, listen: false).checkSpace();
    //   });

    super.initState();
  }

  // checkStorageStatus() async {
  //   PermissionStatus status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     requestPermission();
  //   } else {
  //     print('permission already granted');
  //   }
  // }
  // requestPermission() async {
  //   PermissionStatus status = await Permission.storage.request();
  //   if (status.isGranted) {
  //    print('storage permission granted');
  //   } else {
  //     print('storage permission not allowed');
  //   }
  // }
//
//   void _onItemTapped(int index) async {
//     if (await ShareFilesUtils.checkInternetConnection() != null) {
//   print('I am tapped on: $index');
//   setState(() {
//   _selectedIndex = index;
//   });
//   } else {
//   Toast.show(
//   " Please check your internet connection",
//   context,
//   duration: 2,
//   gravity: Toast.BOTTOM,
//   );
//   }
// }
  late String osVersion;

  // var permissionStatus;
  void checkVersion() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      // var release = androidInfo.version.release;
      osVersion = androidInfo.version.release;
      // var sdkInt = androidInfo.version.sdkInt;
      // var manufacturer = androidInfo.manufacturer;
      // var model = androidInfo.model;
      // print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    }
  }
void permissionHandler() async {
  // checkVersion();
  PermissionStatus status = osVersion == '11'
      ? await Permission.manageExternalStorage.status
      : await Permission.storage.status;
  print('storage permission status is ${status.index}');
  if (!status.isGranted) {
    if (osVersion == '11') {
      status = await Permission.manageExternalStorage.status;
    } else {
      status = await Permission.storage.status;
    }
    // PermissionStatus status = osVersion == '11'? await Permission.manageExternalStorage.status:Permission.storage.status;
    print('manage external storage permission status is ...$status');
    if (status.isGranted) {
      // Dialogs.showToast('Permission granted...');
      // Navigator.push(
      //     parentContext, MaterialPageRoute(builder: (parentContext) => NewFileManager()));
    } else if (status.isDenied) {
      PermissionStatus status = osVersion == '11'
          ? await Permission.manageExternalStorage.request()
          : await Permission.storage.request();
      print(
          'manage external storage permission status in denied condition is ...$status');
      // Dialogs.showToast('Please Grant Storage Permissions');
      // PermissionStatus status = await Permission.manageExternalStorage.request();
    } else if (status.isRestricted) {
      // AppSettings.openAppSettings();
      print('Restricted permission call');
      PermissionStatus status = osVersion == '11'
          ? await Permission.manageExternalStorage.request()
          : await Permission.storage.request();
      print(
          'manage external storage permission status in restricted condition is ...$status');
      // Dialogs.showToast('Please Grant Storage Permissions');
      // PermissionStatus status = await Permission.manageExternalStorage.request();
    } else {
      print('else condition permission call');
      PermissionStatus status = osVersion == '11'
          ? await Permission.manageExternalStorage.request()
          : await Permission.storage.request();

      print(
          'manage external storage permission status in denied condition is ...$status');
      // Dialogs.showToast('Please Grant Storage Permissions');
    }
  }
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer(builder: (BuildContext context, CategoryProvider provider, Widget ?child) {
      print('length of the list is ...${provider.imageList.length}');
      if (provider.loading) {
        return Scaffold(
          body: Center(
            child: Container(
              color: Colors.transparent,
              // width: MediaQuery.of(context).size.width /2 ,
              // height: MediaQuery.of(context).size.height / 2,
              child: Image.asset("assets/gifs/loader.gif",
                  height: MediaQuery.of(context).size.height * 0.4, width: MediaQuery.of(context).size.width * 0.4),
            ),
          ),
        );
      }

      return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              'Send Files',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 5.0),
            //     child: IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         Icons.search,
            //         size: 30,
            //       ),
            //     ),
            //   )
            // ],
            backgroundColor: Colors.white,
          ),
          backgroundColor: AppColors.kWhiteColor,
          body: Container(
            child: Stack(
              children: [
                Container(child: _pages[_selectedIndex]),
                // Visibility(
                //   visible: provider.selectedFiles.length > 0 ? true : false,
                //   child: Positioned(
                //     bottom: 12,
                //     left: 50,
                //     right: 50,
                //     child: ShareButton(
                //       text: 'Share Files  ( ${provider.selectedFiles.length} )',
                //       width: size.width * 0.58,
                //       onTap: () async {
                //         //  pd.show(max: 100, msg: 'File Uploading...');
                //         if (provider.selectedFiles.length > 0) {
                //           if (kReleaseMode) {
                //             // globals.showAds ? myInterstitial.show() : myInterstitial.dispose();
                //           }
                //           print('Button pressed.');
                //           if (provider.selectedFiles.length == 1) {
                //             // ProgressDialog pDialoge = ProgressDialog(context: context);
                //             // pDialoge.show(
                //             //   max: 100,
                //             //   msg: 'Getting File Ready',
                //             //   // backgroundColor: kWhiteColor.withOpacity(0.5),
                //             //   // elevation: 2.0,
                //             // );
                //             File file = File(provider.selectedFiles.first.path);
                //             String path = file.path;
                //             // String name = provider.selectedFiles[0].path.split('/').last;
                //             print('path of the file is $path');
                //             print('file is of the file is $file');
                //             // uploadFile(context,
                //             //     currentContext: globals.globalContext,
                //             //     path: path,
                //             //     file1: file,
                //             //     sizeDem: 0,
                //             //     isReshare: false,
                //             //     pDialoge: pDialoge);
                //             provider.selectedFiles.clear();
                //             provider.clearAllSelectedLists();
                //           } else {
                //             // print('i am going to zip the file...');
                //             // // ProgressDialog pDialoge = ProgressDialog(context: context);
                //             // // pDialoge.show(
                //             // //   max: 100,
                //             // //   msg: 'Getting File Ready',
                //             // //   // backgroundColor: kWhiteColor.withOpacity(0.5),
                //             // //   // elevation: 2.0,
                //             // // );
                //             // // var pathDown =
                //             // //     await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                //             //
                //             // // print(gernate(5));
                //             // //   print(new DateTime.now().millisecondsSinceEpoch);
                //             // // print(generateRandomString(5));
                //             // int fileName = DateTime.now().millisecondsSinceEpoch;
                //             // // String zipPath = appDocDirectory.path + "/" + '$fileName.zip';
                //             // String zipPath = pathDown + "/" + '$fileName.zip';
                //             // print('path in the device is....$zipPath');
                //             // var encoder = ZipFileEncoder();
                //             // encoder.create(zipPath);
                //             //
                //             // provider.selectedFiles.forEach((element) {
                //             //   print('all the files in the list are...${element.path.split('/').last.toString()}');
                //             //   encoder.addFile(File(element.path));
                //             // });
                //             // print('zip path is...${encoder.zip_path}');
                //             // File zipFile = File(encoder.zip_path);
                //             // encoder.close();
                //             // uploadFile(context,
                //             //     currentContext: globals.globalContext,
                //             //     path: zipPath,
                //             //     file1: zipFile,
                //             //     sizeDem: 1,
                //             //     isReshare: false,
                //             //     pDialoge: pDialoge);
                //             //
                //             // provider.selectedFiles.clear();
                //             // provider.clearAllSelectedLists();
                //           }
                //         } else {
                //           // Toast.show('No file Selected', context);
                //         }
                //       },
                //     ),
                //     // Container(
                //     //   padding: EdgeInsets.all(12),
                //     //   child: RaisedButton(
                //     //     color: Colors.blue,
                //     //     child: Text(
                //     //       "Selected Files ${provider.selectedFiles.length}",
                //     //       style: TextStyle(color: Colors.white,fontSize: 18),
                //     //     ),
                //     //     onPressed: () async {
                //     //       if(provider.selectedFiles.length==1){
                //     //         File file = File(provider.selectedFiles[0].path);
                //     //         String path = file.path;
                //     //         // String name = provider.selectedFiles[0].path.split('/').last;
                //     //         print('path of the file is $path');
                //     //         print('file is of the file is $file');
                //     //         uploadFile(context, currentContext: globals.globalContext, path:path , file1:file , sizeDem: 0);
                //     //         provider.selectedFiles.clear();
                //     //       }
                //     //       else{
                //     //         Directory appDocDirectory = await getExternalStorageDirectory();
                //     //         // print(gernate(5));
                //     //         //   print(new DateTime.now().millisecondsSinceEpoch);
                //     //         // print(generateRandomString(5));
                //     //         int fileName = DateTime.now().millisecondsSinceEpoch;
                //     //         String zipPath = appDocDirectory.path + "/" + '$fileName.zip';
                //     //         print('path in the device is....$zipPath');
                //     //         var encoder = ZipFileEncoder();
                //     //         encoder.create(zipPath);
                //     //
                //     //         provider.selectedFiles.forEach((element) {
                //     //           print('all the files in the list are...${element.path.split('/').last.toString()}');
                //     //           encoder.addFile(File(element.path));
                //     //         });
                //     //         print('zip path is...${encoder.zip_path}');
                //     //         File zipFile = File(encoder.zip_path);
                //     //         uploadFile(context, currentContext: globals.globalContext, path: zipPath, file1: zipFile, sizeDem: 1);
                //     //         encoder.close();
                //     //         provider.selectedFiles.clear();
                //     //       }
                //     //
                //     //     },
                //     //   ),
                //     // ),
                //   ),
                // ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
              // height: size.height*0.095,
              height: MediaQuery.of(context).size.height * 0.1,
              // margin: EdgeInsets.symmetric(horizontal: 10, ),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(0)),
              //   boxShadow: [
              //     BoxShadow(color: Colors.grey[300], spreadRadius: 0.0, blurRadius: 10),
              //   ],
              // ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                // onTap: _onItemTapped,
                // selectedFontSize: 15,
                // unselectedFontSize: 12,
                // unselectedIconTheme: IconThemeData(size: 25,color: Colors.grey),
                // selectedIconTheme: IconThemeData(color: kBlackColor, size: 30),
                selectedItemColor: AppColors.kPrimaryLightBlackColor,
                unselectedLabelStyle: TextStyle(
                  fontFamily: "Product_Sans",
                ),
                // selectedLabelStyle: TextStyle(
                //   fontFamily: "Product_Sans",
                // ),
                // unselectedLabelStyle : TextStyle(fontWeight: FontWeight.w700, color:kBlackColor,fontFamily: 'Product_Sans'),
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.w700, color: AppColors.kBlueColor, fontFamily: 'Product_Sans'),
                selectedFontSize: size.width * 0.04,
                unselectedFontSize: size.width * 0.04,
                // selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700,fontFamily: 'Product_Sans'),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.share_rounded),
                    // label: 'Shared',
                    icon: Padding(
                      padding:  EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_apps_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_apps_icon.svg",
                        height: size.height * 0.03,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    label: AppStrings.navItemCategories[0],
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_photo_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,

                        // width: screenWidth*0.6,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_photo_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    // label: 'Received',
                    // icon:
                    label: AppStrings.navItemCategories[1],
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.person),
                    // label: 'Profile',
                    icon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_video_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_video_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    label: AppStrings.navItemCategories[2],
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.person),
                    // label: 'Profile',
                    icon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_files_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_files_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    label: AppStrings.navItemCategories[3],
                  ),
                  BottomNavigationBarItem(
                    // icon: Icon(Icons.person),
                    // label: 'Profile',
                    icon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanger_nav_audio_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/file_manager_assets/filemanager_nav_audio_icon.svg",
                        height: size.height * 0.03,
                        color: AppColors.kGreyColor,
                        // width: screenWidth*0.6,
                      ),
                    ),
                     label: AppStrings.navItemCategories[4],
                  ),
                  // BottomNavigationBarItem(
                  // icon: Icon(Icons.share_rounded),
                  // label: navItemCategories[0],
                  // ),
                  // BottomNavigationBarItem(
                  // icon: Icon(Icons.history_rounded),
                  // label:  navItemCategories[1],
                  // ),
                  // BottomNavigationBarItem(
                  // icon: Icon(Icons.person),
                  // label:  navItemCategories[2],
                  // ),
                  // BottomNavigationBarItem(
                  // icon: Icon(Icons.download_for_offline ),
                  // label:  navItemCategories[3],
                  // ),
                  //   BottomNavigationBarItem(
                  //     icon: Icon(Icons.download_for_offline ),
                  //     label: navItemCategories[4],
                  //   ),
                ],
              )));
    });
  }
}

// void populateList() async {
//   if (await Permission.storage.isDenied) {
//     var storagePermissionStatus = await Permission.storage.request();
//     print('I am status: $storagePermissionStatus');
//     if (storagePermissionStatus.isGranted) {
//       getFiles();
//     } else if (storagePermissionStatus.isRestricted) {
//       print('Permission Restricted!!!');
//
//       await AppSettings.openAppSettings();
//     } else {
//       print('Permission Denied!!!!!!!!!');
//       await AppSettings.openAppSettings();
//     }
//   } else if (await Permission.storage.isRestricted) {
//     print('Permission Restricted!!!');
//     await AppSettings.openAppSettings();
//   } else if (await Permission.storage.isGranted) {
//     getFiles();
//   } else {
//     print('ERRORR!!!!!!!!');
//   }
// }
//    void getFiles() async {
//
//       final fileProvider = Provider.of<FileProvider>(context, listen: false);
//       List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
//       var root = storageInfo[0]
//           .rootDir; //storageInfo[1] for SD card, geting the root directory
//       var fm = FileManager(root: Directory(root)); //
//       appfiles = await fm.filesTree(
//         // excludedPaths: ["/storage/emulated/0/Android"],
//           sortedBy: FileManagerSorting.Date,
//           extensions: ['apk'] //optional, to filter files, list only pdf files
//       );
//       for (int i = 0; i < appfiles.length; i++) {
//         File file = File(appfiles[i].path);
//         String path = (file.path.toString());
//         String fileSize = file.lastModified().toString();
//
//         fileProvider.addtoApplist(
//             appfiles[i].path
//                 .split('/')
//                 .last, path, categories[0], false);
//         print('files data in the list is populate  ${appfiles[i]}');
//       }
//       photosfiles = await fm.filesTree(
//           excludedPaths: ["/storage/emulated/0/Android"],
//           sortedBy: FileManagerSorting.Date,
//           extensions: [
//             'png',
//             'jpg',
//             'jpeg'
//           ] //optional, to filter files, list only pdf files
//       );
//       for (int i = 0; i < photosfiles.length; i++) {
//         File file = File(photosfiles[i].path);
//         String path = (file.path.toString());
//         fileProvider.addtoPhotolist(
//             photosfiles[i].path
//                 .split('/')
//                 .last, path, categories[0], false);
//         print('files data in the list is  ${photosfiles[i]}');
//       }
//       videosfile = await fm.filesTree(
//           excludedPaths: ["/storage/emulated/0/Android"],
//           sortedBy: FileManagerSorting.Date,
//           extensions: [
//             "mp4",
//             "mov",
//             " wmv"
//           ] //optional, to filter files, list only pdf files
//       );
//       for (int i = 0; i < videosfile.length; i++) {
//         File file = File(videosfile[i].path);
//         String path = (file.path.toString());
//         final thumbnail = await VideoThumbnail.thumbnailData(
//           video: path,
//           imageFormat: ImageFormat.PNG,
//           maxWidth: 100,
//           // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
//           quality: 25,
//         );
//         print('thumnail of the video is $thumbnail');
//         fileProvider.addtoVideoslist(
//             videosfile[i].path
//                 .split('/')
//                 .last, path, categories[0], false, thumbnail);
//         print('files data in the list is  ${videosfile[i]}');
//       }
//       files = await fm.filesTree(
//           excludedPaths: ["/storage/emulated/0/Android"],
//           sortedBy: FileManagerSorting.Date,
//           extensions: [
//             "doc",
//             "docx",
//             "pdf",
//             "odt",
//             "ppt",
//             "pptx"
//           ] //optional, to filter files, list only pdf files
//       );
//       for (int i = 0; i < files.length; i++) {
//         File file = File(files[i].path);
//         String path = (file.path.toString());
//         fileProvider.addtoFileslist(
//             files[i].path
//                 .split('/')
//                 .last, path, categories[0], false);
//         print('files data in the list is  ${files[i]}');
//       }
//       giffiles = await fm.filesTree(
//           excludedPaths: ["/storage/emulated/0/Android"],
//           sortedBy: FileManagerSorting.Date,
//           extensions: ['gif'] //optional, to filter files, list only pdf files
//       );
//       for (int i = 0; i < giffiles.length; i++) {
//         File file = File(giffiles[i].path);
//         String path = (file.path.toString());
//         fileProvider.addtoGiflist(
//             giffiles[i].path
//                 .split('/')
//                 .last, path, categories[0], false);
//         print('files data in the list is  ${giffiles[i]}');
//       }
//
//
//       setState(() {}); //update the UI
//       // }
//     }
//   }
// }
