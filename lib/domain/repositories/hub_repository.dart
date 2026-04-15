import 'package:flutter_journey/domain/models/hub_item.dart';
import 'package:flutter_journey/domain/models/link_item.dart';
import 'package:flutter_journey/domain/models/video_item.dart';

abstract class HubRepository {
  Future<List<VideoItem>> getVideos();
  Future<List<LinkItem>> getLinks();
  Future<List<HubItem>> getItems();
}