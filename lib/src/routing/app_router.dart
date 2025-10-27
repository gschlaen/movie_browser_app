import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_browser_app/src/common/presentation/widgets/scaffold_with_nav_bar.dart';
import 'package:movie_browser_app/src/features/movies/presentation/home_screen.dart';

enum AppRoute {
  home('home', '/'),
  favorites('favorites', '/favorites'),
  profile('profile', '/profile'),
  movieDetail('movieDetail', 'movie/:id');

  const AppRoute(this.name, this.path);
  final String name;
  final String path;
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.home.path,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: AppRoute.movieDetail.path,
                    name: AppRoute.movieDetail.name,
                    builder: (BuildContext context, GoRouterState state) {
                      final movieId = state.pathParameters['id'];
                      return Text(
                        'Detail Screen Placeholder for movie ID: $movieId',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.favorites.path,
                name: AppRoute.favorites.name,
                builder: (BuildContext context, GoRouterState state) {
                  return const Text('Favorites Screen Placeholder');
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                builder: (BuildContext context, GoRouterState state) {
                  return const Text('Profile Screen Placeholder');
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
