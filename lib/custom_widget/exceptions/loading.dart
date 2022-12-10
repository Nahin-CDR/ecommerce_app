import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
Widget showLoading() => const Center(
  child: SpinKitRipple(
    color: Colors.deepOrange,
    size: 70.0,
  ),
);