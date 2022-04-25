import 'package:flutter/material.dart';
import 'package:quick_backup/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
          strokeWidth: 2.0,
        ));
  }
}
