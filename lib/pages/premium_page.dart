
import 'package:flutter/material.dart';

class PremiumPage extends StatefulWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Premium',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),  
        elevation: 0,
        backgroundColor: Colors.blue,
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
                  'Trend Feature(Not Available)',
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
              height: 150,
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
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                       foregroundColor: Colors.blue, minimumSize: const Size(50, 50),
                        textStyle: const TextStyle(fontSize: 14)),
                       // onPrimary: Colors.white),
                    onPressed: () {},
                    child: const Text('Buy for GH₵17/3Months')),
              ],
              
            ),
             const SizedBox(
              height: 40,
            ),Text(
                "*Subscription will not be renewed automatically when it expires",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Color(0xff333333)),
              ),
          ],
        ),
      ),
    );
  }
}
