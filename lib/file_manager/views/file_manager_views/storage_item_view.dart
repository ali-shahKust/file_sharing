//
// import 'package:custom_file_manager/utilities/file_manager_utilities.dart';
// import 'package:custom_file_manager/views/file_manager_views/folder/folder.dart';
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
//
//
//
//
// class StorageItemView extends StatelessWidget {
//   final double percent;
//   final String title;
//   final String path;
//   final Color color;
//   final IconData icon;
//   final int usedSpace;
//   final int totalSpace;
//
//   StorageItemView({
//     required this.percent,
//     required this.title,
//     required this.path,
//     required this.color,
//     required this.icon,
//     required this.usedSpace,
//     required this.totalSpace,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>Folder(title: title, path: path),));
//       },
//       contentPadding: EdgeInsets.only(right: 20),
//       leading: Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: Theme.of(context).dividerColor,
//             width: 2,
//           ),
//         ),
//         child: Center(
//           child: Icon(icon, color: color),
//         ),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(title),
//           Text(
//             '${FileManagerUtilities.formatBytes(usedSpace, 2)} '
//             'used of ${FileManagerUtilities.formatBytes(totalSpace, 2)}',
//             style: TextStyle(
//               fontWeight: FontWeight.w400,
//               fontSize: 14.0,
//               color: Theme.of(context).textTheme.headline1!.color,
//             ),
//           ),
//         ],
//       ),
//       subtitle: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//         ),
//         child: LinearPercentIndicator(
//           padding: EdgeInsets.all(0),
//           backgroundColor: Colors.grey[300],
//           percent: percent,
//           progressColor: color,
//         ),
//       ),
//     );
//   }
// }
