import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glass_mor/ui/dashboard/dashboard_screen.dart';
import 'package:glass_mor/ui/main_page/main_vm.dart';
import 'package:glass_mor/utills/i_utills.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainVm>(builder: (context, vm, _) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: getScreenWidth(context),
            height: getScreenHeight(context),
            child: Stack(
              children: [
                iUtills.glassContainer(
                    context: context,
                    width: getScreenWidth(context),
                    height: getScreenHeight(context) * 0.32,
                    child: const Center(
                      child: Text(
                        "Lorem Ipsum is some dummy Text,Lorem Ipsum is some dummy Text,Lorem Ipsum is some dummy Text",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: iUtills.glassContainer(
                    context: context,
                    width: getScreenWidth(context),
                    height: getScreenHeight(context) * 0.103,
                    child: Center(
                      child: vm.isLoading?const SpinKitDoubleBounce(
                        color: Colors.white60,
                      ):TextButton(
                        child: const Text('Get Started'),
                        onPressed: () {
                          vm.getStarted(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
