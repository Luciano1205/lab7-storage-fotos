import 'package:moviles_auth/features/auth/domain/entities/profile.dart';
import 'package:moviles_auth/features/posts/domain/entities/post.dart';

enum FeedStatus { initial, loading, success, failure }

enum AvatarStatus { idle, uploading, failure }

/// Single state of the home: the profile, its photo, the wall and the latest posts.
class FeedState {
  final FeedStatus status;
  final Profile? profile;
  final AvatarStatus avatarStatus;
  final List<Post> posts;
  final List<Post> myPosts;
  final int page;
  final bool hasMore;
  final String? errorMessage;
  final bool signedOut;

  const FeedState({
    this.status = FeedStatus.initial,
    this.profile,
    this.avatarStatus = AvatarStatus.idle,
    this.posts = const [],
    this.myPosts = const [],
    this.page = 0,
    this.hasMore = true,
    this.errorMessage,
    this.signedOut = false,
  });

  FeedState copyWith({
    FeedStatus? status,
    Profile? profile,
    AvatarStatus? avatarStatus,
    List<Post>? posts,
    List<Post>? myPosts,
    int? page,
    bool? hasMore,
    String? errorMessage,
    bool? signedOut,
  }) {
    return FeedState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      avatarStatus: avatarStatus ?? this.avatarStatus,
      posts: posts ?? this.posts,
      myPosts: myPosts ?? this.myPosts,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
      signedOut: signedOut ?? this.signedOut,
    );
  }

  @override
  String toString() {
    return 'FeedState(status: ${status.name}, profile: ${profile?.username}, '
        'avatar: ${avatarStatus.name}, '
        'posts: ${posts.length}, '
        'myPosts: ${myPosts.length}, page: $page, hasMore: $hasMore, '
        'signedOut: $signedOut, error: $errorMessage)';
  }
}
