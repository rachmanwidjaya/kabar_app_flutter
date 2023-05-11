import 'package:get/get.dart';

import '../../../../data/repository_impl/api_repository/dart_io_api_repository_impl.dart';
import '../../../../data/repository_impl/news/news_repository_impl.dart';
import 'tag_controller.dart';

class TagBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TagController>(
      () => TagController(
        target: Get.parameters['target'],
        repository: NewsRepositoryImpl(
          apiRepository: DartIOApiRepositoryImpl.instance,
        ),
      ),
    );
  }
}
