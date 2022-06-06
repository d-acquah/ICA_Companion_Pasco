import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/widgets/list_tile.dart';

class TopicsSubjectsPage extends StatelessWidget {
  TopicsSubjectsPage({Key key, this.topicsSubjects}) : super(key: key);

  final ScrollController _scrollController = ScrollController();
  final TopicsSubjects topicsSubjects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          topicsSubjects.name,
          style: const TextStyle(
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
      body: SafeArea(
          child: ListView.builder(
              itemCount: topicsSubjects.topics.length,
              itemBuilder: (context, index) {
                return TopicListTile(
                  topic: topicsSubjects.topics[index],
                );
              })),
    );
  }
}
