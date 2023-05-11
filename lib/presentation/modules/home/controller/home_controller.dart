import 'package:get/get.dart';

import '../../../../config/enum/view_state.dart';
import '../../../../core/state/controller_state.dart';
import '../../../../domain/entities/news/home_entity.dart';
import '../../../../domain/repository/news_repository.dart';

class HomeState extends ControllerState {
  HomeEntity entity;
  HomeState({HomeEntity? entity}) : entity = entity ?? HomeEntity();
}

class HomeController extends GetxController {
  HomeState state = HomeState();
  final NewsRepository repository;
  HomeController({required this.repository});
  Future<void> load() async {
    state.viewState = ViewState.loading;
    update();
    await repository.loadHome().then(
      (value) {
        value.fold(
          (l) {
            state.viewState = ViewState.failed;
            state.message = '$l';
            update();
          },
          (r) {
            state.entity = r;
            state.viewState = ViewState.succsess;
            update();
          },
        );
      },
    );
  }

  Future<void> onTabChange(int indexTab) async {
    if (state.entity.categories[indexTab].viewState != ViewState.succsess) {
      state.entity.categories[indexTab].viewState = ViewState.loading;
      update();
      await repository
          .loadNewsByCategoryList(state.entity.categories[indexTab].target)
          .then(
        (value) {
          value.fold(
            (l) {
              state.entity.categories[indexTab].viewState = ViewState.failed;
              state.entity.categories[indexTab].message = '$l';
              update();
            },
            (r) {
              state.entity.categories[indexTab].headLineNews = r;
              state.entity.categories[indexTab].viewState = ViewState.succsess;
              update();
            },
          );
        },
      );
    }
  }

  @override
  void onInit() {
    load();
    super.onInit();
  }
}
