// @dart=2.9
import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/home_page.dart';
import 'package:ica_companion_pasco/pages/premium_page.dart';
import 'package:ica_companion_pasco/pages/topics_page.dart';
import 'package:ica_companion_pasco/pages/trend_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    TrendPage(),
   // Container(child: Text("This feature is under development and not accessible at the moment"),),
    TopicsPage(),
    const PremiumPage(),
    

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: screens[currentIndex],


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trend',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.topic),
            label: 'Topics',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Premium',
            // backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
