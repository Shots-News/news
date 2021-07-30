import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Widget screen,
      {dynamic arguments, int? duration, PageTransitionType? transition, Widget? childCurrent}) {
    return navigatorKey.currentState!.push(_materialRoute(
      screen,
      arguments: arguments,
      transition: transition,
      childCurrent: childCurrent,
      duration: duration,
    ));
  }

  Future<dynamic> replaceTo(Widget screen, {dynamic arguments}) {
    return navigatorKey.currentState!.pushReplacement(_materialRoute(screen, arguments: arguments));
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  _materialRoute(Widget screen, {dynamic arguments, PageTransitionType? transition, int? duration, Widget? childCurrent}) {
    return PageTransition(
      child: screen,
      settings: RouteSettings(arguments: arguments),
      type: transition ?? PageTransitionType.rightToLeft,
      duration: Duration(milliseconds: duration ?? 500),
      childCurrent: childCurrent,
    );
  }
}
