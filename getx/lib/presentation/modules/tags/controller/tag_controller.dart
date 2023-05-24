import 'package:get/get.dart';

import '../../../../config/enum/view_state.dart';
import '../../../../core/state/controller_state.dart';
import '../../../../core/state/controller_state_load_more.dart';
import '../../../../domain/entities/news/news_entity.dart';
import '../../../../domain/repository/news_repository.dart';

class TagState extends ControllerState with ControllerStateLoadMore {
  List<NewsEntity> entity;
  TagState({this.entity = const []});
}

class TagController extends GetxController {
  final String? target;
  final NewsRepository repository;
  TagController({
    required this.target,
    required this.repository,
  });
  int _dataPerpage = 0;

  TagState state = TagState();
  Future<void> load({
    int page = 1,
    void Function(String message)? onError,
  }) async {
    if (page == 1) {
      state.viewState = ViewState.loading;
      state.page = 1;
      state.entity = [];
    }
    state.loadComplete = false;
    update();
    await repository
        .loadNewsByTag('${target ?? ''}/text/?page=${state.page}')
        .then(
          (value) => value.fold(
            (l) {
              if (page == 1) {
                state.viewState = ViewState.failed;
                state.message = '$l';
                state.loadComplete = true;
                update();
              } else {
                onError != null ? onError('$l') : {};
                state.loadComplete = true;
                update();
              }
            },
            (r) {
              state.entity.addAll(r);
              if (state.page == 1) {
                _dataPerpage = state.entity.length;
              }
              state.isLastPage =
                  state.entity.length < (_dataPerpage * state.page) ||
                      state.entity.length < 10;
              state.viewState = ViewState.succsess;
              update();
              state.page++;
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
