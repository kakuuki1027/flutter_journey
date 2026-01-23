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
        title: 'Flutter Widget Basics',
        youtubeId: '1ukSR1GRtMU',
        description: 'Intro to widgets and layout.',
      ),
      VideoItem(
        id: 'v2',
        title: 'State Management: setState',
        youtubeId: 'SdZby0K1T2o',
        description: 'Simple state with setState.',
      ),
    ];
  }

  @override
  Future<List<LinkItem>> getLinks() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      LinkItem(
        id: 'l1',
        title: 'Flutter Documentation',
        url: 'https://docs.flutter.dev',
      ),
      LinkItem(
        id: 'l2',
        title: 'Dart Language Tour',
        url: 'https://dart.dev/guides',
      ),
    ];
  }

  @override
  Future<List<HubItem>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      HubItem(
        id: 'i1',
        title: 'Learn Layout',
        subtitle: 'Rows, Columns, Flex',
      ),
      HubItem(
        id: 'i2',
        title: 'Navigation',
        subtitle: 'Routes, parameters',
      ),
      HubItem(
        id: 'i3',
        title: 'Networking',
        subtitle: 'HTTP, JSON parsing',
      ),
    ];
  }
}