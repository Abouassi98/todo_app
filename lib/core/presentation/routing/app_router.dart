import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/pages/sign_in_screen/sign_in_screen.dart';
import '../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../features/home/presentation/screens/home_shell_screen.dart';
import '../screens/no_internet_screen/no_internet_screen.dart';
import '../screens/route_error_screen/route_error_screen.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../utils/riverpod_framework.dart';
import 'app_router_refresh_listenable.dart';
import 'navigation_transitions.dart';
part 'app_router.g.dart';

// This or other ShellRoutes keys can be used to display a child route on a different Navigator.
// i.e: use the rootNavigatorKey for a child route inside a ShellRoute
// which need to take the full screen and ignore that Shell.
// https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html
final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: const SplashRoute().location,
    routes: [
      // Temporary using generated routes separately to be able to use
      // StatefulShellRoute until it's supported by app_route_builder.
      // TODO: migrate StatefulShellRoute to code gen and use $appRoutes:
      // https://github.com/flutter/flutter/issues/127371
      $splashRoute,
      $noInternetRoute,
      $signInRoute,
      $homeShellRoute,
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated = ref.read(authStateProvider).isSome();
      final allowedRoutes = [
        const SplashRoute().location,
        const NoInternetRoute().location,
        const SignInRoute().location,
      ];

      // If the user is authenticated but still on the login page, send to home.
      if (isAuthenticated &&
          state.location.startsWith(const SignInRoute().location)) {
        return const HomeShellRoute().location;
      }

      if (!isAuthenticated) {
        // Return null (no redirecting) if the route is allowed for
        // unAuthenticated users or else redirect to login page.
        if (allowedRoutes.any(state.location.startsWith)) return null;
        return const SignInRoute().location;
      }

      // Return null (no redirecting) if the user is authenticated.
      return null;
    },
    refreshListenable: ref.watch(appRouterRefreshListenableProvider.notifier),
    errorBuilder: (_, state) => RouteErrorScreen(state.error),
  );
  ref.onDispose(router.dispose);
  return router;
}

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<NoInternetRoute>(path: '/no_internet')
class NoInternetRoute extends GoRouteData {
  const NoInternetRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NoInternetScreen();
}

@TypedGoRoute<SignInRoute>(path: '/login')
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      FadeTransitionPage(state.pageKey, const SignInScreen());
}

@TypedGoRoute<HomeShellRoute>(path: '/home')
class HomeShellRoute extends GoRouteData {
  const HomeShellRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      FadeTransitionPage(state.pageKey, const HomeShellScreen());
}
