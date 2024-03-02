import 'package:YOBO_Bot/res/routes/routes_name.dart';
import 'package:get/get.dart';
import '../../view/account/account.dart';
import '../../view/analytics/analytics.dart';
import '../../view/config/update_config.dart';
import '../../view/dashboard/dashboard.dart';
import '../../view/home/home.dart';
import '../../view/login/login_view.dart';
import '../../view/splash/splash_screen.dart';
import '../../view/webchat/webchat.dart';
import '../../view/welcome/welcome_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.welcomeScreen,
          page: () => WelcomeScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.loginView,
          page: () => LoginScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.dashBoard,
          page: () => const DashBoard(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeView,
          page: () => const Home(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.analyticsView,
          page: () => Analytics(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.webChat,
          page: () => const WebChat(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.account,
          page: () => Account(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.updateConfig,
          page: () => const UpdateConfig(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
      ];
}
