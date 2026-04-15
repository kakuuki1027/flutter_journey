import 'package:flutter_journey/domain/models/hub_item.dart';
import 'package:flutter_journey/domain/models/link_item.dart';
import 'package:flutter_journey/domain/models/video_item.dart';
import '../../domain/repositories/hub_repository.dart';

class MockHubRepository implements HubRepository {
  @override
  Future<List<VideoItem>> getVideos() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return const [
      VideoItem(
        id: 'v1',
        title: 'Flutter ウィジェット入門',
        youtubeId: 'x0uinJvhNxI',
        description: 'Widget、BuildContext、基本的なUI構築の考え方を学ぶ。',
      ),
      VideoItem(
        id: 'v2',
        title: 'setState で始める状態管理',
        youtubeId: 'AqCMFXEmf3w',
        description: 'StatefulWidget と setState を使った状態更新の基本。',
      ),
      VideoItem(
        id: 'v3',
        title: 'レイアウト実践: Row / Column / Expanded',
        youtubeId: 'RJEnTRBxa3Y',
        description: 'Flutter レイアウトでよく使う Widget の役割を理解する。',
      ),
      VideoItem(
        id: 'v4',
        title: '画面遷移とルーティング',
        youtubeId: 'JIbIYCM48to',
        description: 'Navigator とルーティングで複数画面をつなぐ考え方。',
      ),
    ];
  }

  @override
  Future<List<LinkItem>> getLinks() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      LinkItem(
        id: 'l1',
        title: 'Flutter 公式ドキュメント',
        url: 'https://docs.flutter.dev',
      ),
      LinkItem(id: 'l2', title: 'Dart 言語ツアー', url: 'https://dart.dev/language'),
      LinkItem(
        id: 'l3',
        title: 'Flutter レイアウト基礎',
        url: 'https://docs.flutter.dev/ui/layout',
      ),
      LinkItem(
        id: 'l4',
        title: 'Flutter 状態管理の基礎',
        url: 'https://docs.flutter.dev/data-and-backend/state-mgmt/simple',
      ),
      LinkItem(
        id: 'l5',
        title: 'Flutter ナビゲーション Cookbook',
        url: 'https://docs.flutter.dev/cookbook/navigation/navigation-basics',
      ),
      LinkItem(
        id: 'l6',
        title: 'Flutter ネットワーク通信 Cookbook',
        url: 'https://docs.flutter.dev/cookbook/networking/fetch-data',
      ),
    ];
  }

  @override
  Future<List<HubItem>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      HubItem(
        id: 'i1',
        title: 'レイアウトの基本',
        subtitle: 'Row、Column、Expanded、Padding の使い分け',
      ),
      HubItem(
        id: 'i2',
        title: 'Widget の種類を理解する',
        subtitle: 'StatelessWidget と StatefulWidget の違い',
      ),
      HubItem(
        id: 'i3',
        title: '画面遷移とルーティング',
        subtitle: 'Navigator、push/pop、引数の受け渡し',
      ),
      HubItem(
        id: 'i4',
        title: 'フォーム入力とバリデーション',
        subtitle: 'TextFormField、Form、validator の基本',
      ),
      HubItem(id: 'i5', title: '状態管理の第一歩', subtitle: 'setState と小さな状態の持ち方'),
      HubItem(
        id: 'i6',
        title: '非同期処理と Future',
        subtitle: 'async/await と FutureBuilder の読み方',
      ),
      HubItem(
        id: 'i7',
        title: 'HTTP と JSON',
        subtitle: 'API 通信、JSON パース、エラーハンドリング',
      ),
      HubItem(id: 'i8', title: 'Provider 入門', subtitle: '画面をまたいだ状態共有の基本パターン'),
    ];
  }
}
