import 'package:flutter_journey/features/home/home_page.dart';
import 'package:flutter_journey/features/items/items_page.dart';
import 'package:flutter_journey/features/videos/video_player_page.dart';
import 'package:flutter_journey/features/videos/videos_page.dart';
import 'package:flutter_journey/features/web/web_links_page.dart';
import 'package:flutter_journey/features/web/webview_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => const HomePage()),
    GoRoute(path: '/videos', builder: (_, _) => const VideosPage()),
    GoRoute(
      path: '/videos/:youtubeId',
      builder: (_, state) => VideoPlayerPage(
        youtubeId: state.pathParameters['youtubeId']!,
        title: state.uri.queryParameters['title'] ?? 'Video',
      ),
    ),
    GoRoute(path: '/web', builder: (_, _) => const WebLinksPage()),
    GoRoute(
      path: '/webview',
      builder: (_, state) => WebViewPage(
        url: state.uri.queryParameters['url']!,
        title: state.uri.queryParameters['title'] ?? 'Web',
      ),
    ),
    GoRoute(path: '/items', builder: (_, _) => const ItemsPage()),
  ]
);