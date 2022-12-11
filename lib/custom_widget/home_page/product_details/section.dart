import 'package:flutter/material.dart';

Widget sectionBy(
    {
      required sectionName,
      required value}) =>
    SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin:const EdgeInsets.only(left: 10),
              child: Text(sectionName.toString(),
                style:const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
          ),
          Container(
              margin:const EdgeInsets.only(right: 70),
              child:Text("$value",
                style:const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 12,
                ),
              )
          ),
      ],
    ),
  );