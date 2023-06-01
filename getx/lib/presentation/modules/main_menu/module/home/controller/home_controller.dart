import 'package:get/get.dart';

import '../../../../../../config/enum/view_state.dart';
import '../../../../../../core/state/controller_state.dart';
import '../../../../../../domain/entities/news/home_entity.dart';
import '../../../../../../domain/repository/news_repository.dart';

class HomeState extends ControllerState {
  HomeEntity data;
  HomeState({HomeEntity? data}) : data = data ?? HomeEntity();
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
            state.data = r;
            state.viewState = ViewState.success;
            update();
          },
        );
      },
    );
  }

  Future<void> onTabChange(int indexTab) async {
    if (state.data.categories[indexTab].viewState != ViewState.success) {
      state.data.categories[indexTab].viewState = ViewState.loading;
      update();
      await repository
          .loadNewsByCategoryList(state.data.categories[indexTab].target)
          .then(
        (value) {
          value.fold(
            (l) {
              state.data.categories[indexTab].viewState = ViewState.failed;
              state.data.categories[indexTab].message = '$l';
              update();
            },
            (r) {
              state.data.categories[indexTab].headLineNews = r;
              state.data.categories[indexTab].viewState = ViewState.success;
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
