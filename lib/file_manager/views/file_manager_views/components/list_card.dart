// import 'package:flutter/material.dart';
//
// class ListCard extends StatelessWidget {
//   const ListCard({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: ListTile(
//           title: Text(fileProvider.fileItemList[index].name ?? ''),
//           leading:
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0),
//             child: Image.file(
//               File(fileProvider.fileItemList[index].path),
//               fit: BoxFit.fitWidth,
//               width: 70,
//               height: 70,
//             ),
//           ),
//           // Icon(Icons.picture_as_pdf),
//           trailing: fileProvider.fileItemList[index].isSelected?Container(
//               height: 30,
//               width: 30,
//               decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
//               child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Icon(
//                     Icons.check,
//                     size: 20.0,
//                     color: Colors.white,
//                   ))):SizedBox(height: 2.0,),
//           // IconButton(
//           //   icon:Icon(Icons.arrow_forward),
//           //   color: Colors.redAccent,
//           //   onPressed: (){
//           //   List<File> list =   fileProvider.getSelectedList();
//           //   for(int i =0 ;i<list.length;i++){
//           //     print('selected list values are...${list[i].path}');
//           //   }
//           //   },
//           // ),
//           onLongPress: () {
//             print(
//                 'path of the file selected is ....${fileProvider.fileItemList[index].path}');
//             fileProvider.enableSelectMode = true;
//             // fileProvider.fileItemList[index].isSelected = true;
//             print('select mode value is ${fileProvider.selectModeValue}');
//             // setState(() {
//             //   isSelect = true;
//             //   // filePathToShare = path;
//             // });
//             // print('path of the file to share  is ....$path');
//             // print('path of the file name  to share  is ....$file');
//             // uploadFile(context)
//             // uploadFile(context, currentContext: globals.globalContext, path: path, file1: file, sizeDem: 0);
//           },
//           onTap: () {
//             if(fileProvider.selectModeValue){
//               fileProvider.changeIsSelected(true, index);
//               setState(() {
//
//               });
//               print('list is Selected varibale value is ${fileProvider.fileItemList[index].isSelected}');
//               print('list is name varibale value is ${fileProvider.fileItemList[index].name}');
//
//               fileProvider.addToSelectedList(fileProvider.fileItemList[index].path);
//             }
//             else{
//             }
//
//
//             // setState(() {
//             //   isSelect = !isSelect;
//             // });
//             // for(int i =0;i<files.length();i++){
//             //   print('item in the list are ...${files[i]}');
//             // }
//             // OpenFile.open(path);
//             // Navigator.push(context, MaterialPageRoute(builder: (context) {
//             //   return ViewPDF(pathPDF: files[index].path.toString());
//             //open viewPDF page on click
//           },
//         )
//     );
//   }
// }
