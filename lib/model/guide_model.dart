class GuideModel {
  final int no;
  final String title;
  final List<dynamic> tags;
  final String content;
  final String register;
  final DateTime date;

  GuideModel({
    required this.no,
    required this.title,
    required this.tags,
    required this.content,
    required this.register,
    required this.date
  });


  GuideModel.fromJson({
    required Map<String, dynamic> json,
  }) : no = json['no'],
       title = json['title'],
       tags = json['tags'],
       content = json['content'],
       register = json['register'],
       date = DateTime.parse(json['date']);


  Map<String, dynamic> toJson() {
    return {
      'no':no,
      'title':title,
      'tags':tags,
      'content':content,
      'register':register,
      'date':'${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}',
    };
  }


  GuideModel copyWith({
    String? no,
    String? title,
    List<dynamic>? tags,
    String? content,
    String? register,
    DateTime? date,
  }){
    return GuideModel(
        no: this.no,
        title: title ?? this.title,
        tags: tags ?? this.tags,
        content: content ?? this.content,
        register: register ?? this.register,
        date: this.date
    );
  }
}