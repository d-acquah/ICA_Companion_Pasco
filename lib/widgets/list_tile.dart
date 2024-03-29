import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/models/pasco_model.dart';
import 'package:ica_companion_pasco/topics_years_page.dart';

class TopicListTile extends StatelessWidget {
  final Topic topic;

  const TopicListTile({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(topic.name),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => TopicsYearsPage(
                    title: topic.name,
                    monthYear: topic.monthYear,
                  ))));
        },
      ),
      const SizedBox(
        height: 10,
      ),
      const Divider(
              indent: 0,
              thickness: 2,
            ),
    ]);
  }
}
