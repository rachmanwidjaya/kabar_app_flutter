import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../../../core/controller/core_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/auth_view_handle.dart';
import '../../../../../widgets/image_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return AuthHandleView(
      isAuthorized: Get.find<CoreController>().state.userEntity != null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          backgroundColor: context.canvasColor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () => Get.toNamed(AppRoutes.settings),
                icon: const Icon(CupertinoIcons.gear_alt),
              ),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              width: kBottomNavigationBarHeight * 1.5,
                              height: kBottomNavigationBarHeight * 1.5,
                              child: ImageScreen(
                                Get.find<CoreController>()
                                    .state
                                    .userEntity!
                                    .photoURL!,
                                height: kBottomNavigationBarHeight * 1.5,
                                width: kBottomNavigationBarHeight * 1.5,
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 12)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${Get.find<CoreController>().state.userEntity!.followers}',
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      'Followers',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${Get.find<CoreController>().state.userEntity!.following}',
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      'Following',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${Get.find<CoreController>().state.userEntity!.news}',
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      'News',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 12)),
                      Text(
                        Get.find<CoreController>()
                            .state
                            .userEntity!
                            .displayName!,
                        style: context.textTheme.bodyLarge,
                      ),
                      Get.find<CoreController>().state.userEntity!.bio != null
                          ? Text(
                              Get.find<CoreController>().state.userEntity!.bio!,
                              style: context.textTheme.bodyMedium,
                            )
                          : const SizedBox(),
                      const Padding(padding: EdgeInsets.only(bottom: 12)),
                      SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: (context.sizeWidth / 2) - 24,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.primaryColor,
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      'Edit Profile',
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: (context.sizeWidth / 2) - 24,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.primaryColor,
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      'Website',
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: context.primaryColor,
                    labelColor: context.textTheme.bodyLarge?.color,
                    unselectedLabelColor: context.disabledColor,
                    tabs: const [
                      Tab(
                        text: 'News',
                      ),
                      Tab(
                        text: 'Recent',
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: List.generate(
                2,
                (index) => const ImageScreen(
                  'https://img.freepik.com/free-vector/website-construction-background_1361-1388.jpg',
                ),
              ),
            ),
          ),
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
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) => false;
}
