import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/list_builder_refresh_load_more.dart';
import '../../../widgets/news_item_widget.dart';
import '../../../widgets/view_handler.dart';
import '../controller/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        elevation: 0,
      ),
      body: GetBuilder<NewsSearchController>(
        builder: (c) => ViewHandler(
          state: c.state,
          onReload: () async => c.load(),
          child: ListBuilderRefreshLoadMore(
            state: c.state,
            onRefresh: () async => c.load(),
            items: List<Widget>.from(
              c.state.entity.map(
                (e) => NewsItemWidget(
                  data: e,
                  onItamTap: (entity) =>
                      Get.offAndToNamed(AppRoutes.readPage(entity.target)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
