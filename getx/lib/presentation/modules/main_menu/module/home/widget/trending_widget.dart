import 'package:kabar_app_getx/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/entities/news/news_entity.dart';
import '../../../../../widgets/image_screen.dart';
import '../../../../../widgets/shadow_widget.dart';

class TrendingWidget extends StatelessWidget {
  final NewsEntity? data;
  final void Function(NewsEntity entity) onItamTap;
  final void Function() onSeeAll;
  const TrendingWidget({
    super.key,
    this.data,
    required this.onItamTap,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending',
                      style: context.textTheme.bodyLarge,
                    ),
                    InkWell(
                      onTap: onSeeAll,
                      child: Text(
                        'Sell all',
                        style: context.textTheme.bodySmall,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  onItamTap(data!);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 12, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShadowWidget(
                        child: ImageScreen(
                          data!.image ?? "",
                          height: context.sizeWidth / 2,
                          width: context.sizeWidth,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      Text(
                        data!.date,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: context.disabledColor),
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      Text(
                        data!.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: context.textTheme.bodyLarge!.color),
                      ),
                      const Padding(padding: EdgeInsets.all(4)),
                      Text(
                        data!.desc,
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: context.disabledColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
