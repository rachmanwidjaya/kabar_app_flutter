import 'dart:convert';

import 'news_category_entity.dart';

class NewsEntity {
  final String title;
  final String date;
  final String? image;
  final String desc;
  String target;
  final NewstCategoryEntity? category;
  NewsEntity({
    this.title = '',
    this.date = '',
    this.desc = '',
    this.image,
    this.category,
    this.target = '',
  });
  Map get toMap => {
        "title": title,
        "date": date,
        "image": image,
        "desc": desc,
        "category": category?.toMAp,
        "target": target,
      };
  @override
  String toString() => jsonEncode(toMap);
}
