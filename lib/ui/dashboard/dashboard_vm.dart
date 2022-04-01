import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glass_mor/data/base/base_vm.dart';
import 'package:glass_mor/utills/custom_theme.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:glass_mor/widget/primary_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utills/amplify_utills.dart';

class DashBoardVm extends BaseVm {
  List<File> _files = [];

  List<File> get files => _files;
  bool _isUploading = false;

  set files(List<File> value) {
    _files = value;
    notifyListeners();
  }

  pickFile({context}) async {
    await FilePicker.platform.pickFiles(allowMultiple: true).then((value) {
      if (value != null && value.files.isNotEmpty) {
        files = value.paths.map((path) => File(path!)).toList();
        showModalBottomSheet(
            context: context,
            builder: (BuildContext mcontext) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(22),
                    topLeft: Radius.circular(22)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryText("Are you sure you want to share files ?"),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < files.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: iUtills.glassContainer(
                                    context: mcontext,
                                    width: 120.0,
                                    height: 120.0,
                                    child: Image.file(
                                      files[i],
                                      fit: BoxFit.cover,
                                      width: 120.0,
                                      height: 120.0,
                                    )),
                              ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: CustomTheme.primaryColor),
                            onPressed: () {
                              Navigator.pop(mcontext);
                              if (files.length > 1) {
                                zipFile(context, files);
                              } else {
                                uploadFile(context, files[0]).then((Myvalue) {
                                  showDialog(context: context, builder: (BuildContext dContext){
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: CustomTheme.primaryColor),
                                            onPressed: () {
                                              Navigator.pop(dContext);

                                            },
                                            child: PrimaryText(
                                              "Generate Bar Code",
                                              color: Colors.white,
                                            )),
                                      ],
                                    );
                                  }).then((value) {
                                    showDialog(context: context, builder: (BuildContext barcodeContext){
                                      return QrImage(
                                        data: Myvalue,
                                        version: QrVersions.auto,
                                        size: 200.0,
                                      );
                                    });
                                  });
                                });
                              }
                            },
                            child: PrimaryText(
                              "Yes",
                              color: Colors.white,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              files.clear();
                              Navigator.pop(mcontext);
                            },
                            child: PrimaryText(
                              "No",
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: CustomTheme.primaryColor)),
                      ],
                    )
                  ],
                ),
              );
            });
      }
      print("My files are ${files.length}");
    });
  }

  zipFile(context, files) async {
    var pathDown = await getTemporaryDirectory();

    int fileName = DateTime.now().millisecondsSinceEpoch;
    String zipPath = pathDown.path + "/" + '$fileName.zip';
    print('path in the device is....$zipPath');
    var encoder = ZipFileEncoder();
    encoder.create(zipPath);
    files.forEach((element) {
      encoder.addFile(File(element.path));
    });
    File zipFile = File(encoder.zipPath);
    uploadFile(context, zipFile).then((Myvalue) {
      // showDialog(context: context, builder: (BuildContext dContext){
      //   return Center(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //                 primary: CustomTheme.primaryColor),
      //             onPressed: () {
      //               Navigator.pop(dContext);
      //
      //             },
      //             child: PrimaryText(
      //               "Generate Bar Code",
      //               color: Colors.white,
      //             )),
      //       ],
      //     ),
      //   );
      // }).then((value) {
      //   showDialog(context: context, builder: (BuildContext barcodeContext){
      //     return Center(
      //       child: Container(
      //         color: Colors.white,
      //         child: QrImage(
      //           data: Myvalue,
      //           version: QrVersions.auto,
      //           size: 200.0,
      //         ),
      //       ),
      //     );
      //   });
      // });
    });
  }


}
