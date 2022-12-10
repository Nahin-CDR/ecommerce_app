import 'package:flutter/material.dart';
import 'package:nahins_project/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:const[
                Text("ShopEEE",
                    style:TextStyle(
                        color:Colors.deepOrange
                    )
                )
              ],
            ),
          ),
        ),
        body:const HomePage(),
      ),
    );
  }
}