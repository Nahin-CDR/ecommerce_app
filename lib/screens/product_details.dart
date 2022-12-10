import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String title;
  final dynamic productPrice;
  final String productImage;
  final String description;
  final dynamic rating;
  final dynamic ratingCount;
  const ProductDetails({
    Key? key,
    required this.title,//done
    required this.productPrice, //done
    required this.productImage, //done
    required this.description,
    required this.rating, // done
    required this.ratingCount, // done
  }) : super(key: key);

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
                      color:Colors.deepOrange
                  )
              )
            ],
          ),
        ),
      ),
      body: ListView(
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
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin:const EdgeInsets.only(left: 10),
                    child:const Text("Rating : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                ),
                Container(
                    margin:const EdgeInsets.only(right: 70),
                    child:Text("$rating",
                      style:const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15,
                      ),
                    )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin:const EdgeInsets.only(left: 10),
                    child:const Text("Rating count : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                ),
                Container(
                    margin:const EdgeInsets.only(right: 70),
                    child:Text("$ratingCount",
                      style:const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin:const EdgeInsets.only(left: 10),
                    child:const Text("price : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                ),
                Container(
                    margin:const EdgeInsets.only(right: 70),
                    child:Text("$productPrice",
                      style:const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                ),
              ],
            ),
          ),
          Container(
            padding:const EdgeInsets.all(10),
            child:const Text("Description : ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color : Colors.deepOrange
            ),
            ),
          ),
          Container(
            padding:const EdgeInsets.all(15),
            child: Text(description.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
            ),
          )
        ],
      ),
    );
  }
}
