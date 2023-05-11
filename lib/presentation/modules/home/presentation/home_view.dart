import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:kabar_app_flutter/utils/extensions/centext_extension.dart';

import '../../../../data/repository_impl/api_repository/dart_io_api_repository_impl.dart';
import '../../../../data/repository_impl/news/news_repository_impl.dart';
import '../../../../domain/entities/news/news_entity.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/news_item_widget.dart';
import '../../../widgets/view_handler.dart';
import '../controller/home_controller.dart';
import '../widget/appbar_home.dart';
import '../widget/search_box_widget.dart';
import '../widget/trending_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Get.put(
      HomeController(
        repository: NewsRepositoryImpl(
          apiRepository: DartIOApiRepositoryImpl.instance,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      body: GetBuilder<HomeController>(
        builder: (c) {
          return ViewHandler(
            state: c.state,
            onReload: () async {
              await c.load();
            },
            child: _HomeSliver(
              state: c.state,
              key: widget.key,
              onTabChange: (int indexTab) async {
                await c.onTabChange(indexTab);
              },
              onReloadTab: (int indexTab) async {
                await c.onTabChange(indexTab);
              },
              onItamTap: (entity) {
                Get.toNamed(
                  '${AppRoutes.read}?target=${entity.target}',
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _HomeSliver extends StatefulWidget {
  final HomeState state;
  final void Function(int indexTab) onTabChange;
  final void Function(int indexTab) onReloadTab;
  final void Function(NewsEntity entity) onItamTap;
  const _HomeSliver({
    super.key,
    required this.state,
    required this.onTabChange,
    required this.onReloadTab,
    required this.onItamTap,
  });

  @override
  State<_HomeSliver> createState() => __HomeSliverState();
}

class __HomeSliverState extends State<_HomeSliver>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _tabController = TabController(
        length: widget.state.entity.categories.length + 1, vsync: this);
    _tabController.addListener(_handleTabSelection);

    super.initState();
  }

  void _handleTabSelection() {
    if (_tabController.animation?.value == _tabController.index) {
      _tabController.index > 0
          ? widget.onTabChange(_tabController.index - 1)
          : {};
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.state.entity.categories.length + 1,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SeacrhBoxWidget(
                    onSubmitted: (String value) {
                      Get.toNamed('${AppRoutes.search}?keyword=$value');
                    },
                  ),
                  TrendingWidget(
                    data: widget.state.entity.trending,
                    onItamTap: (NewsEntity entity) {
                      widget.onItamTap(entity);
                    },
                    onSeeAll: () {},
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicatorColor: context.primaryColor,
                  labelColor: context.textTheme.bodyLarge?.color,
                  unselectedLabelColor: context.disabledColor,
                  tabs: [
                    const Tab(
                      icon: Icon(
                        CupertinoIcons.home,
                        size: 14,
                      ),
                    ),
                    ...List.from(
                      widget.state.entity.categories.map(
                        (e) => Tab(
                          text: e.title,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ListView.builder(
              itemCount: widget.state.entity.headLineNwes.length,
              itemBuilder: (contex, index) {
                return NewsItemWidget(
                  data: widget.state.entity.headLineNwes[index],
                  onItamTap: (entity) {
                    widget.onItamTap(entity);
                  },
                );
              },
            ),
            ...List.from(
              widget.state.entity.categories.map(
                (e) => ViewHandler(
                  state: e,
                  onReload: () {
                    widget.onReloadTab(_tabController.index - 1);
                  },
                  child: e.headLineNews.isNotEmpty
                      ? ListView.builder(
                          itemCount: e.headLineNews.length,
                          itemBuilder: (contex, index) {
                            return NewsItemWidget(
                              data: e.headLineNews[index],
                              onItamTap: (entity) {
                                widget.onItamTap(entity);
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text('No Item'),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.canvasColor,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
