import 'package:flutter/material.dart';
import 'package:nahins_project/screens/home_page.dart';




Widget categoryContainer({
  required String categoryName,

})=> Container(
  height: 30,
  constraints: const BoxConstraints(
    minWidth: 120,
  ),
  //width : 150,
  padding:const EdgeInsets.all(2),
  margin : const EdgeInsets.all(10),
  child: Container(
    height : 60,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 2.0),
              blurRadius: 8.0,
              spreadRadius: 2.0
          )
        ]),
    child: TextButton(
      onPressed: (){




      },
      child: Text(
          categoryName,
          style:const TextStyle(
              color: Colors.blueGrey,
              fontSize: 12
          )
      ),
    ),
  ),
);