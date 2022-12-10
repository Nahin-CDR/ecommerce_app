//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:nahins_project/screens/product_details.dart';



Widget productCard({
  required String title,
  required dynamic productPrice,
  required String productImage ,
  required String description,
  required dynamic rating,
  required dynamic ratingCount,
  required width,
  required conteXt,
  required textSize,
})=> GestureDetector(
  onTap: (){
    Navigator.push(conteXt, MaterialPageRoute(builder: (conteXt)=>
        ProductDetails(
            title: title,
            productPrice: productPrice,
            productImage: productImage,
            description: description,
            rating: rating,
            ratingCount: ratingCount
        )
    ));
    // Navigator.push(conteXt,MaterialPageRoute(builder: (context)=>gotoPage));
  },
  child: Container(
    height: 200,//width/2+95,
    width: width/2+20,//+45,
    margin: const EdgeInsets.all(10.00),
    decoration : BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 2,
          offset: const Offset(0, 7), // changes position of shadow
        ),
      ],
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.00),
          bottomRight: Radius.circular(10.00),
          topRight: Radius.circular(10.00),
          bottomLeft: Radius.circular(10.00)
      ),
      color: Colors.white,
    ),
    child: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:const EdgeInsets.all(2),
              height: 60,
              width: width/2,
              child: Image(
                image: NetworkImage(productImage.toString()),
                height: 45,
                width: 45,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5),
              child:  Divider(
                  color: Colors.deepOrange,
                  thickness: 1
              ),
            ),
            Container(
              padding:const EdgeInsets.all(2),
              margin: const EdgeInsets.only(bottom: 5),
              child: Text(
                  "${productPrice.toString()} usd",
                  style:  TextStyle(
                    fontSize: textSize,
                    color: Colors.black,
                  )
              ),
            )
          ],
        )
    ),
  ),
);