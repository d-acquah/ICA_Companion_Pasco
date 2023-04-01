// class HomeYear {
// HomeYear({
//this.name,
//this.monthyear,
//});

//String name;
//String monthyear;
//}

//class Topics {
//Topics({
//this.name,
//this.subject,
//});

//String name;
//String subject;
//}

//class Subjects {
//Subjects({
//this.name,
//this.subtopics,
//});

//String name;
//String subtopics;
//}

//class SubTopics {
//SubTopics({
//this.name,
//this.monthyear,
//});

//String name;
//List <String> monthyear;
//}

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
