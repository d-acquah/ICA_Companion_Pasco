import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/widgets/list_tile.dart';


class TopicsSubjectsPage extends StatefulWidget {
  TopicsSubjectsPage({Key? key, required this.topicsSubjects}) : super(key: key);

  final TopicsSubjects topicsSubjects;

  @override
  State<TopicsSubjectsPage> createState() => _TopicsSubjectsPageState();
}

class _TopicsSubjectsPageState extends State<TopicsSubjectsPage> {
    

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( toolbarHeight:65,
        centerTitle: true, automaticallyImplyLeading: false,
        title: Text(
          widget.topicsSubjects.name, maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            ),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: widget.topicsSubjects.topics.length,
              itemBuilder: (context, index) {
                return TopicListTile(
                  topic: widget.topicsSubjects.topics[index],
                );
              })),
    );
  }
}
