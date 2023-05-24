import 'package:kabar_app_getx/utils/extensions/centext_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/image_screen.dart';
import 'home/presentation/home_view.dart';
import 'profile/presentation/profile_view.dart';
import '../controller/main_menu_controller.dart';
import '../widget/bmnav.dart' as bmnav;

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  List<Widget> screens = [
    const HomeView(),
    const _UC(),
    const _UC(),
    const ProfileView(),
  ];
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMenuController>(
      builder: (MainMenuController c) {
        return Scaffold(
          body:
              PageStorage(bucket: _bucket, child: screens[c.state.currentTab]),
          bottomNavigationBar: bmnav.BottomNav(
            index: c.state.currentTab,
            color: context.bmnavBackgroundColor,
            labelStyle: bmnav.LabelStyle(
              visible: true,
              textStyle: GoogleFonts.poppins(
                color: context.textColor,
              ),
              onSelectTextStyle: TextStyle(
                color: context.bmnavSelectedColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            iconStyle: bmnav.IconStyle(
              color: context.bmnavUnselectedColor,
              onSelectColor: context.bmnavSelectedColor,
            ),
            onTap: (i) {
              c.setScreen(i);
            },
            items: [
              bmnav.BottomNavItem(CupertinoIcons.home, label: 'Home'),
              bmnav.BottomNavItem(CupertinoIcons.compass, label: 'Explore'),
              bmnav.BottomNavItem(CupertinoIcons.bookmark, label: 'Bookmark'),
              bmnav.BottomNavItem(
                CupertinoIcons.profile_circled,
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UC extends StatelessWidget {
  const _UC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.sizeWidth,
        child: ImageScreen(
          'https://img.freepik.com/free-vector/website-construction-background_1361-1388.jpg',
          width: context.sizeWidth,
          height: context.sizeHeight,
        ),
      ),
    );
  }
}
