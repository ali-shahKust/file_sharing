import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
    return Scaffold(
      body: Center(
        child:Text("${model.queue.progress}"),
      ),
    );
  }
}
