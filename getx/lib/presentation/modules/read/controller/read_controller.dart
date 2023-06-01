import 'package:get/get.dart';

import '../../../../config/enum/view_state.dart';
import '../../../../core/state/controller_state.dart';
import '../../../../domain/entities/news/news_read_entity.dart';
import '../../../../domain/repository/news_repository.dart';

class ReadState extends ControllerState {
  NewsReadEntiry entity;
  ReadState({NewsReadEntiry? entity}) : entity = entity ?? NewsReadEntiry();
}

class ReadController extends GetxController {
  final String? target;
  final NewsRepository repository;
  ReadController({
    required this.target,
    required this.repository,
  });
  ReadState state = ReadState();
  load() async {
    state.viewState = ViewState.loading;
    update();
    await repository.loadNewsRead(target ?? "").then(
      (value) {
        value.fold(
          (l) {
            state.viewState = ViewState.failed;
            state.message = '$l';
            update();
          },
          (r) {
            state.entity = r;
            state.viewState = ViewState.success;
            update();
          },
        );
      },
    );
  }

  @override
  void onInit() {
    load();
    super.onInit();
  }
}
