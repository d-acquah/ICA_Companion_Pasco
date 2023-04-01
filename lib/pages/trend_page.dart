
// // @dart=2.9
 //import 'package:ica_companion_pasco/home_year_page.dart';
// import 'package:ica_companion_pasco/pasco_model.dart';
 import 'package:flutter/material.dart';

class TrendPage extends StatelessWidget {
TrendPage({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
   return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Trend Analysis',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
body: Center(
  child:   SafeArea(
  
         child: Text("This feature is under development and not accessible at the moment",style: TextStyle(
               fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
         ),
  
               ),
),
            ); 
 }

}