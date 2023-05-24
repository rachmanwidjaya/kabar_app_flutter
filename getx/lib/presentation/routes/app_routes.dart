part of 'app_pages.dart';

abstract class AppRoutes {
  static const String root = '/';
  static const String _read = '/read/';
  static const String _search = '/search/';
  static const String _tag = '/tag/';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String login = '/login';
  static String readPage(String target) => '$_read?target=$target';
  static String searchPage(String keyword) => '$_search?keyword=$keyword';
  static String tagPage(String target) => '$_tag?target=$target';
}
