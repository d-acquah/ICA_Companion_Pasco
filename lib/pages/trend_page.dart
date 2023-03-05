// // @dart=2.9
 //import 'package:ica_companion_pasco/home_year_page.dart';
// import 'package:ica_companion_pasco/pasco_model.dart';
 import 'package:flutter/material.dart';

class TrendPage extends StatelessWidget {
TrendPage({Key key}) : super(key: key);
final ScrollController _scrollController = ScrollController();

@override
Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
         title: const Text(
          'Trend Analysis',
           style: TextStyle(
               fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black),
         ),
         actions: [
           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
         elevation: 0,
         backgroundColor: Colors.white,
         bottom: PreferredSize(
           preferredSize: const Size.fromHeight(90),
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: TextField(
              decoration: InputDecoration(
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15)),
                   hintText: 'Search by course or subject name',
                   prefixIcon: const Icon(Icons.search)),
            ),
           ),
         ),
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