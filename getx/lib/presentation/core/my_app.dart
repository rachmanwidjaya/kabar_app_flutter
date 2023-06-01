import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/resources/app_theme.dart';
import '../../data/repository_impl/auth/dummy_auth_repository_impl.dart';
import '../../data/repository_impl/local_config.dart';
import '../../data/repository_impl/remote_config/dummy_remote_config_repository_impl.dart';
import '../routes/app_pages.dart';
import '../widgets/auth_view_handle.dart';
import 'controller/core_binding.dart';
import 'controller/core_controller.dart';
import 'presentation/app_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    CoreBinding(
      authRepository: DummyAuthRepositiryImpl(
        token: LocalConfig.instance.token,
      ),
      remoteConfigRepository: DumyRemoteConfigRepositoryImpl(),
    ).dependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreController>(
      builder: (CoreController c) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kabar',
          theme: LocalConfig.instance.darkTheme
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          getPages: AppPages.routes,
          initialRoute: AppPages.inital,
          builder: (context, child) => AppView(
            state: c.state,
            child: AuthHandleView(
              isAuthorized: c.state.userEntity != null,
              child: child,
            ),
          ),
          unknownRoute: AppPages.notFound,
        );
      },
    );
  }
}
