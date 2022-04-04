// import 'dart:io';
// import 'package:file_sharing_app/Constants/constants.dart';
// import 'package:file_sharing_app/Utits/FileMangerUtils/consts.dart';
// import 'package:file_sharing_app/models/file_model.dart';
// import 'package:file_sharing_app/provider/FileManagerProvider/category_provider.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/custom_divider.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/custom_loader.dart';
// import 'package:file_sharing_app/src/CustomWidgets/FileManagerCWidgets/file_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:provider/provider.dart';
//
// class AudioPicker extends StatefulWidget {
//   final String title;
//
//   AudioPicker({
//     Key key,
//     this.title,
//   }) : super(key: key);
//
//   @override
//   _AudioPickerState createState() => _AudioPickerState();
// }
//
// class _AudioPickerState extends State<AudioPicker> {
//   @override
//   void initState() {
//     super.initState();
//     // SchedulerBinding.instance.addPostFrameCallback((_) {
//     //   Provider.of<CategoryProvider>(context, listen: false)
//     //           .getAudios();
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (BuildContext context, CategoryProvider provider, Widget child) {
//         final screenHeight = MediaQuery.of(context).size.height;
//         final screenWidth = MediaQuery.of(context).size.width;
//         if (provider.loading) {
//           return Scaffold(
//             body: Center(
//               child: Container(
//                 // width: MediaQuery.of(context).size.width /2 ,
//                 // height: MediaQuery.of(context).size.height / 2,
//                 child: Image.asset("assets/gifs/loader.gif",
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     width: MediaQuery.of(context).size.width * 0.4),
//               ),
//             ),
//           );
//         }
//         return Scaffold(
//           backgroundColor: Colors.white,
//           // appBar: AppBar(
//           //   elevation: 0.0,
//           //   iconTheme: IconThemeData(
//           //     color: Colors.black, //change your color here
//           //   ),
//           //   title: Text(
//           //     'Send Files',
//           //     style: TextStyle(
//           //       color: Colors.black,
//           //       fontSize: 20,
//           //       fontWeight: FontWeight.w700,
//           //     ),
//           //   ),
//           //   actions: [
//           //     Padding(
//           //       padding: const EdgeInsets.only(right: 5.0),
//           //       child: IconButton(
//           //         onPressed: () {},
//           //         icon: Icon(
//           //           Icons.search,
//           //           size: 30,
//           //         ),
//           //       ),
//           //     )
//           //   ],
//           //   backgroundColor: Colors.white,
//           // ),
//           //   bottom: TabBar(
//           //     indicatorColor: Theme.of(context).accentColor,
//           //     labelColor: Theme.of(context).accentColor,
//           //     unselectedLabelColor: Theme.of(context).textTheme.caption.color,
//           //     isScrollable: provider.imageTabs.length < 3 ? false : true,
//           //     tabs: Constants.map<Widget>(
//           //       provider.imageTabs,
//           //       (index, label) {
//           //         return Tab(text: '$label');
//           //       },
//           //     ),
//           //     onTap: (val) => provider.switchCurrentFiles(
//           //         provider.images, provider.imageTabs[val]),
//           //   ),
//           // ),
//           body: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     '${provider.audiosList.length} ${widget.title} ',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Visibility(
//                   visible: provider.audiosList.isNotEmpty,
//                   replacement: Center(child: Text('No Files Found')),
//                   child: Expanded(
//                     child: ListView.separated(
//                       padding: EdgeInsets.only(left: 10),
//                       itemCount: provider.audiosList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return ListTile(
//                           minVerticalPadding: 20,
//                           leading: Icon(
//                             Feather.music,
//                             color: Colors.orangeAccent,
//                           ),
//                           title: Text(
//                               '${provider.audiosList[index].file.path.split('/').last}'),
//                           trailing: provider.audiosList[index].isSelected
//                               ? Container(
//                             height: screenHeight * 0.1,
//                             width: screenWidth * 0.07,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: kSelectedIconColor),
//                             child: Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Icon(
//                                   Icons.check,
//                                   size: screenHeight * 0.02,
//                                   color: Colors.white,
//                                 )),
//                           )
//                               : SizedBox(
//                             height: 2.0,
//                           ),
//                           // trailing: Container(
//                           //   height: 30,
//                           //   width: 30,
//                           //   decoration: BoxDecoration(
//                           //       shape: BoxShape.circle,
//                           //       color: provider.audiosList[index].isSelected
//                           //           ? Colors.blue
//                           //           : Colors.black38),
//                           //   child: Padding(
//                           //     padding: const EdgeInsets.all(5.0),
//                           //     child: provider.audiosList[index].isSelected
//                           //         ? Icon(
//                           //             Icons.check,
//                           //             size: 20.0,
//                           //             color: Colors.white,
//                           //           )
//                           //         : Icon(
//                           //             Icons.check_box_outline_blank,
//                           //             size: 20.0,
//                           //             color: Colors.white,
//                           //           ),
//                           //   ),
//                           // ),
//                           // subtitle: Text('${app.packageName}'),
//                           onTap: (){
//
//                             provider.changeIsSelected(index,provider.audiosList);
//                             if (provider.audiosList[index].isSelected) {
//                               provider.addToSelectedList = provider.audiosList[index].file;
//                             } else {
//                               provider.removeFromSelectedList = provider.audiosList[index].file;
//                             }
//                           },
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return CustomDivider();
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
