// @dart=2.9
import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Premium',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const ListTile(
              title: Text(
                'Upgrade to Premium',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              subtitle: Text(
                "Here's what you get",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Color(0xff333333)),
              ),
            ),
            const Card(
              child: ListTile(
                title: Text(
                  'Trend Feature(Not available)',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Text(
                  "Provides the trend of questions over a relevant period of time",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color(0xff333333)),
                ),
                leading: Icon(Icons.trending_up),
                iconColor: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Card(
              child: ListTile(
                title: Text(
                  'Topics Feature',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Text(
                  "Categorizes past questions according to the topics they fall under",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color(0xff333333)),
                ),
                leading: Icon(
                  Icons.topic,
                  color: Colors.blue,
                ),
              ),
            ),
           const SizedBox(
              height: 10,
            ),
            const Card(
              child: ListTile(
                title: Text(
                  'No Ads',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                subtitle: Text(
                  "Enjoy ICA Companion : Pasco without ads",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color(0xff333333)),
                ),
                leading: Icon(
                  Icons.cancel_presentation_outlined,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue, minimumSize: const Size(50, 50),
                        textStyle: const TextStyle(fontSize: 14)),
                    onPressed: () {},
                    child: const Text('Buy for GH₵7/Month')),
                   //const Spacer(flex:1,),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                       foregroundColor: Colors.blue, minimumSize: const Size(50, 50),
                        textStyle: const TextStyle(fontSize: 14)),
                       // onPrimary: Colors.white),
                    onPressed: () {},
                    child: const Text('Buy for GH₵17/3Months')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
