// @dart=2.9

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
    this.name,
    this.monthYear,
  });

  String name;
  List<MonthYear> monthYear;
}

class MonthYear {
  MonthYear({
    this.name,
    this.link,
  });

  String name;
  String link;
}

class TopicsSubjects {
  TopicsSubjects({
    this.name,
    this.topics,
  });

  String name;
  List<Topic> topics;
}

class Topic {
  Topic({
    this.name,
    this.monthYear,
  });

  String name;
  List<MonthYear> monthYear;
}
