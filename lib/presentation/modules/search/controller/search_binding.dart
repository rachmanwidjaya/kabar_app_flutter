import 'package:get/get.dart';

import '../../../../data/repository_impl/api_repository/dart_io_api_repository_impl.dart';
import '../../../../data/repository_impl/news/news_repository_impl.dart';
import 'search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsSearchController>(
      () => NewsSearchController(
        keyword: Get.parameters['keyword'] ?? '',
        repository: NewsRepositoryImpl(
          apiRepository: DartIOApiRepositoryImpl.instance,
        ),
      ),
    );
  }
}
