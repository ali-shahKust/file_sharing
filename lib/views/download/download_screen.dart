import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quick_backup/data/extension.dart';
import 'package:provider/provider.dart';
import 'package:quick_backup/views/download/download_vm.dart';
import '../../utilities/custom_theme.dart';
import '../../utilities/i_utills.dart';
import '../dashboard/dashboard_vm.dart';

class DownloadScreen extends StatefulWidget {
  static const routeName = 'download_screen';
  List files;


  DownloadScreen({required this.files});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<DownloadVm>(context, listen: false).downloadFile(widget.files,context);
      print("MY arguments are :${widget.files.length}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DownloadVm>(builder: (context, vm, _) {
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
                  : const SpinKitCircle(
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
                      // print("XXXProgress Result ${GetIt.I.get<OnlineBackUpVm>().queue[index]!.progress}");

                      double sizeInMb =
                          int.parse(vm.queue[index]!.size) / (1024 * 1024);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                              vm.queue[index]!.name),
                          trailing: vm.queue[index]!.progress =="Exist already"?Text("Exist Already"):Text(vm.queue[index]!.progress + "%"),
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
