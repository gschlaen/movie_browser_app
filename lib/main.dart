import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_browser_app/design_system/foundations.dart';
import 'package:movie_browser_app/src/common/api/favorites_repository.dart';
import 'package:movie_browser_app/src/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        favoritesRepositoryProvider.overrideWithValue(
          FavoritesRepository(prefs),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return GestureDetector(
      // Dismiss keyboard when tapping anywhere outside a TextField
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: MaterialApp.router(
        routerConfig: goRouter,
        title: 'Movie Browser',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          useMaterial3: true,
          textTheme: Typography.whiteMountainView,
        ),
      ),
    );
  }
}
