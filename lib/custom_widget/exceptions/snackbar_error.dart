import 'package:flutter/material.dart';
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
  required String message,
  required BuildContext conteXt,
  required Color backgroundColorName,
  required int displayTimeDuration,
}){
  return ScaffoldMessenger.of(conteXt).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:const TextStyle(
              fontSize: 15.00,
              color: Colors.white
          ),
        ),
        backgroundColor: backgroundColorName,
        duration: Duration(milliseconds:displayTimeDuration),
      )
  );
}