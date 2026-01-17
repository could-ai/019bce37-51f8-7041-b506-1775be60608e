class VideoPost {
  final String id;
  final String username;
  final String userAvatarUrl;
  final String videoUrl; // Using image placeholder for now
  final String caption;
  final List<String> tags;
  final int likes;
  final int comments;
  final int shares;
  final String musicTrackName;

  VideoPost({
    required this.id,
    required this.username,
    required this.userAvatarUrl,
    required this.videoUrl,
    required this.caption,
    required this.tags,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.musicTrackName,
  });
}
