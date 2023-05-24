import 'package:get/get.dart';

import '../core/presentation/not_found/presentation/not_found_view.dart';
import '../middleware/auth_middleware.dart';
import '../middleware/is_authorized_middleware.dart';
import '../modules/login/presentation/login_view.dart';
import '../modules/main_menu/controller/main_menu_binding.dart';
import '../modules/main_menu/presentation/main_menu_view.dart';
import '../modules/read/controller/read_binding.dart';
import '../modules/read/presentation/read_view.dart';
import '../modules/search/controller/search_binding.dart';
import '../modules/search/presentation/search_view.dart';
import '../modules/main_menu/presentation/settings/controller/setting_binding.dart';
import '../modules/main_menu/presentation/settings/presentation/settings_view.dart';
import '../modules/tags/controller/tag_binding.dart';
import '../modules/tags/presentation/tags_view.dart';

part 'app_routes.dart';

class AppPages extends AppRoutes {
  static const inital = AppRoutes.root;

  static final routes = [
    GetPage(
      name: AppRoutes.root,
      page: () => const MainMenuView(),
      binding: MainMenuBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes._read,
      page: () => const ReadView(),
      binding: ReadgBinding(),
    ),
    GetPage(
      name: AppRoutes._search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRoutes._tag,
      page: () => const TagView(),
      binding: TagBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      middlewares: [
        IsAuththorizedMiddleware(),
      ],
    ),
  ];

  static GetPage get notFound => GetPage(
        name: '/not_found',
        page: () => const NotFoundView(),
      );
}
