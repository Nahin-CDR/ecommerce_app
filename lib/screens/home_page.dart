import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nahins_project/custom_widget/exceptions/loading.dart';
import 'package:nahins_project/custom_widget/exceptions/snackbar_error.dart';
import '../custom_widget/home_page/product_container.dart';
import 'package:http/http.dart' as http;

bool isLoadingProducts = false;
bool isLoadingCategory = false;
double? width;
List listResponse = [];
List uniqueCategory = [];
bool selected = false;
Map<int,bool>isChecked = {};

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> apiCallForCategory({required String categoryName}) async {
    setState(() {
      isLoadingProducts = true;
    });
    try{
      http.Response response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/$categoryName'));
      if(response.statusCode == 200){
        setState(() {
          listResponse.clear();
          listResponse = json.decode(response.body);
        });
        setState(() {
          isLoadingProducts = false;
        });
      }
    }catch(error){
      showSnackBar(
          message: "something went wrong",
          conteXt: context,
          backgroundColorName: Colors.red,
          displayTimeDuration: 4500
      );
    }
  }
  Future apiCall()async{
    try{
      http.Response response;
      response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
      if(response.statusCode == 200){
        setState((){
          listResponse = json.decode(response.body);
          Map<String,dynamic>categoryFilter = {};
          int counter = 0;
          for (var element in listResponse) {
            categoryFilter[element['category']] = counter++;
          }
          categoryFilter.forEach((key, value) {
            uniqueCategory.add(key.toString());
          });
          print(listResponse);
        });

      }
      setState(() {
        isLoadingCategory = false;
        isLoadingProducts = false;
      });
    }catch(error){
      showSnackBar(
          message: "something wen wrong",
          conteXt: context,
          backgroundColorName: Colors.deepOrange,
          displayTimeDuration: 4500
      );
    }
  }

  @override
  void initState() {
    apiCall();
    setState(() {
      isLoadingCategory = true;
      isLoadingProducts = true;
    });
    //TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2.0;
    width = MediaQuery.of(context).size.width / 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section Name
        Container(
          margin: const EdgeInsets.only(
            top: 15, left: 10,),
          child:const Text("Categories",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        ),
        /// Categories Section
        SizedBox(
          height: 70,
          child: isLoadingCategory ? showLoading() : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: uniqueCategory.length,
            itemBuilder: (context,index){
              return Container(
                height: 30,
                constraints: const BoxConstraints(
                  minWidth: 120,
                ),
                //width : 150,
                padding:const EdgeInsets.all(2),
                margin : const EdgeInsets.all(10),
                child: Container(
                  height : 60,
                  decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius:const BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      boxShadow: [
                        isChecked[index] == true? const BoxShadow(
                            color: Colors.deepOrange,
                            offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                            spreadRadius: 2.0
                        ):
                        const BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 2.0),
                            blurRadius: 8.0,
                            spreadRadius: 2.0
                        )
                      ]
                  ),
                  child: TextButton(
                    onPressed: (){
                      setState(() {
                        isChecked.forEach((key, value) {
                          isChecked[key] = false;
                        });
                        isChecked[index] = true;
                      });
                      apiCallForCategory(categoryName: uniqueCategory[index]);
                    },
                    child: Text(
                        uniqueCategory[index],
                        style:const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12
                        )
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        /// Section Name
        Container(
          margin: const EdgeInsets.only(
              top: 15,
              left: 10
          ),
          child:const Text("Products",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        ),
        /// products
        Expanded(
            child: isLoadingProducts ? showLoading() :
            GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                  listResponse.length,(index) {
                return Center(
                    child: productCard(
                      productID: listResponse[index]['id'],
                      title: listResponse[index]['title'],
                      description: listResponse[index]['description'],
                      productImage: listResponse[index]['image'],
                      productPrice:listResponse[index]['price'] ,
                      rating: listResponse[index]['rating']['rate'],
                      ratingCount: listResponse[index]['rating']['count'],
                      width: width,
                      conteXt: context,
                      textSize: unitHeightValue*multiplier-5,
                    )
                );
              }
              ),
            )
        )
      ],
    );

  }
}