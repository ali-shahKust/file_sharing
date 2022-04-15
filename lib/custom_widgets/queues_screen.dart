import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/data/extension.dart';
import 'package:quick_backup/utilities/custom_theme.dart';
import 'package:quick_backup/utilities/i_utills.dart';
import 'package:quick_backup/views/dashboard/dashboard_vm.dart';


class QuesScreen extends StatefulWidget {
  static const routeName = 'queue_screen';
  List<File> files;


  QuesScreen({required this.files});


  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<DashBoardVm>(context, listen: false).uploadFile(widget.files);
      print("MY arguments are :${widget.files.length}");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardVm>(builder: (context, vm, _) {

    return SafeArea(
        child: Scaffold(
          body: vm.connectionLost
              ? const Center(
                  child: Text("Connection lost"),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    completed == vm.queue.length
                        ? Container()
                        :  SpinKitCircle(
                            color: CustomTheme.primaryColor,
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: getScreenWidth(context) - 150,
                      height: 250,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomTheme.primaryColor),
                      child: Container(
                        width: getScreenWidth(context) - 170,
                        height: 230,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Text(
                              "$completed/${vm.queue.length}"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getScreenWidth(context),
                      height: getScreenHeight(context) * 0.55,
                      child: ListView.builder(
                          itemCount: vm.queue.length,
                          itemBuilder: (context, index) {
                            print("PROGRESS Report :${vm.queue[index]!.progress }");
                            double sizeInMb =
                                int.parse(vm.queue[index]!.size) / (1024 * 1024);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                    vm.queue[index]!.name),
                                trailing: Text(vm.queue[index]!.progress + "%"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(sizeInMb.toStringAsFixed(3) + " MB "),
                                    Text(DateTime.parse(vm.queue[index]!.date)
                                        .toddMMMMyyyy()),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
        ),
      );
    });
  }


}
