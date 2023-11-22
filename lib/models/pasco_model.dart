
class HomeYear {
  HomeYear({
    required this.name,
    required this.monthYear,
  });

  String name;
  List<MonthYear> monthYear;
}

class MonthYear {
  MonthYear({
    required this.name,
    required this.link,
    this.title
  });

  String name;
  String link;
  String? title;
}

class TopicsSubjects {
  TopicsSubjects({
    required this.name,
    required this.topics,
  });

  String name;
  List<Topic> topics;
}

class Topic {
  Topic({
    required this.name,
    required this.monthYear,
  });

  String name;
  List<MonthYear> monthYear;
}
class Trend {
  Trend({
    required this.name,
    required this.trendTopics,
  });

  String name;
  List<dynamic> trendTopics;
}