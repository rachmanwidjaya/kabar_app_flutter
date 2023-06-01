import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../routes/app_pages.dart';
import '../../../widgets/image_screen.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/shadow_widget.dart';
import '../../../widgets/view_handler.dart';
import '../controller/read_controller.dart';

class ReadView extends StatefulWidget {
  const ReadView({super.key});

  @override
  State<ReadView> createState() => _ReadViewState();
}

class _ReadViewState extends State<ReadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.canvasColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_outlined),
            ),
          ),
        ],
      ),
      body: GetBuilder<ReadController>(
        builder: (c) => ViewHandler(
          state: c.state,
          onReload: () async => await c.load(),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            children: [
              ShadowWidget(
                child: ImageScreen(c.state.entity.image),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                c.state.entity.title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  letterSpacing: 0.12,
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              Text(
                c.state.entity.desc,
                style: context.textTheme.bodySmall
                    ?.copyWith(color: context.disabledColor),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              HtmlWidget(
                c.state.entity.article,
                textStyle: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: context.textColor,
                ),
                onLoadingBuilder: (context, element, loadingProgress) =>
                    const Center(child: LoadingWidget()),
                onTapUrl: (url) async {
                  if (Uri.parse(url).pathSegments[1] == 'read') {
                    Get.offNamed(AppRoutes.readPage(url));
                  } else if (Uri.parse(url).pathSegments[0] == 'tag') {
                    Get.offNamed(AppRoutes.tagPage(url));
                  }
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
