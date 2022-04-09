import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import 'custom_theme.dart';

class iUtills {
  static var gradientDecoration =   const BoxDecoration(
    gradient:  LinearGradient(
        colors: [
         CustomTheme.primaryColor,
         CustomTheme.secondaryColor

        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        tileMode: TileMode.decal),
  );

  Widget upperRoundedContainer(context, width , height) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1.5,
                offset: Offset(0.2, 0.3),
                blurRadius: 2.5
            )
          ],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
        color: Colors.white
      ),
    );
  }
  Widget bottomRoundedContainer(context, width , height,{Widget? child}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22),bottomRight: Radius.circular(22))
      ),child:child,
    );
  }

  static Widget glassContainer(
      {
    required var context,
    required var width,
    required var height,
        required child,
  }){
    return GlassmorphicContainer(
      width:width ,
      height: height,
      borderRadius: 22,
      blur: 4,
      border: 0.1,
      linearGradient: CustomTheme.iLinearGradient,
      borderGradient: CustomTheme.iBorderGradient,
    child: child,
    );
  }

}



double getScreenWidth(context)=>MediaQuery.of(context).size.width;
double getScreenHeight(context)=>MediaQuery.of(context).size.height;