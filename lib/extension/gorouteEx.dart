import 'package:go_router/go_router.dart';

import '../utils/LogUtil.dart';

extension gorouteEx on GoRouter {
  Uri Location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    LogUtil.e("location:${location}");
    return matchList.uri;
  }
}
