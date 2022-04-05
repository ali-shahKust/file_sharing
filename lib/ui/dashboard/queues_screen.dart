import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:glass_mor/utills/custom_theme.dart';
import 'package:glass_mor/utills/i_utills.dart';

import '../../data/app_model.dart';

class QuesScreen extends StatefulWidget {
  const QuesScreen({Key? key}) : super(key: key);

  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {
  final model = GetIt.I.get<AppModel>();

  @override
  Widget build(BuildContext context) {
    return  model.queue ==null?Scaffold(
      body: Column(
        children: [
        Text("Please wait")
      ],),
    ):Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      SpinKitCircle(
          color: CustomTheme.primaryColor,
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          width: getScreenWidth(context)-150,
          height: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomTheme.primaryColor
          ),
          child: Container(
            width: getScreenWidth(context)-170,
            height: 230,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: Center(
              child: Text("12/32"),
            ),
          ),
        ),
        Container(
          width: getScreenWidth(context),
          height: 250,
          child: ListView.builder(
              itemCount: model.queue.length,
              itemBuilder: (context , index){
            return Container(
              child: FittedBox(
                child: Row(
                  children: [
                    Text(model.queue[index]!.name),
                    Text(model.queue[index]!.progress),
                  ],
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}
