class VideoItem {
  final String id;
  final String title;
  final String youtubeId; // e.g. "dQw4w9WgXcQ"
  final String description;

  const VideoItem({
    required this.id,
    required this.title,
    required this.youtubeId,
    required this.description,
  });
}