import 'package:get/get.dart';

import '../../../../config/enum/view_state.dart';
import '../../../../core/state/controller_state.dart';
import '../../../../core/state/controller_state_load_more.dart';
import '../../../../domain/entities/news/news_entity.dart';
import '../../../../domain/repository/news_repository.dart';

class SearchState extends ControllerState with ControllerStateLoadMore {
  List<NewsEntity> entity;
  int page;
  SearchState({this.entity = const [], this.page = 1});
}

class NewsSearchController extends GetxController {
  final String keyword;
  final NewsRepository repository;
  NewsSearchController({
    required this.keyword,
    required this.repository,
  });

  SearchState state = SearchState();
  Future<void> load() async {
    state.viewState = ViewState.loading;
    state.loadComplete = false;
    update();
    await repository.search(keyword).then(
          (value) => value.fold(
            (l) {
              state.viewState = ViewState.failed;
              state.message = '$l';
              state.loadComplete = true;
              update();
            },
            (r) {
              state.entity = r;
              state.viewState = ViewState.succsess;
              state.loadComplete = true;
              update();
            },
          ),
        );
  }

  @override
  void onInit() {
    load();
    super.onInit();
  }
}
