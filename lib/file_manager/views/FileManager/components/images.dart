import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glass_mor/file_manager/configurations/size_config.dart';
import 'package:glass_mor/file_manager/constants/app_colors.dart';
import 'package:glass_mor/file_manager/custom_widgets/file_manager_custom_widgets/custom_loader.dart';
import 'package:glass_mor/file_manager/models/file_model.dart';
import 'package:glass_mor/file_manager/provider/FileManagerProvider/category_provider.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';

class Images extends StatefulWidget {
  final String title;

  Images({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> with SingleTickerProviderStateMixin {
   // TabController? _tabController;
   // int _selectedIndex = 0;
  // @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   SizeConfig().init(context);
    return Consumer(
      builder: (BuildContext context, CategoryProvider provider, Widget? child) {
        print('all files list length is ${provider.imageList.length}');
        if (provider.loading) {
          return Scaffold(body: CustomLoader());
        }
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('${widget.title}'),
          //   bottom: TabBar(
          //     // controller: _tabController,
          //     indicatorColor: AppColors.kBlackColor,
          //     labelColor: AppColors.kBlackColor,
          //     unselectedLabelColor: AppColors.kWhiteColor,
          //     isScrollable: provider.imageTabs.length < 3 ? false : true,
          //     tabs: AppConstants.map<Widget>(
          //       provider.imageTabs,
          //       (index, label) {
          //         return Tab(text: '$label');
          //       },
          //     ),
          //     onTap: (val) => provider.switchCurrentFiles(
          //         provider.imageList, provider.imageTabs[val]),
          //   ),
          // ),
          body:
              Column(
                children: [
                  Expanded(
                    flex: 6,

                    child:GridView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        reverse: false,
                        cacheExtent: 50,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                        ),
                      itemCount:provider.imageList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        FileMangerModel fmm = provider.imageList[index];
                        return _MediaTile(
                          imgmodel: fmm,
                          provider: provider,
                          index: index,
                          // file: item.file
                        );
                      }),

                  ),
                ],
              )
        //   CustomScrollView(
        //   primary: false,
        //   slivers: <Widget>[
        //     SliverPadding(
        //       padding: EdgeInsets.all(10.0),
        //       sliver: SliverGrid.count(
        //         crossAxisSpacing: 5.0,
        //         mainAxisSpacing: 5.0,
        //         crossAxisCount: 4,
        //         children: AppConstants.map(
        //           index == 0
        //               ? provider.imageList
        //               :  provider.currentFiles,
        //               (index, item) {
        //             // File file = File(item.path);
        //             // String path = file.path;
        //             // String mimeType = mime(item.path) ?? '';
        //             return _MediaTile(
        //               imgmodel: item,
        //               provider: provider,
        //               index: index,
        //               screenHeight: screenHeight,
        //               screenWidht: screenWidth,
        //               // file: item.file
        //             );
        //           },
        //         ),
        //       ),
        //     ),
        //   ],
        // )
        );
      },
    );
  }
}



class _MediaTile extends StatelessWidget {
  final FileMangerModel imgmodel;
  final CategoryProvider provider;
  final index;


  _MediaTile({required  this.imgmodel,required this.provider, this.index});

  @override
  Widget build(BuildContext context) {
    File file = File(imgmodel.file.path);
    String path = file.path;
    String mimeType = mime(path) ?? '';
    // if (imgmodel.imgBytes != null) {
    //   print('byte code of the image is...${imgmodel.imgBytes}');
    // }
    return InkWell(
      onTap: () {
        provider.changeIsSelected(index, provider.imageList);
        if (provider.imageList[index].isSelected) {
          provider.addToSelectedList = provider.imageList[index].file;
        } else {
          provider.removeFromSelectedList = provider.imageList[index].file;
        }
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.screenHeight!*0.003),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                    Radius.circular(8))
            ),
            // height: screenHeight * 0.15  ,
            // width: screenWidht * 0.47,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(8)),
              child: Image.file(
                imgmodel.file,
                scale: 1.0,
                width: SizeConfig.screenHeight!*  0.3,
                fit: BoxFit.fill,
                cacheWidth: 100,
                cacheHeight: 110,
              ),
            ),

          ),
          Positioned(
            top: SizeConfig.screenHeight! * (-0.032),
            // left:50,
            // bottom: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: provider.imageList[index].isSelected
                  ? Container(
                height: SizeConfig.screenHeight!*  0.1,
                width: SizeConfig.screenWidth!* 0.07,
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.kBlueColor),
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.check,
                      size: SizeConfig.screenHeight!*  0.02,
                      color: Colors.white,
                    )),
              )
                  : SizedBox(
                height: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}