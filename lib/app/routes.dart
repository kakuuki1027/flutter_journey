import 'package:flutter_journey/features/auth/auth_controller.dart';
import 'package:flutter_journey/features/auth/login_page.dart';
import 'package:flutter_journey/features/home/home_page.dart';
import 'package:flutter_journey/features/items/item_detail_page.dart';
import 'package:flutter_journey/features/items/items_page.dart';
import 'package:flutter_journey/features/learning/badges_page.dart';
import 'package:flutter_journey/features/videos/video_player_page.dart';
import 'package:flutter_journey/features/videos/videos_page.dart';
import 'package:flutter_journey/features/web/web_links_page.dart';
import 'package:flutter_journey/features/web/webview_page.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(AuthController authController) {
  return GoRouter(
    refreshListenable: authController,
    redirect: (_, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isAuthenticated = authController.isAuthenticated;

      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      if (isAuthenticated && isLoggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginPage()),
      GoRoute(path: '/', builder: (_, _) => const HomePage()),
      GoRoute(path: '/badges', builder: (_, _) => const BadgesPage()),
      GoRoute(path: '/videos', builder: (_, _) => const VideosPage()),
      GoRoute(
        path: '/items/:itemId',
        builder: (_, state) =>
            ItemDetailPage(itemId: state.pathParameters['itemId']!),
      ),
      GoRoute(
        path: '/videos/:youtubeId',
        builder: (_, state) => VideoPlayerPage(
          youtubeId: state.pathParameters['youtubeId']!,
          title: state.uri.queryParameters['title'] ?? '動画',
          lessonId: state.uri.queryParameters['lessonId'] ?? '',
        ),
      ),
      GoRoute(path: '/web', builder: (_, _) => const WebLinksPage()),
      GoRoute(
        path: '/webview',
        builder: (_, state) => WebViewPage(
          url: state.uri.queryParameters['url']!,
          title: state.uri.queryParameters['title'] ?? 'ウェブ',
          lessonId: state.uri.queryParameters['lessonId'] ?? '',
        ),
      ),
      GoRoute(path: '/items', builder: (_, _) => const ItemsPage()),
    ],
  );
}
