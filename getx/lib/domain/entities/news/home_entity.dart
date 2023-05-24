import 'dart:convert';

import 'news_category_entity.dart';
import 'news_entity.dart';

class HomeEntity {
  final NewsEntity? trending;
  final List<NewstCategoryEntity> categories;
  List<NewsEntity> headLineNwes;
  HomeEntity({
    this.trending,
    this.categories = const [],
    this.headLineNwes = const [],
  });
  Map get toMap => {
        "trending": trending?.toMap,
        "cateories": List.from(categories.map((e) => e.toMAp)),
        "news": List.from(headLineNwes.map((e) => e.toMap)),
      };
  @override
  String toString() => jsonEncode(toMap);
}
