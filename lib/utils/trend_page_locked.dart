import 'package:flutter/material.dart'; // Import the necessary Flutter libraries

void showTrendLockedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 65,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Trend Analysis',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            // ListView.separated
            Positioned.fill(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Level 1',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Financial Accounting',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Business Management & Information System',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Business & Corporate Law',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Introduction to Management Accounting',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Level 2',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Financial Reporting',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Management Accounting',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Audit & Assurance',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Financial Management',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Public Sector Accounting & Finance',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Level 3',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Principles of Taxation',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Corporate Reporting',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Advanced Audit & Assurance',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Advanced Taxation',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text(
                      'Strategic Case Study',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const Divider(
                    indent: 0,
                    thickness: 2,
                  ),
                  ListTile()
                ],
              ),
            ),
            // AlertDialog
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: AlertDialog(
                  backgroundColor: Colors.blue, // Set background color
                  title: Text(
                    'Trend Analysis',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600, // Set font weight
                    ), // Set title text color
                  ),
                  content: SingleChildScrollView(
                    child: Text(
                      'Trend Analysis provides insight into the pattern of questions examined over a relevant period of time and is available to premium users only.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ), // Set content text color
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600, // Set font weight
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
