/// A post of the wall, with its author, its image and its likes already resolved.
class Post {
  final String id;
  final String content;
  final DateTime createdAt;
  final String authorUsername;
  final String authorName;
  final String? authorAvatarUrl;
  final String? imagePath;
  final String? imageUrl;
  final int likeCount;
  final bool likedByMe;

  const Post({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.authorUsername,
    required this.authorName,
    this.authorAvatarUrl,
    this.imagePath,
    this.imageUrl,
    required this.likeCount,
    required this.likedByMe,
  });

  Post copyWith({int? likeCount, bool? likedByMe, String? imageUrl}) {
    return Post(
      id: id,
      content: content,
      createdAt: createdAt,
      authorUsername: authorUsername,
      authorName: authorName,
      authorAvatarUrl: authorAvatarUrl,
      imagePath: imagePath,
      imageUrl: imageUrl ?? this.imageUrl,
      likeCount: likeCount ?? this.likeCount,
      likedByMe: likedByMe ?? this.likedByMe,
    );
  }

  @override
  String toString() {
    return 'Post($id, @$authorUsername, likes: $likeCount)';
  }
}
