import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nahins_project/custom_widget/exceptions/loading.dart';
import 'package:nahins_project/custom_widget/exceptions/snackbar_error.dart';
import 'package:http/http.dart' as http;
import 'package:nahins_project/custom_widget/home_page/product_details/section.dart';

class ProductDetails extends StatefulWidget {
  final dynamic productID;
  final String title;
  final dynamic productPrice;
  final String productImage;
  final String description;
  final dynamic rating;
  final dynamic ratingCount;
  const ProductDetails({
    Key? key,
    required this.productID,
    required this.title,//done
    required this.productPrice, //done
    required this.productImage, //done
    required this.description,
    required this.rating, // done
    required this.ratingCount, // done
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState(
      description: description,
      productID: productID,
      productImage: productImage,
      productPrice: productPrice,
      rating: rating,
      ratingCount: ratingCount,
      title: title
  );
}

int productCounter = 1;
bool isLoading = false;
class _ProductDetailsState extends State<ProductDetails> {

  final dynamic productID;
  final String title;
  final dynamic productPrice;
  final String productImage;
  final String description;
  final dynamic rating;
  final dynamic ratingCount;
  _ProductDetailsState({
    required this.productID,
    required this.description,
    required this.productPrice,
    required this.ratingCount,
    required this.title,
    required this.productImage,
    required this.rating
  });

  Future addToCart({required productId,required quantity})async{
    setState(() {
      isLoading = true;
    });
    print("Called");
    try{
      http.Response response = await http.post(
        Uri.parse('https://fakestoreapi.com/carts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
           'userId' : '5',
           'date' : DateTime.now().toString(),
           'products' : [{"productId": productId,"quantity": quantity}].toString()
        }),
      );
      if(response.statusCode == 200){
        print(response.body);
        showSnackBar(
            message:"Added Successfully !" ,
            conteXt: context,
            backgroundColorName: Colors.green,
            displayTimeDuration: 2000
        );
        showSnackBar(
            message: "response body :\n${response.body.toString()}",
            conteXt: context,
            backgroundColorName: Colors.blueGrey,
            displayTimeDuration: 10000
        );
      }
      setState(() {
        isLoading = false;
      });
    }catch(error){
      print(error);
      showSnackBar(
          message: "error occurred when products adding to cart",
          conteXt: context,
          backgroundColorName: Colors.deepOrange,
          displayTimeDuration: 2500
      );
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    setState(() {
      productCounter = 1;
      isLoading = false;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:  AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:const[
              Text("Details",
                  style:TextStyle(
                      color:Colors.black
                  )
              )
            ],
          ),
        ),
      ),
      body:isLoading?showLoading() : ListView(
        children: [
          Container(
            padding:const EdgeInsets.all(10),
            child: Text(
              title.toString(),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
            ),
          ),
          Image(
            image: NetworkImage(
              productImage.toString(),
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          sectionBy(
              sectionName:"Product ID : " ,
              value: productID
          ),
          sectionBy(
              sectionName:"Rating : ",
              value: rating
          ),
          sectionBy(
              sectionName:"Rating count : ",
              value: ratingCount
          ),
          sectionBy(
              sectionName:"price : ",
              value: "$productPrice usd"
          ),
          /// adding product quantity
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin:const EdgeInsets.only(left: 15,top: 15),
                    child:const Text("Currently in Cart :",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                ),
                Container(
                  margin:const EdgeInsets.only(left: 10,top: 15),
                 // padding: EdgeInsets.all(10),
                  child: Text("$productCounter",
                      style: const TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16
                      )
                  ),
                ),
                Container(
                    margin:const EdgeInsets.only(top: 12),
                    child: IconButton(
                      onPressed: (){
                        if(productCounter<5) {
                          setState(() {
                            productCounter++;
                          });
                        }else{
                          showSnackBar(
                              message: "You can add max 5 product at a time",
                              conteXt: context,
                              backgroundColorName:Colors.blueGrey,
                              displayTimeDuration: 2000
                          );
                        }
                      },
                      icon:const Icon(Icons.add,color: Colors.blueGrey,),
                    )
                ),
                Container(
                    margin:const EdgeInsets.only(top: 1),
                    child: IconButton(
                      splashColor: Colors.grey,
                      style: const ButtonStyle(alignment: Alignment.center),
                      onPressed: (){
                        if(productCounter > 1){
                          setState(() {
                            productCounter--;
                          });
                        }
                      },
                      icon:const Icon(Icons.minimize,color: Colors.blueGrey),
                    )
                ),],
            ),
          ),
          Container(
            padding:const EdgeInsets.only(left: 15,top: 10),
            child:const Text("Description :",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color : Colors.deepOrange,
                  fontSize: 13
              ),
            ),
          ),
          Container(
            padding:const EdgeInsets.all(15),
            child: Text(description.toString(),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
       floatingActionButton:SizedBox(
         width: 150,
         child:  FloatingActionButton(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
             ),
             splashColor: Colors.grey,
             isExtended: true,
             backgroundColor: Colors.white,
             onPressed: (){
               print("pressed");
               addToCart(productId: productID, quantity: productCounter);
             },
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Container(
                   margin:const EdgeInsets.only(
                       left: 10,
                       right: 10
                   ),
                   child:const Text("Add to Cart",
                       style:TextStyle(
                         color: Colors.black,
                         fontSize: 12,
                       )
                   ),
                 ),
                 Container(
                   margin:const EdgeInsets.only(bottom: 4),
                   child: const Icon(Icons.shopping_basket,
                     size: 20,
                     color: Colors.deepOrange,
                   ),
                 )
               ],
             )
         ),
       ),
    );
  }
}


