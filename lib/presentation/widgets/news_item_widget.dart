import 'package:kabar_app_flutter/utils/extensions/centext_extension.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/news/news_entity.dart';
import 'image_screen.dart';
import 'shadow_widget.dart';

class NewsItemWidget extends StatelessWidget {
  final void Function(NewsEntity entity) onItamTap;
  final NewsEntity data;
  const NewsItemWidget({
    super.key,
    required this.data,
    required this.onItamTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItamTap(data);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShadowWidget(
              child: Stack(
                children: [
                  ImageScreen(
                    data.image ?? '',
                    height: kBottomNavigationBarHeight * 2,
                    width: kBottomNavigationBarHeight * 2,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Text(
                      data.date,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontSize: 11,
                        shadows: context.shadow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: context.textTheme.bodyLarge!.color,
                        fontSize: 14),
                  ),
                  Text(
                    data.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.disabledColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
