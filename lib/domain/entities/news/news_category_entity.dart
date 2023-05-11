import 'dart:convert';

import '../../../config/enum/view_state.dart';
import '../../../core/state/controller_state.dart';
import 'news_entity.dart';

class NewstCategoryEntity extends ControllerState {
  final String title;
  final String target;
  List<NewsEntity> headLineNews;

  NewstCategoryEntity({
    this.title = '',
    this.target = '',
    this.headLineNews = const [],
    super.message,
  }) : super(viewState: ViewState.initial);

  Map get toMAp => {
        "title": title,
        "target": target,
        "newsList": List.from(headLineNews.map((e) => e.toMap)),
      };

  @override
  String toString() => jsonEncode(toMAp);
}
