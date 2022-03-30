import 'package:flutter/material.dart';
import 'package:glass_mor/ui/dashboard/dashboard_vm.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:glass_mor/widget/primary_text.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = 'dash_board';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardVm>(
      builder: (context, vm, _) => Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: getScreenWidth(context),
            height: getScreenHeight(context),
            child: Stack(
              children: [
                iUtills.glassContainer(
                    context: context,
                    width: getScreenWidth(context),
                    height: getScreenHeight(context) * 0.43,
                    child: const Center(
                      child: Text(
                        "There will Image",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            vm.pickFile(context: context);
                          },
                          child: iUtills.glassContainer(
                              context: context,
                              width: getScreenWidth(context) / 2.5,
                              height: getScreenHeight(context) * 0.1833,
                              child: Center(
                                  child: PrimaryText(
                                'Send File',
                                color: Colors.white,
                                fontSize: 18,
                              ))),
                        ),
                        iUtills.glassContainer(
                            context: context,
                            width: getScreenWidth(context) / 2.5,
                            height: getScreenHeight(context) * 0.1833,
                            child: Center(
                                child: PrimaryText(
                              'Receive File',
                              color: Colors.white,
                              fontSize: 18,
                            ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
