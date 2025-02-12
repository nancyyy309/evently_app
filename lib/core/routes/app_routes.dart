import 'package:evently/core/routes/pages_route_name.dart';
import 'package:evently/modules/layout/map/map_view.dart';
import 'package:flutter/material.dart';
import '../../modules/SignIn/sign_in_view.dart';
import '../../modules/SignUp/sign_up_view.dart';
import '../../modules/Splash/splash_view.dart';
import '../../modules/create_event/create_new_event_view.dart';
import '../../modules/forget_password/forget_password_view.dart';
import '../../modules/layout/layout_view.dart';
import '../../modules/onBoarding/onBoarding_view.dart';

abstract class AppRoutes {
  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRouteName.initial:
        {
          return MaterialPageRoute(
            builder: (context) => const SplashView(),
            settings: settings,
          );
        }

      case PagesRouteName.onBoarding:
        {
          return MaterialPageRoute(
            builder: (context) => const OnBoardingView(),
            settings: settings,
          );
        }

      case PagesRouteName.signIn:
        {
          return MaterialPageRoute(
            builder: (context) => const SignInView(),
            settings: settings,
          );
        }

      case PagesRouteName.signUp:
        {
          return MaterialPageRoute(
            builder: (context) => const SignUpView(),
            settings: settings,
          );
        }

      case PagesRouteName.forgetPassword:
        {
          return MaterialPageRoute(
            builder: (context) => const ForgetPasswordView(),
            settings: settings,
          );
        }

      case PagesRouteName.layout:
        {
          return MaterialPageRoute(
            builder: (context) => const LayoutView(),
            settings: settings,
          );
        }
      case PagesRouteName.createNewEvent:
        {
          return MaterialPageRoute(
            builder: (context) => const CreateNewEventView(),
            settings: settings,
          );
        }
      case PagesRouteName.eventMap:
        {
          return MaterialPageRoute(
            builder: (context) => const MapView(),
            settings: settings,
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (context) => const SplashView(),
            settings: settings,
          );
        }
    }
  }
}