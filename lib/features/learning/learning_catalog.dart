import 'package:flutter_journey/data/mock/mock_hub_repository.dart';
import 'package:flutter_journey/domain/models/learning_lesson.dart';

class LearningCatalog {
  static Future<List<LearningLesson>> build() async {
    final repository = MockHubRepository();
    final items = await repository.getItems();
    final videos = await repository.getVideos();
    final links = await repository.getLinks();

    return [
      for (final item in items)
        LearningLesson(id: item.id, title: item.title, category: 'リポジトリ'),
      for (final video in videos)
        LearningLesson(id: video.id, title: video.title, category: '動画'),
      for (final link in links)
        LearningLesson(id: link.id, title: link.title, category: 'ウェブ'),
    ];
  }
}
