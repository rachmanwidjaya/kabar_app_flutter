import 'dart:convert';

class NewsReadEntiry {
  final String title;
  final String image;
  final String desc;
  final String date;
  final String article;

  NewsReadEntiry({
    this.title = '',
    this.image = '',
    this.date = '',
    this.desc = '',
    this.article = '',
  });
  Map get toMap => {
        "title": title,
        "image": image,
        "desc": desc,
        "date": date,
        "article": article,
      };
  @override
  String toString() => jsonEncode(toMap);
}
