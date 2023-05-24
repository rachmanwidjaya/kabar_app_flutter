import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/list_builder_refresh_load_more.dart';

import '../../../widgets/news_item_widget.dart';
import '../../../widgets/view_handler.dart';
import '../controller/tag_controller.dart';

class TagView extends StatefulWidget {
  const TagView({super.key});

  @override
  State<TagView> createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        elevation: 0,
      ),
      body: GetBuilder<TagController>(
        builder: (c) {
          return ViewHandler(
            state: c.state,
            onReload: () async => c.load(),
            child: ListBuilderRefreshLoadMore(
              state: c.state,
              onLoadMore: () async {
                await c.load(
                  page: c.state.page,
                  onError: (message) {
                    Get.snackbar('Error', message);
                  },
                );
              },
              onRefresh: () async {
                await c.load(
                  onError: (message) {
                    Get.snackbar('Error', message);
                  },
                );
              },
              items: List<Widget>.from(
                c.state.entity.map(
                  (e) => NewsItemWidget(
                      data: e,
                      onItamTap: (entity) =>
                          Get.offAndToNamed(AppRoutes.readPage(entity.target))),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
